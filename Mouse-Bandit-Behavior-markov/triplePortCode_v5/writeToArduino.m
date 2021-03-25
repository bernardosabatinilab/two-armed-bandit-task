%%
% writeToArduino.m
%
% This function will write a string followed by a '\n' (newline) character,
% to an Arduino over a serial port. It writes them synchronously, meaning
% that MATLAB will pause execution until the bytes are actually written.
%
% OM 1/2016

function writeToArduino(messageChar, arg1, arg2)
    global arduinoPort

    stringToSend = sprintf('%s %d %d',messageChar, arg1, arg2);
    fprintf(arduinoPort,'%s\n',stringToSend, 'sync');

    % % DEBUGING
    % disp(['To Arduino: "', stringToSend, '"' ]);

