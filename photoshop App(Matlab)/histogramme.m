function varargout = histogramme(varargin)
% HISTOGRAMME MATLAB code for histogramme.fig
%      HISTOGRAMME, by itself, creates a new HISTOGRAMME or raises the existing
%      singleton*.
%
%      H = HISTOGRAMME returns the handle to a new HISTOGRAMME or the handle to
%      the existing singleton*.
%
%      HISTOGRAMME('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HISTOGRAMME.M with the given input arguments.
%
%      HISTOGRAMME('Property','Value',...) creates a new HISTOGRAMME or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before histogramme_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to histogramme_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help histogramme

% Last Modified by GUIDE v2.5 28-Jan-2023 01:01:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @histogramme_OpeningFcn, ...
                   'gui_OutputFcn',  @histogramme_OutputFcn, ...
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


% --- Executes just before histogramme is made visible.
function histogramme_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to histogramme (see VARARGIN)

% Choose default command line output for histogramme
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes histogramme wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = histogramme_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton1,'enable','on');
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h=get(handles.popupmenu1,'value');
switch h
    case 1      
a=getappdata(0,'current');
input=a;
axes(handles.axes1)
imhist(input)
set(handles.pushbutton1,'enable','off');
   case 2
       
a=getappdata(0,'current');
input=rgb2gray(a);
axes(handles.axes1)
imhist(input)
set(handles.pushbutton1,'enable','off');

end
