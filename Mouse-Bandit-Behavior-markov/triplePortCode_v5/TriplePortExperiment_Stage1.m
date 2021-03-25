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
rightPort.setLEDPin(9);
rightPort.setRewardDuration(p.rewardDurationRight);
rightPort.setToSingleRewardMode();
rightPort.rewardFunc = @rewardFunc;
rightPort.noseOutFunc = @endTrial;
rightPort.noseInFunc = @noseIn;
logValue('right port ID', rightPort.portID);

leftPort = NosePort(6,3);
leftPort.setLEDPin(10);
leftPort.setRewardDuration(p.rewardDurationLeft);
leftPort.setToSingleRewardMode();
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
end


%% run trials
global currBlockReward blockRange currBlockSize
currBlockReward = 0;
blockRange = p.blockRange;
currBlockSize = randi([min(blockRange),max(blockRange)]);
%currBlockSize = exprnd(blockSize);
display(currBlockSize)

global pokeHistory pokeCount currPokeCount ratioVector currRatio
pokeCount = 0;
pokeHistory= struct;
currPokeCount = 0;
currRatio = 1;
ratioVector = 1:6;

global iti lastPokeTime
iti = p.minInterTrialInterval;
lastPokeTime = datevec(now);

%create stats structure for online analysis and visualization
global stats
% initialize the first entry of stats to be zeros
stats = initializestats;
cumstats = cumsumstats(stats);
%create figure for onilne visualization
global h
h = initializestatsfig(cumstats);


%% run the program.....
while true
    pause(1)
end

end

%% Subfunctions


%% Nose In Functions
function noseIn(portID)
disp('noseIn')
global p
global pokeHistory pokeCount lastPokeTime 
global rightPort leftPort centerPort
global activateLeft activateRight
global stats
global iti
global h
global currPokeCount

pokeCount = pokeCount+1; %increment pokeCount

%Update pokeHistory
pokeHistory(pokeCount).timeStamp = now;
if portID == rightPort.portID
    pokeHistory(pokeCount).portPoked = 'rightPort';
elseif portID == leftPort.portID
    pokeHistory(pokeCount).portPoked = 'leftPort';
elseif portID == centerPort.portID
    pokeHistory(pokeCount).portPoked = 'centerPort';
end

%Update currPokeCount
currPokeCount = currPokeCount + 1;

%update the lastPokeTime
lastPokeTime = datevec(now);

end


function centerPortPokeFunc(portID)
disp('centerPortPokeFunc')
noseIn(portID);

global p pokeHistory pokeCount
global activateLeft activateRight
global centerPort rightPort leftPort

if p.centerPokeTrigger % if we're in centerPokeTrigger mode
    %see if we are currently in a trial
    %Note   isTRIAL == 1 means that centerPort has correctly initiated trial
           %isTRIAL == 0 means that the poke is 'incorrect' and not a trial
           %isTRIAL == 2 means that the poke is a decision poke           
    if pokeHistory(pokeCount).isTRIAL == 1;
        centerPort.ledOff();
        leftPort.ledOn();
        rightPort.ledOn();
        executeFunctionWithDelay(@rightPort.ledOff,p.centerPokeRewardWindow);
        executeFunctionWithDelay(@leftPort.ledOff,p.centerPokeRewardWindow);
        %activate side ports with appropriate probs
        activateLeft = (rand <= p.leftRewardProb); % activate left port with prob = p.leftRewardProb
        activateRight = (rand <= p.rightRewardProb); % activate right port with prob = p.rightRewardProb
        activateSidePortsForDuration(activateLeft, activateRight, p.centerPokeRewardWindow);
    end
end
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
global rightPort leftPort
rightPort.activate();
leftPort.activate();
end

function deactivateSidePorts()
disp('deactivateSidePorts')
global rightPort leftPort deactivateTimer
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
global rightPort leftPort

rightPort.ledOn();
leftPort.ledOn();
executeFunctionWithDelay(@rightPort.ledOff,1);
executeFunctionWithDelay(@leftPort.ledOff,1);
currBlockReward = currBlockReward + 1;
display(currBlockReward)

deactivateSidePorts();
reactivateTimer = executeFunctionWithDelay(@activateBothSidePorts, p.minInterTrialInterval);

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

%deactivate any nose ports (just to make sure)
for n = AllNosePorts
    n{1}.deactivate();
end
AllNosePorts = {};
clearPorts(); %clear nose ports

% prompt user to select directory to save pokeHistory
prompt = 'Save pokeHistory and stats? (y/n): ';
prompt_ans = input(prompt,'s');
if strcmpi(prompt_ans,'n')
else
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

