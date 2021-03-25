%% 
% listPorts.m
%
% This function will list all the serial ports MATLAB can find.
% 
% JSB 5/2014
function listPorts()

    % Get info about all the serial ports
    serialInfo = instrhwinfo('serial');
    % Display the name of each one:d
    for portN = 1:length(serialInfo.AvailableSerialPorts)
        disp(['Port ',num2str(portN),': ',...
             serialInfo.AvailableSerialPorts{portN}]);
    end