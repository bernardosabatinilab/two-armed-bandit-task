function runTriplePortExperiment(varargin)

global arduinoConnection arduinoPort
global arduinoMessageString

global p % parameter structure

%% load parameters from file
parameterFileName = '';
if (nargin > 0) % check for parameter file path as input argument
    parameterFileName = varargin{1};
end
[p, parameterFileName] = loadParametersFile(parameterFileName);


%% Setup

% cleanup routine to be executed even if this function is terminated early
finishup = onCleanup(@triplePortCleanup);

% seed random number generator (to prevent repeating the same values on
% different experiments)
rng('shuffle');

% set up logging
[pathstr,name,ext] = fileparts(parameterFileName);
% default name/path for log files is the same as paramters file
% but replace 'param(s)'/'parameters(s)' with 'Log' in file name
name = regexprep(name,'[Pp]aram(eter)?(s)?(?=$|[^a-z])','Log');
logFileName = fullfile(pathstr,name);
setupLogging(logFileName);


% log all paramters and inital values
fn = fieldnames(p);
for i=1:length(fn)
    fName = fn{i};
    logValue(fName,p.(fName));
end
rngState = rng;
logValue('RNG Seed', rngState.Seed);
logValue('RNG Type', rngState.Type);


% set up Arduino
arduinoMessageString = '';
clearPorts();
arduinoPortNum = findArduinoPort();
if ~arduinoPortNum
    disp('Can''t find serial port with Arduino')
    return
end
arduinoConnection = 0;
arduinoPort = setupArduinoSerialPort(arduinoPortNum);
% wait for Arduino startup
fprintf('Waiting for Arduino startup')
while (arduinoConnection == 0)
    fprintf('.');
    pause(0.5);
end
fprintf('\n')



%% setup ports/arduino
global centerPort rightPort leftPort

centerPort = NosePort(5,13);
centerPort.setLEDPin(8);
centerPort.deactivate();
centerPort.noseInFunc = @centerPortPokeFunc;
logValue('center port ID', centerPort.portID);

rightPort = NosePort(7,4);
rightPort.setRewardDuration(p.rewardDurationRight);
rightPort.rewardFunc = @rewardFunc;
rightPort.noseOutFunc = @endTrial;
rightPort.noseInFunc = @noseIn;
logValue('right port ID', rightPort.portID);

leftPort = NosePort(6,3);
leftPort.setRewardDuration(p.rewardDurationLeft);
leftPort.rewardFunc = @rewardFunc;
leftPort.noseOutFunc = @endTrial;
leftPort.noseInFunc = @noseIn;
logValue('left port ID', leftPort.portID);


if p.centerPokeTrigger
    rightPort.deactivate();
    leftPort.deactivate();
else
    rightPort.activate();
    leftPort.activate();
    centerPort.ledOn();
end


%% run trials - haven't solved this.
global currBlockReward blockRange
currBlockReward = 0;
blockRange = p.blockRange;
currBlockSize = randi([min(blockRange),max(blockRange)]);
%currBlockSize = exprnd(blockSize);
display(currBlockSize)

global pokeHistory pokeCount
pokeCount = 0;
pokeHistory= struct;

global iti lastPokeTime
iti = p.minInterTrialInterval;
lastPokeTime = datevec(now);

%create stats structure for online analysis and visualization
global stats
% initialize the first entry of stats to be zeros
stats = initializestats;
cumstats = cumsumstats(stats);
%create figure for onilne visualization
global h psL psR
h = initializestatsfig(cumstats);
%initialize plotly fig
[psL,psR] = initializeplotlyfig();
psL.open();
psR.open();


%% run the program.....
while true
    pause(1)
end

end

%% Subfunctions


%% Nose In Functions
function centerPortPokeFunc(portID)
disp('centerPortPokeFunc')
noseIn(portID);

global p pokeHistory pokeCount
global activateLeft activateRight

if p.centerPokeTrigger % if we're in centerPokeTrigger mode
    %see if we are currently in a trial
    %Note   isTRIAL == 1 means that centerPort has correctly initiated trial
           %isTRIAL == 0 means that the poke is 'incorrect' and not a trial
           %isTRIAL == 2 means that the poke is a decision poke           
    if pokeHistory(pokeCount).isTRIAL == 1;
        %activate side ports with appropriate probs
        activateLeft = (rand <= p.leftRewardProb); % activate left port with prob = p.leftRewardProb
        activateRight = (rand <= p.rightRewardProb); % activate right port with prob = p.rightRewardProb
        activateSidePortsForDuration(activateLeft, activateRight, p.centerPokeRewardWindow);
    end
end
end

function noseIn(portID)
disp('noseIn')
global p
global pokeHistory pokeCount lastPokeTime 
global rightPort leftPort centerPort
global activateLeft activateRight
global stats
global iti
global h psL psR

pokeCount = pokeCount+1; %increment pokeCount
timeSinceLastPoke = etime(datevec(now),lastPokeTime);

%Update pokeHistory
pokeHistory(pokeCount).timeStamp = now;
if portID == rightPort.portID
    pokeHistory(pokeCount).portPoked = 'rightPort';
elseif portID == leftPort.portID
    pokeHistory(pokeCount).portPoked = 'leftPort';
elseif portID == centerPort.portID
    pokeHistory(pokeCount).portPoked = 'centerPort';
end

%first need to deal with special case of first poke
if pokeCount == 1
    if portID == centerPort.portID
        pokeHistory(pokeCount).isTRIAL = 1;
    else
        pokeHistory(pokeCount).isTRIAL = 0;
    end
%if this is a left or right port, there is a possibility this is the
%decision poke of a trial. If so, there's a bunch of info we need.
elseif portID == rightPort.portID || portID == leftPort.portID
    %check to see if we are in a trial.
    if pokeHistory(pokeCount-1).isTRIAL == 1
        %if we are in a trial, check to see if we are within the
        %response time (p.centerPokeRewardWindow). If so, set
        %pokeHistory.isTrial to 2 (which denotes that this is a
        %decision poke), and set the pokeHistory.trialTime as the time
        %elapsed from the trial iniation (last poke) to now.
        if timeSinceLastPoke <= p.centerPokeRewardWindow
            pokeHistory(pokeCount).isTRIAL = 2;
            pokeHistory(pokeCount).trialTime = etime(datevec(now),lastPokeTime);
            pokeHistory(pokeCount).leftPortStats.prob = p.leftRewardProb;
            pokeHistory(pokeCount).rightPortStats.prob = p.rightRewardProb;
            pokeHistory(pokeCount).leftPortStats.ACTIVATE = activateLeft;
            pokeHistory(pokeCount).rightPortStats.ACTIVATE = activateRight;
        else %if reward window is passed, than this is not a trial poke
            pokeHistory(pokeCount).isTRIAL = 0;
        end
    else %if we're not in a trial then any left or right poke is an error poke.
        pokeHistory(pokeCount).isTRIAL = 0;
    end
    %finally have to deal with the center pokes
elseif portID == centerPort.portID
    pokeHistory(pokeCount-1).isTRIAL
    if pokeHistory(pokeCount-1).isTRIAL == 0 || pokeHistory(pokeCount-1).isTRIAL == 2
        if timeSinceLastPoke >= iti
            pokeHistory(pokeCount).isTRIAL = 1;
        else
            pokeHistory(pokeCount).isTRIAL = 0;
        end
    elseif pokeHistory(pokeCount-1).isTRIAL == 1
        if timeSinceLastPoke < p.centerPokeRewardWindow
            pokeHistory(pokeCount).isTRIAL = 0;
        elseif timeSinceLastPoke >= iti
            pokeHistory(pokeCount).isTRIAL = 1;
        else
            pokeHistory(pokeCount).isTRIAL = 0;
        end
    end
end
%in order to run update stats, we need a value for pokeHistory.REWARD
pokeHistory(pokeCount).REWARD = 0;

%update stats and refresh figures
stats = updatestats(stats,pokeHistory(pokeCount),pokeCount);
cumstats = cumsumstats(stats);
updatestatsfig(cumstats,h,pokeCount);

%update plotly fig
updateplotlyfig(psL,psR,cumstats,pokeCount);

%update the lastPokeTime
lastPokeTime = datevec(now);

end

%% Activate / deactivate side port functions

function activateSidePortsForDuration(activateLeft, activateRight, rewardWindow)
disp(sprintf('activateSidePorts:  R:%g  L:%g', activateRight, activateLeft));
global rightPort leftPort deactivateTimer

% activate only the desired port(s)
if activateRight
    rightPort.activate();
end
if activateLeft
    leftPort.activate();
end
deactivateTimer = executeFunctionWithDelay(@deactivateSidePorts, rewardWindow);
end

function activateBothSidePorts()
disp('activateBothSidePorts')
global rightPort leftPort centerPort
rightPort.activate();
leftPort.activate();
centerPort.ledOn(); %Shay: I put this here so that the LED is always on
%when the ports are activated.
end

function deactivateSidePorts()
disp('deactivateSidePorts')
global rightPort leftPort centerPort deactivateTimer p
try
    stop(deactivateTimer)
end
rightPort.deactivate();
leftPort.deactivate();
end

%% Reward Function
function rewardFunc(portID)
disp('rewardFunc')
global p reactivateTimer
global pokeHistory pokeCount stats
global h
global currBlockReward blockRange currBlockSize
global centerPort

centerPort.ledOn();
executeFunctionWithDelay(@centerPort.ledOff,2);

currBlockReward = currBlockReward + 1;
display(currBlockReward)

% log rewarded port to poke history
pokeHistory(pokeCount).REWARD = 1;
%update stats and refresh figures
stats = updatestats(stats,pokeHistory(pokeCount),pokeCount);
cumstats = cumsumstats(stats);
updatestatsfig(cumstats,h,pokeCount);

if p.centerPokeTrigger % if we're in centerPokeTrigger mode
    deactivateSidePorts();
else
    % deactive; wait x seconds; reactive
    deactivateSidePorts();
    reactivateTimer = executeFunctionWithDelay(@activateBothSidePorts, p.minInterTrialInterval);
end

%reupdate reward probabilities if needed.
if currBlockReward >= currBlockSize
    p.leftRewardProb = 1 - p.leftRewardProb;
    p.rightRewardProb = 1 - p.rightRewardProb;
    currBlockReward = 0;
    currBlockSize = randi([min(blockRange),max(blockRange)]);
    display('Reward Probabilities Switched')
    display('Left Reward Prob:')
    p.leftRewardProb
    display('Right Reward Prob:')
    p.rightRewardProb
end


end

%% End Trial Function
function endTrial()
global p
if p.centerPokeTrigger % if we're in centerPokeTrigger mode
    disp('endTrial')
    deactivateSidePorts();
end
end

%% cleanup function is run when program ends (either naturally or after ctl-c)
function triplePortCleanup()
disp('Cleaning up...')

%turn LED off
global centerPort
centerPort.ledOff();

%close log file
global logFileID AllNosePorts
fclose(logFileID);

%close plotly stream
global psL psR
psL.close();
psR.close();

%deactivate any nose ports (just to make sure)
for n = AllNosePorts
    n{1}.deactivate();
end
AllNosePorts = {};
clearPorts(); %clear nose ports

% prompt user to select directory to save pokeHistory
prompt = 'Save pokeHistory and stats? (y/n): ';
prompt_ans = input(prompt,'s');
if strcmpi(prompt_ans,'y')
    global pokeHistory stats
    folderName = uigetdir;
    cd(folderName);
    currDay = datestr(date);
    save(strcat('pokeHistory',currDay,'.mat'),'pokeHistory');
    save(strcat('stats',currDay,'.mat'),'stats');
    savefig('stats.fig');
end
close all
end

