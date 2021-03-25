% findArduinoPort()
% This fuction examines the list of all available serial ports and tries to
% find the one that has an arduino connected to it. It returns the index of
% that port.
%
% OM 1/2016

function port = findArduinoPort()

serialInfo = instrhwinfo('serial');
archstr = computer('arch');

port = [];
for portN = 1:length(serialInfo.AvailableSerialPorts)
    portName = serialInfo.AvailableSerialPorts{portN};
    if strcmp(archstr,'maci64')
        if strfind(portName,'usbmodem') % this works for mac, not sure about PC
            port = portN;
            return
        end
    else
      if strfind(portName, 'COM4') % 4 for shay's comp, 5 for NUC, 6 for new behavior rig? 3 for box3?
        port = portN;
        return
      end
    end
end

