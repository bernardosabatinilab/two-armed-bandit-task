%%
% readFromArduino.m
%
% This function is executed whenever MATLAB
% detects bytes available on the arduino serial port.
%
% This function reads in any available characters and calls
% arduinoMessageString() to act on all newline (\n) terminated messages.
%
% OM 1/2016
function readFromArduino(obj, event)
    arduinoPort = obj;

    global arduinoMessageString

    % As long as there are still bytes to be read in the buffer...
    while (arduinoPort.BytesAvailable > 0)
        charIn = char(fread(arduinoPort,1,'char'));
        if (charIn == char(10))
            interpretArduinoMessage(arduinoMessageString);
            arduinoMessageString = '';
            return % only process <= 1 message per function call
        elseif (charIn ~= char(13))
            arduinoMessageString = [arduinoMessageString charIn];
        end
    end
