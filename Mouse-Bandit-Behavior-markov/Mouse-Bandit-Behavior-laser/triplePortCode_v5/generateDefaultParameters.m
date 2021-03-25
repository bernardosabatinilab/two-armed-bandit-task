function defaultParams = generateDefaultParameters(varargin)

%% Populate paramArray with the paramter names and their default values
paramArray = [];

p.pName= 'centerPokeTrigger';
p.pVal= 1;
p.pComment= 'boolean (1 or 0); Require poke in center to trigger reward?';
paramArray = [paramArray; p];

p.pName= 'centerPokeRewardWindow';
p.pVal= 10;
p.pComment= 'in sec; time after center poke that side ports are active';
paramArray = [paramArray; p];

p.pName= 'ledDuringRewardWindow';
p.pVal= 1;
p.pComment= 'boolean (1 or 0); Turn center LED on during reward window?';
paramArray = [paramArray; p];


p.pName= 'leftRewardProb';
p.pVal= 0.5;
p.pComment= '';
paramArray = [paramArray; p];

p.pName= 'rightRewardProb';
p.pVal= 0.5;
p.pComment= '';
paramArray = [paramArray; p];

p.pName= 'rewardDurationRight';
p.pVal= 50;
p.pComment= 'in ms; duration of open solenoid';
paramArray = [paramArray; p];

p.pName= 'rewardDurationLeft';
p.pVal= 50;
p.pComment= 'in ms; duration of open solenoid';
paramArray = [paramArray; p];

p.pName= 'minInterTrialInterval';
p.pVal= 2;
p.pComment= 'in sec; minimum time between rewards (manditory deactivation of ports)';
paramArray = [paramArray; p];

p.pName= 'blockRangeMin';
p.pVal= 1000;
p.pComment= 'minumum block size';
paramArray = [paramArray; p];

p.pName= 'blockRangeMax';
p.pVal= 1000;
p.pComment= 'maximum block size';
paramArray = [paramArray; p];




%% Clean up paramArray

% remove commas from comments (replace with semi-colon)
for i=1:length(paramArray)
    paramArray(i).pComment = strrep(paramArray(i).pComment, ',', ';');
end


%% Output default parameters in appropriate format
defaultParams = [];

if isempty(varargin)
    % if called directly by the user with no arguments, then
    % save the default params as a .csv in a user-sepcified location
    defaultParams = struct2table(paramArray);
    [FileName,PathName] = uiputfile( '*.csv','Save new parameters file', 'triplePortParameters.csv');
    paramFileName = fullfile(PathName,FileName);
    writetable(defaultParams,paramFileName);

else
    type = varargin{1};
    if strcmp(type, 'array')
        defaultParams = paramArray;
    elseif strcmp(type, 'table')
        defaultParams = struct2table(paramArray);
    elseif strcmp(type, 'struct')
        defaultParams = [];
        for i = 1:length(paramArray)
            defaultParams.(paramArray(i).pName) = paramArray(i).pVal; % store parameters in structure 'defaultParams'
        end
    end
end
