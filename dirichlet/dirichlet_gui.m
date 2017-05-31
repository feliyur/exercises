function varargout = dirichlet_gui(varargin)
% DIRICHLET_GUI MATLAB code for dirichlet_gui.fig
%      DIRICHLET_GUI, by itself, creates a new DIRICHLET_GUI or raises the existing
%      singleton*.
%
%      H = DIRICHLET_GUI returns the handle to a new DIRICHLET_GUI or the handle to
%      the existing singleton*.
%
%      DIRICHLET_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DIRICHLET_GUI.M with the given input arguments.
%
%      DIRICHLET_GUI('Property','Value',...) creates a new DIRICHLET_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dirichlet_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dirichlet_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dirichlet_gui

% Last Modified by GUIDE v2.5 29-Mar-2017 09:43:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dirichlet_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @dirichlet_gui_OutputFcn, ...
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


% --- Executes just before dirichlet_gui is made visible.
function dirichlet_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dirichlet_gui (see VARARGIN)

% Choose default command line output for dirichlet_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

tUserData.alpha = [handles.slider_a1.Value, ...
                   handles.slider_a2.Value, ...
                   handles.slider_a3.Value]; 

% UIWAIT makes dirichlet_gui wait for user response (see UIRESUME)
% uiwait(handles.fig_dirichlet);
alpha = [handles.slider_a1.Value, handles.slider_a2.Value, handles.slider_a3.Value]; 
[~, hSurf] = plotdir(handles.axes1, alpha); 
handles.axes1.UserData = hSurf; 

% h = uicontrol('style','slider','callback',@(src,evt)disp(get(src,'value')));
addlistener(handles.slider_a1,'Value','PreSet',@(~, ~)updatePlot(handles));
addlistener(handles.slider_a2,'Value','PreSet',@(~, ~)updatePlot(handles));
addlistener(handles.slider_a3,'Value','PreSet',@(~, ~)updatePlot(handles));



% --- Outputs from this function are returned to the command line.
function varargout = dirichlet_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function slider_a1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_a1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes during object creation, after setting all properties.
function slider_a2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_a2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



% --- Executes during object creation, after setting all properties.
function slider_a3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_a3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function updatePlot(handles)

alpha = [handles.slider_a1.Value, handles.slider_a2.Value, handles.slider_a3.Value]; 
f = plotdir([], alpha); 
handles.axes1.UserData.ZData = f; 


