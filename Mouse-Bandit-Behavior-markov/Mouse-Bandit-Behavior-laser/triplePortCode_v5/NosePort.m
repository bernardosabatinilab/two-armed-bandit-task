classdef NosePort  < handle
    %NOSEPORT The Matlab representation of an Arduino-controlled nose port
    %   Detailed explanation goes here

    properties
        portID = 0;
        beambreakPin = 0;
        solenoidPin = 0;
        ledPin = 0;
        ledState = 0;
        laserPin = 0;
        laserActive = 0;
        noseInFunc = [];
        noseOutFunc = [];
        rewardFunc = [];
        laserOnFunc = [];
        laserOffFunc = [];
    end

    methods
        %% constructor
        function obj = NosePort(beambreakPin, solenoidPin)
            global newPortID
            newPortID = 0;
            writeToArduino('N', beambreakPin, solenoidPin);
            while newPortID==0
                pause(0.1)
            end
            obj.portID = newPortID;
            obj.solenoidPin = solenoidPin;
            obj.beambreakPin = beambreakPin;
            
            % create a global list of all NosePorts indexed by portID
            global AllNosePorts
            AllNosePorts{newPortID} = obj;
        end

        %% Reward & nose detection methods
        function setToSingleRewardMode(obj)
            obj.arduinoCommand('S',1);
        end
        function setToMutliRewardMode(obj)
            obj.arduinoCommand('S',0);
        end
        function activate(obj)
            obj.arduinoCommand('A',1);
        end
        function deactivate(obj)
            obj.arduinoCommand('A',0);
        end
        function setRewardDuration(obj, duration)
            obj.arduinoCommand('D',duration);
        end
        function deliverReward(obj)
            obj.arduinoCommand('R',0);
        end
        function noseIn(obj)
            if isa(obj.noseInFunc,'function_handle')
                feval(obj.noseInFunc, obj.portID);
            end
        end
        function noseOut(obj)
            if isa(obj.noseOutFunc,'function_handle')
                feval(obj.noseOutFunc);
            end
        end
        function reward(obj)
            if isa(obj.rewardFunc,'function_handle')
                feval(obj.rewardFunc,obj.portID);
            end
        end

        %% LED methods
        function setLEDPin(obj, pin)
            obj.ledPin = pin;
            obj.arduinoCommand('L', pin);
        end
        function ledOn(obj)
            if obj.ledState==0
                obj.arduinoCommand('O', 0);
                obj.ledState = 1;
                logValue('LED On', obj.portID);
            end
        end
        function ledOff(obj)
            if obj.ledState==1
                obj.arduinoCommand('F', 0);
                obj.ledState = 0;
                logValue('LED Off', obj.portID);
            end
        end

        %% Laser methods
        function setLaserPin(obj, pin)
            obj.laserPin = pin;
            obj.arduinoCommand('P', pin);
        end
        function setLaserDelay(obj, delay)
            obj.arduinoCommand('Y', delay);
        end
        function setLaserStimDuration(obj, duration)
            obj.arduinoCommand('T', duration);
        end
        function setLaserPulseDuration(obj, pulseDur)
            obj.arduinoCommand('U', pulseDur);
        end
        function setLaserPulsePeriod(obj, pulsePeriod)
            obj.arduinoCommand('I', pulsePeriod);
        end
        function activateLaser(obj)
            obj.arduinoCommand('V', 1);
        end
        function deactivateLaser(obj)
            obj.arduinoCommand('V', 0);
        end
        function laserOn(obj)
            if isa(obj.laserOnFunc,'function_handle')
                feval(obj.laserOnFunc, obj.portID);
            end
        end
        function laserOff(obj)
            if isa(obj.laserOffFunc,'function_handle')
                feval(obj.laserOffFunc, obj.portID);
            end
        end

        %% arduinoCommand method
        function arduinoCommand(obj, messageChar, value)
            writeToArduino(messageChar, obj.portID, value)
        end
    end

end

