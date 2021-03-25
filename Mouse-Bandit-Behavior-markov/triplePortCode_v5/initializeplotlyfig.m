function [psL,psR] = initializeplotlyfig()
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here


%%matlab
%----STORED STREAMING CREDENTIALS----%
plotlysetup('shayqn','zhzf4ucffo','stream_ids',{'dxbk9hcdji','3r9znjryi1'});
my_credentials = loadplotlycredentials;
tokenL = my_credentials.stream_ids{end-1};
tokenR = my_credentials.stream_ids{end};

%----SETUP-----%

data{1}.x = [];
data{1}.y = [];
data{1}.type = 'line';
data{1}.stream.token = tokenL;
data{1}.stream.maxpoints = 30000;
data{1}.name = 'left trials';


data{2}.x = [];
data{2}.y = [];
data{2}.type = 'line';
data{2}.stream.token = tokenR;
data{2}.stream.maxpoints = 30000;
data{2}.name = 'right trials';

args.filename = 'Trials';
args.fileopt = 'overwrite';
args.layout.title = 'Real Time Trial Tracker';

%----PLOTLY-----%

resp = plotly(data,args);
URL_OF_PLOT = resp.url
web(URL_OF_PLOT,'-browser');

%%matlab
psL = plotlystream(tokenL);
psR = plotlystream(tokenR);
end

