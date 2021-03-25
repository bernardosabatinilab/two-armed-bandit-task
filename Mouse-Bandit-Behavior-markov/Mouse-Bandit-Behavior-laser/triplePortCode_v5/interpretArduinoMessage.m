
function interpretArduinoMessage(messageString)
global arduinoConnection newPortID
global AllNosePorts

%fprintf('#%s#\n',messageString);
messageString = strtrim(messageString);
%fprintf('##%s##\n',messageString);

messageType = messageString(1);
portNum = [];
if length(messageString) > 1
    portNum = str2num(messageString(2:end));
end

switch messageType
    case 'S'
        % Arduino startup
        arduinoConnection = 1;
        logEvent('Arduino connection established');
    case 'N'
        % New poke initialized
        newPortID = portNum;
        logValue('New poke initialized',portNum);
    case 'I'
        % Nose in
        logValue('Nose in', portNum);
        noseIn = 1;
        AllNosePorts{portNum}.noseIn();
        %lastPokeTime = clock;
    case 'O'
        % Nose out
        logValue('Nose out', portNum);
        noseIn = 0;
        AllNosePorts{portNum}.noseOut();
    case 'R'
        % Rewarded poke
        logValue('Reward delivered', portNum);
        AllNosePorts{portNum}.reward();
        %rewardArray = [rewardArray, 1];

    case 'L'
        % Laser stim started
        logValue('Laser on', portNum);
        AllNosePorts{portNum}.laserOn();
    case 'l'
        % Laser stim ended
        logValue('Laser off', portNum);
        AllNosePorts{portNum}.laserOff();


    case '#'
        % Error
        logEvent('Arduino ERROR');
        fprintf('\nERROR: Arduino error code.\n\n');
    otherwise
        % unknown input
        disp(messageType)
        logValue('Unknown input from Arduino',messageString);
end
