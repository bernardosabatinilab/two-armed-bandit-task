%% loadParametersFile: loads a .csv file with preferences and 
%	    returns them as a struct. If any parameteters are missing,
%		the default values will be loaded from 'generateDefaultValues.m'.

function [params, paramFileName] = loadParametersFile(paramFileName)

	%% load parameter file
	if ~exist(paramFileName,'file')
	    [paramFile,paramPath] = uigetfile('*.csv','Open experiment parameter file');
	    paramFileName = fullfile(paramPath,paramFile);
    end
    
    %Note: readtable function seems to have slight changed in R2016A.
    v = version;
    if str2double(v(end-5:end-2))>=2016
        T = readtable(paramFileName,'delimiter',','); %Shay - added "'delimiter',','" to work in 2016a
    else
        % For earlier versions use:
        T = readtable(paramFileName);
    end
    
	for i = 1:size(T,1)
	    params.(T.pName{i}) = T.pVal(i); % store parameters in structure 'p'
	end

	defaultP = generateDefaultParameters('struct');
	paramNames = fieldnames(defaultP);
	for i = 1:length(paramNames)
	    paramName = paramNames{i};
	    if ~isfield(params, paramName)
	        params.(paramName) = defaultP.(paramName);
	        fprintf('Warning: parameter file missing parameter "%s". Using default value of %g.\n',paramName,defaultP.(paramName));
	    end
	end

