function varargout = NewGUI(varargin)
% NEWGUI MATLAB code for NewGUI.fig
%      NEWGUI, by itself, creates a new NEWGUI or raises the existing
%      singleton*.
%
%      H = NEWGUI returns the handle to a new NEWGUI or the handle to
%      the existing singleton*.
%
%      NEWGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NEWGUI.M with the given input arguments.
%
%      NEWGUI('Property','Value',...) creates a new NEWGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before NewGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to NewGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help NewGUI

% Last Modified by GUIDE v2.5 11-Aug-2017 11:35:25

% Begin initialization code - DO NOT EDIT
%NOTE: THE ONLY REAL CHANGE IS IN THE LAST FUNCTION... THE BUTTON PUSHED
%CAUSES THE CREATION OF THE GLOBAL STRUCT "PARAMETERS" WITH CONTENTS
%DEPENDENT ON WHAT WAS INPUTTED TO THE TEXT-EDIT SPOTS
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @NewGUI_OpeningFcn, ...
    'gui_OutputFcn',  @NewGUI_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before NewGUI is made visible.
function NewGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to NewGUI (see VARARGIN)

% Choose default command line output for NewGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
global handlesCopy
handlesCopy = handles;
% UIWAIT makes NewGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);
%initially disables the Stop Experiment Button and save checkmark.
%also initially sets the checkmark to checked
set(handles.stopExperiment,'enable','off');
set(handles.save,'enable','off');
set(handles.save,'Value',1)
global calib
calib.left = str2double(get(handles.leftCalibDuration,'String'));
calib.right = str2double(get(handles.rightCalibDuration,'String'));
set(handles.statsTable,'enable','off');
set(handles.leftCalibDuration,'enable','off');
set(handles.rightCalibDuration,'enable','off');
set(handles.getLeftCalibDuration,'enable','off');
set(handles.getRightCalibDuration,'enable','off');
set(handles.numIterations,'enable','off');




% --- Outputs from this function are returned to the command line.
function varargout = NewGUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function centerPokeTrigger_Callback(hObject, eventdata, handles)
% hObject    handle to centerPokeTrigger (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of centerPokeTrigger as text
%        str2double(get(hObject,'String')) returns contents of centerPokeTrigger as a double


% --- Executes during object creation, after setting all properties.
function centerPokeTrigger_CreateFcn(hObject, eventdata, handles)
% hObject    handle to centerPokeTrigger (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function centerPokeRewardWindow_Callback(hObject, eventdata, handles)
% hObject    handle to centerPokeRewardWindow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of centerPokeRewardWindow as text
%        str2double(get(hObject,'String')) returns contents of centerPokeRewardWindow as a double


% --- Executes during object creation, after setting all properties.
function centerPokeRewardWindow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to centerPokeRewardWindow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function leftRewardProb_Callback(hObject, eventdata, handles)
% hObject    handle to leftRewardProb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of leftRewardProb as text
%        str2double(get(hObject,'String')) returns contents of leftRewardProb as a double


% --- Executes during object creation, after setting all properties.
function leftRewardProb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to leftRewardProb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function rightRewardProb_Callback(hObject, eventdata, handles)
% hObject    handle to rightRewardProb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rightRewardProb as text
%        str2double(get(hObject,'String')) returns contents of rightRewardProb as a double


% --- Executes during object creation, after setting all properties.
function rightRewardProb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rightRewardProb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function ledDuringRewardWindow_Callback(hObject, eventdata, handles)
% hObject    handle to ledDuringRewardWindow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ledDuringRewardWindow as text
%        str2double(get(hObject,'String')) returns contents of ledDuringRewardWindow as a double


% --- Executes during object creation, after setting all properties.
function ledDuringRewardWindow_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ledDuringRewardWindow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function rewardDurationRight_Callback(hObject, eventdata, handles)
% hObject    handle to rewardDurationRight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rewardDurationRight as text
%        str2double(get(hObject,'String')) returns contents of rewardDurationRight as a double


% --- Executes during object creation, after setting all properties.
function rewardDurationRight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rewardDurationRight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function rewardDurationLeft_Callback(hObject, eventdata, handles)
% hObject    handle to rewardDurationLeft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rewardDurationLeft as text
%        str2double(get(hObject,'String')) returns contents of rewardDurationLeft as a double


% --- Executes during object creation, after setting all properties.
function rewardDurationLeft_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rewardDurationLeft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function minInterTrialInterval_Callback(hObject, eventdata, handles)
% hObject    handle to minInterTrialInterval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of minInterTrialInterval as text
%        str2double(get(hObject,'String')) returns contents of minInterTrialInterval as a double


% --- Executes during object creation, after setting all properties.
function minInterTrialInterval_CreateFcn(hObject, eventdata, handles)
% hObject    handle to minInterTrialInterval (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function blockRangeMin_Callback(hObject, eventdata, handles)
% hObject    handle to blockRangeMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of blockRangeMin as text
%        str2double(get(hObject,'String')) returns contents of blockRangeMin as a double


% --- Executes during object creation, after setting all properties.
function blockRangeMin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blockRangeMin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function blockRangeMax_Callback(hObject, eventdata, handles)
% hObject    handle to blockRangeMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of blockRangeMax as text
%        str2double(get(hObject,'String')) returns contents of blockRangeMax as a double


% --- Executes during object creation, after setting all properties.
function blockRangeMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to blockRangeMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function laserstimprob_Callback(hObject, eventdata, handles)
% hObject    handle to laserstimprob (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of laserstimprob as text
%        str2double(get(hObject,'String')) returns contents of laserstimprob as a double


% --- Executes during object creation, after setting all properties.
function laserstimprob_CreateFcn(hObject, eventdata, handles)
% hObject    handle to laserstimprob (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function markov_Callback(hObject, eventdata, handles)
% hObject    handle to markov (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of markov as text
%        str2double(get(hObject,'String')) returns contents of markov as a double


% --- Executes during object creation, after setting all properties.
function markov_CreateFcn(hObject, eventdata, handles)
% hObject    handle to markov (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in useMarkov.
function useMarkov_Callback(hObject, eventdata, handles)
% hObject    handle to useMarkov (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.useMarkov.Value == 1
    set(handles.markov, 'enable', 'on');
    set(handles.blockRangeMin, 'enable', 'off');
    set(handles.blockRangeMax, 'enable', 'off');
    set(handles.laserstimprob, 'enable', 'off');
else
    set(handles.markov, 'enable', 'off');
    set(handles.blockRangeMin, 'enable', 'on');
    set(handles.blockRangeMax, 'enable', 'on');
    set(handles.laserstimprob, 'enable', 'on');
end


% --- Executes on button press in runExperiment.
function runExperiment_Callback(hObject, eventdata, handles)
% hObject    handle to runExperiment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%Uses str2double(get(handles.PARAMETER_NAME, 'String')) to set each
%property of the parameters struct, which has been instantiated as a global
%variable
%LEDDuringRewardWindow is automatically set to 1
global p
p = struct;
p.centerPokeTrigger = str2double(get(handles.centerPokeTrigger, 'String'));
p.centerPokeRewardWindow = str2double(get(handles.centerPokeRewardWindow, 'String'));
p.ledDuringRewardWindow = 1;
p.leftRewardProb = str2double(get(handles.leftRewardProb, 'String'));
p.rightRewardProb = str2double(get(handles.rightRewardProb, 'String'));
p.rewardDurationRight = str2double(get(handles.rewardDurationRight, 'String'));
p.rewardDurationLeft = str2double(get(handles.rewardDurationLeft, 'String'));
p.minInterTrialInterval = str2double(get(handles.minInterTrialInterval, 'String'));
p.blockRangeMin = str2double(get(handles.blockRangeMin, 'String'));
p.blockRangeMax = str2double(get(handles.blockRangeMax, 'String'));
p.laserstimprob = str2double(get(handles.laserstimprob, 'String'));
p.markov = str2double(get(handles.markov, 'String'));
p.ismarkov = get(handles.useMarkov, 'Value');
%creates a global info struct to store the mouse's name and the folder's
%path as inputted by the user. sets the running field to true and the
%save field to NaN
global info
info = struct;
info.mouseName = lower(get(handles.mouseName, 'String'));
info.folderName = get(handles.folderPath,'String');
info.running = true;
info.save = NaN;
ready = true;

%makes sure the user enters a mouse name and a directory
if isempty(info.mouseName) || strcmp(info.folderName,'Default Folder Path') || strcmp(info.folderName,'0')
    ready = false;
    errordlg('Must input the mouse"s name and the directory in which the session"s data will be saved', 'INPUTS REQUIRED')
    %DIALOG BOX HERE
end

if p.ismarkov==0 && ~isempty(strfind(info.mouseName, 'cb')) % use checkbox first
    button = questdlg('Are you sure you don''t want to use Markovian transition probabilities?');
    if strcmp(button,'No') || strcmp(button, 'Cancel')
        ready = false;
    end
end
if p.ismarkov==1
    if p.markov <= 0 || p.markov >= 1 % check if valid entry for tprob
        ready = false;
        errordlg('Please enter a value for Markovian Transition Probability between 0 and 1.')
    end
end

%if everything checks out, everything is disabled but the start and
%save objects, and the experiment is run
if ready
    set(handles.centerPokeTrigger, 'enable', 'off');
    set(handles.centerPokeRewardWindow, 'enable', 'off');
    set(handles.leftRewardProb, 'enable', 'off');
    set(handles.rightRewardProb, 'enable', 'off');
    set(handles.rewardDurationRight, 'enable', 'off');
    set(handles.rewardDurationLeft, 'enable', 'off');
    set(handles.minInterTrialInterval, 'enable', 'off');
    set(handles.blockRangeMin, 'enable', 'off');
    set(handles.blockRangeMax, 'enable', 'off');
    set(handles.laserstimprob, 'enable', 'off');
    set(handles.markov, 'enable', 'off');
    set(handles.mouseName, 'enable', 'off');
    set(handles.folderPath, 'enable', 'off');
    set(handles.chooseFolder, 'enable', 'off');
    set(handles.runExperiment,'enable','off');
    set(handles.stopExperiment,'enable','on');
    set(handles.save,'enable','on');
    set(handles.reset,'enable','off');
    set(handles.connectToArduino,'enable','off');
    set(handles.leftCalibDuration,'enable','off');
    set(handles.rightCalibDuration,'enable','off');
    set(handles.getLeftCalibDuration,'enable','off');
    set(handles.getRightCalibDuration,'enable','off');
    set(handles.statsTable,'enable','on');
    if p.ismarkov == 0
        runTriplePortExperiment_laser
    elseif p.ismarkov ==1
        runTriplePortExperiment_markov
    else
        errordlg('Please enter a value for Markovian Transition Probability between 0 and 1.')
    end
    
end

% --- Executes on button press in stopExperiment.
function stopExperiment_Callback(hObject, eventdata, handles)
% hObject    handle to stopExperiment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%sets the running field of info to false and determines whether or not the
%user wanted to save the data. also sets up an input dialog box to make
%sure the user wants to discard data if they uncheck the box
global info
info.save = get(handles.save,'Value');
if ~info.save
    answer = lower(inputdlg('Do you want to save data for this session?','SAVE?'));
    if ~strcmp(answer,'n') && ~strcmp(answer,'no')
        set(handles.save,'Value',1);
        info.save = 1;
    end
end
info.running = false;
reset_Callback(hObject, eventdata, handles)
% set(handles.stopExperiment, 'enable', 'off');
% set(handles.save, 'enable', 'off');



function mouseName_Callback(hObject, eventdata, handles)
% hObject    handle to mouseName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mouseName as text
%        str2double(get(hObject,'String')) returns contents of mouseName as a double

% --- Executes during object creation, after setting all properties.
function mouseName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mouseName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in chooseFolder.
function chooseFolder_Callback(hObject, eventdata, handles)
% hObject    handle to chooseFolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
folder = uigetdir;
set(handles.folderPath, 'String', folder);



% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of save


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
%resets all handles to their intial state
set(handles.centerPokeTrigger, 'enable', 'on');
set(handles.centerPokeRewardWindow, 'enable', 'on');
set(handles.leftRewardProb, 'enable', 'on');
set(handles.rightRewardProb, 'enable', 'on');
set(handles.rewardDurationRight, 'enable', 'on');
set(handles.rewardDurationLeft, 'enable', 'on');
set(handles.minInterTrialInterval, 'enable', 'on');
set(handles.blockRangeMin, 'enable', 'on');
set(handles.blockRangeMax, 'enable', 'on');
set(handles.laserstimprob, 'enable', 'on');
set(handles.markov, 'enable', 'off');
set(handles.mouseName, 'enable', 'on');
set(handles.folderPath, 'enable', 'on');
set(handles.chooseFolder, 'enable', 'on');
set(handles.runExperiment, 'enable', 'on');
set(handles.stopExperiment,'enable','off');
set(handles.save,'enable','off');
set(handles.centerPokeTrigger, 'String','1');
set(handles.centerPokeRewardWindow, 'String','2');
set(handles.leftRewardProb, 'String','0.2');
set(handles.rightRewardProb, 'String','0.8');
set(handles.rewardDurationRight, 'String', '40');
set(handles.rewardDurationLeft, 'String', '45');
set(handles.minInterTrialInterval, 'String', '1');
set(handles.blockRangeMin, 'String', '50');
set(handles.blockRangeMax, 'String', '50');
set(handles.laserstimprob, 'String', '0');
set(handles.markov, 'String', '0');
set(handles.useMarkov, 'Value', 0);
set(handles.mouseName,'String','');
set(handles.folderPath,'String','Default Folder Path');
set(handles.save,'Value',1);
set(handles.reset,'enable','on');
set(handles.leftCalibDuration,'enable','on');
set(handles.rightCalibDuration,'enable','on');
set(handles.getLeftCalibDuration,'enable','on');
set(handles.getRightCalibDuration,'enable','on');
set(handles.leftCalibDuration,'String','45');
set(handles.rightCalibDuration,'String','45');
set(handles.numIterations,'String','100');
set(handles.numIterations,'enable','off');
set(handles.rightCalibDuration,'enable','off');
set(handles.leftCalibDuration,'enable','off');
set(handles.getLeftCalibDuration,'enable','off');
set(handles.getRightCalibDuration,'enable','off');
set(handles.connectToArduino,'enable','on');
global calib
calib.left = 45;
calib.right = 45;
set(handles.statsTable,'data',[0,0,0;0,0,0;0,0,0]);
set(handles.statsTable,'enable','off');

% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in getLeftCalibDuration.
function getLeftCalibDuration_Callback(hObject, eventdata, handles)
% hObject    handle to getLeftCalibDuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% gets the length of the calibration reward duration for the left side as
% inputted by the user and disperses it for the number of iterations the
% user inputted, pausing 0.1 seconds between each reward

global calib
calib.left = str2double(get(handles.leftCalibDuration, 'String'));
global leftPort 
leftPort.setRewardDuration(calib.left);
iterations = str2double(get(handles.numIterations,'String'));
for i = 1:iterations
    leftPort.deliverReward();
    pause(0.1);
end

% --- Executes on button press in getRightCalibDuration.
function getRightCalibDuration_Callback(hObject, eventdata, handles)
% hObject    handle to getRightCalibDuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% gets the length of the calibration reward duration for the right side as
% inputted by the user and disperses it for the number of iterations the
% user inputted, pausing 0.1 seconds between each reward
global calib
calib.right = str2double(get(handles.rightCalibDuration, 'String'));
global rightPort 
rightPort.setRewardDuration(calib.right);
iterations = str2double(get(handles.numIterations,'String'));
for i = 1:iterations
    rightPort.deliverReward();
    pause(0.1);
end
function leftCalibDuration_Callback(hObject, eventdata, handles)
% hObject    handle to leftCalibDuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of leftCalibDuration as text
%        str2double(get(hObject,'String')) returns contents of leftCalibDuration as a double


% --- Executes during object creation, after setting all properties.
function leftCalibDuration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to leftCalibDuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rightCalibDuration_Callback(hObject, eventdata, handles)
% hObject    handle to rightCalibDuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rightCalibDuration as text
%        str2double(get(hObject,'String')) returns contents of rightCalibDuration as a double


% --- Executes during object creation, after setting all properties.
function rightCalibDuration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rightCalibDuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in connectToArduino.
function connectToArduino_Callback(hObject, eventdata, handles)
%establishes a connection with the arduino to calibrate the number of water
%dispensed by the solenoids by setting up a temporary calibration_log_ file
%that is then deleted at the end of the function
global arduinoConnection arduinoPort
global arduinoMessageString
arduinoMessageString = '';
clearPorts();
arduinoPortNum = findArduinoPort();
if ~arduinoPortNum
    disp('Can''t find serial port with Arduino')
    return
end
global info calib
info = struct;
info.folderName = pwd;
setupLogging('calibration_log');
arduinoConnection = 0;
arduinoPort = setupArduinoSerialPort(arduinoPortNum);
% wait for Arduino startup
fprintf('Waiting for Arduino startup')
while (arduinoConnection == 0)
    fprintf('.');
    pause(0.5);
end
fprintf('\n')

global leftPort
leftPort = NosePort(6,3);
leftPort.setLEDPin(10);
leftPort.setRewardDuration(calib.left);
leftPort.setToSingleRewardMode();
global rightPort
rightPort = NosePort(7,4);
rightPort.setLEDPin(9);
rightPort.setRewardDuration(calib.right);
rightPort.setToSingleRewardMode();
set(handles.getLeftCalibDuration,'enable','on');
set(handles.getRightCalibDuration,'enable','on');
set(handles.leftCalibDuration,'enable','on');
set(handles.rightCalibDuration,'enable','on');
set(handles.numIterations,'enable','on');
global logFileID
%fclose(logFileID);
%fileToDel = dir('calibration_log*');
%delete(fileToDel.name);
set(handles.connectToArduino,'enable','off');


% hObject    handle to connectToArduino (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function numIterations_Callback(hObject, eventdata, handles)
% hObject    handle to numIterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numIterations as text
%        str2double(get(hObject,'String')) returns contents of numIterations as a double


% --- Executes during object creation, after setting all properties.
function numIterations_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numIterations (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to laserstimprob (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of laserstimprob as text
%        str2double(get(hObject,'String')) returns contents of laserstimprob as a double


% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to laserstimprob (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% Hint: get(hObject,'Value') returns toggle state of useMarkov
