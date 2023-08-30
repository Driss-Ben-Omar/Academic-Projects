function varargout = final(varargin)
% FINAL MATLAB code for final.fig
%      FINAL, by itself, creates a new FINAL or raises the existing
%      singleton*.
%
%      H = FINAL returns the handle to a new FINAL or the handle to
%      the existing singleton*.
%
%      FINAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FINAL.M with the given input arguments.
%
%      FINAL('Property','Value',...) creates a new FINAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before final_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to final_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help final

% Last Modified by GUIDE v2.5 31-Jan-2023 11:56:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @final_OpeningFcn, ...
                   'gui_OutputFcn',  @final_OutputFcn, ...
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


% --- Executes just before final is made visible.
function final_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to final (see VARARGIN)

% Choose default command line output for final
handles.output = hObject;
%axes(handles.axes1)
%imshow('upload.jpg')

[reset,map]=imread('reset12.png');
reset= imresize(reset, [38 40]);
set(handles.resetboutton,'cdata',reset);

[import,map]=imread('uploadimage.png');
import= imresize(import, [38 40]);
set(handles.importnboutton,'cdata',import);

[exit,map]=imread('exit.png');
exit= imresize(exit, [38 40]);
set(handles.pushbutton16,'cdata',exit);

[back,map]=imread('back.png');
back= imresize(back, [38 40]);
set(handles.pushbutton14,'cdata',back);

[save,map]=imread('saveas.png');
save= imresize(save, [38 40]);
set(handles.pushbutton15,'cdata',save);

[mouse,map]=imread('mouse.png');
mouse= imresize(mouse, [38 40]);
set(handles.pushbutton17,'cdata',mouse);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes final wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = final_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function file_Callback(hObject, eventdata, handles)
% hObject    handle to file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function filter_Callback(hObject, eventdata, handles)
% hObject    handle to filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function noises_Callback(hObject, eventdata, handles)
% hObject    handle to noises (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function edit_Callback(hObject, eventdata, handles)
% hObject    handle to edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function retation_Callback(hObject, eventdata, handles)
% hObject    handle to retation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uibuttongroup2,"Visible",'off')
set(handles.uibuttongroup1,"Visible",'off')
set(handles.uibuttongroup3,"Visible",'off')
set(handles.uibuttongroup4,"Visible",'off')
set(handles.uibuttongroup5,"Visible",'off')
set(handles.uibuttongroup6,"Visible",'off')
set(handles.uibuttongroup9,"Visible",'off')
current=getappdata(0,'current');
setappdata(0,'oldimage',current);
ang=inputdlg("Entrer l'angle qui peut router",'Angle');
a=str2num(ang{:});
rotate=imrotate(current,a);
axes(handles.axes1);
imshow(rotate);
setappdata(0,'current',rotate);

% --------------------------------------------------------------------
function resize_Callback(hObject, eventdata, handles)
% hObject    handle to resize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uibuttongroup2,"Visible",'off')
set(handles.uibuttongroup1,"Visible",'off')
set(handles.uibuttongroup3,"Visible",'off')
set(handles.uibuttongroup4,"Visible",'off')
set(handles.uibuttongroup5,"Visible",'off')
set(handles.uibuttongroup6,"Visible",'off')
set(handles.uibuttongroup9,"Visible",'off')
promptMessage = sprintf("tu peut copier l'image");
titleBarCaption = 'Continue?';
button = questdlg(promptMessage, titleBarCaption, 'Continue', 'Cancel', 'Continue');
if strcmpi(button, 'Cancel')
  close(hFig); % Close down the figure - get rid of it.
  return;
end
current=getappdata(0,'current');
setappdata(0,'oldimage',current);
k = waitforbuttonpress;
point1 = get(gca,'CurrentPoint');    % button down detected
finalRect = rbbox;                   % return figure units
point2 = get(gca,'CurrentPoint');    % button up detected
point1 = point1(1,1:2);              % extract x and y
point2 = point2(1,1:2);
p1 = min(point1,point2);             % calculate locations
offset = abs(point1-point2);
% Find the coordinates of the box.
xCoords = [p1(1) p1(1)+offset(1) p1(1)+offset(1) p1(1) p1(1)];
yCoords = [p1(2) p1(2) p1(2)+offset(2) p1(2)+offset(2) p1(2)];
x1 = round(xCoords(1));
x2 = round(xCoords(2));
y1 = round(yCoords(5));
y2 = round(yCoords(3));
width = x2-x1;
height = y2-y1;
% The box from rbbox() disappears after drawing, so redraw the box over the image.
hold on
axis manual
plot(xCoords, yCoords, 'b-'); % redraw in dataspace units
pause(1)
% Display the cropped image.
delete(get(handles.axes1,'children'));
img = imcrop(current, [x1, y1, width, height]);
current=img
axes(handles.axes1);
imshow(current);
setappdata(0,'current',current);
% --------------------------------------------------------------------
function flip_Callback(hObject, eventdata, handles)
% hObject    handle to flip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function import_Callback(hObject, eventdata, handles)
% hObject    handle to import (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
i=imgetfile();
i=imread(i);
axes(handles.axes1);
imshow(i);
setappdata(0,'current',i);
setappdata(0,'initimage',i);
setappdata(0,'oldimage',i);
guidata(hObject,handles);
set(handles.blur,'enable','on')
set(handles.histogram,'enable','on')
set(handles.reset,'enable','on')
set(handles.back,'enable','on')
set(handles.save,'enable','on')
set(handles.filter,'enable','on')
set(handles.noises,'enable','on')
set(handles.edit,'enable','on')
set(handles.lighting,'enable','on')
set(handles.erosion,'enable','on')
set(handles.contour,'enable','on')
set(handles.pushbutton15,'Visible','on')
set(handles.pushbutton14,'Visible','on')
set(handles.resetboutton,'Visible','on')
set(handles.pushbutton17,'Visible','on')

% --------------------------------------------------------------------
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('exit')
pause(3);
close();
close();

% --------------------------------------------------------------------
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
current=getappdata(0,'current');
s=imputfile;
imwrite(current,s);

% --------------------------------------------------------------------
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uibuttongroup2,"Visible",'off')
set(handles.uibuttongroup1,"Visible",'off')
set(handles.uibuttongroup3,"Visible",'off')
set(handles.uibuttongroup4,"Visible",'off')
set(handles.uibuttongroup5,"Visible",'off')
set(handles.uibuttongroup6,"Visible",'off')
set(handles.uibuttongroup9,"Visible",'off')
init=getappdata(0,'initimage');
setappdata(0,'oldimage',getappdata(0,'current'));
axes(handles.axes1);
imshow(init);
setappdata(0,'current',init);

% --------------------------------------------------------------------
function back_Callback(hObject, eventdata, handles)
% hObject    handle to back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uibuttongroup2,"Visible",'off')
set(handles.uibuttongroup1,"Visible",'off')
set(handles.uibuttongroup3,"Visible",'off')
set(handles.uibuttongroup4,"Visible",'off')
set(handles.uibuttongroup5,"Visible",'off')
set(handles.uibuttongroup6,"Visible",'off')
set(handles.uibuttongroup9,"Visible",'off')
old=getappdata(0,'oldimage');
setappdata(0,'oldimage',getappdata(0,'current'));
axes(handles.axes1);
imshow(old);
setappdata(0,'current',old);

% --------------------------------------------------------------------
function flipHorizontal_Callback(hObject, eventdata, handles)
% hObject    handle to flipHorizontal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uibuttongroup2,"Visible",'off')
set(handles.uibuttongroup1,"Visible",'off')
set(handles.uibuttongroup3,"Visible",'off')
set(handles.uibuttongroup4,"Visible",'off')
set(handles.uibuttongroup5,"Visible",'off')
set(handles.uibuttongroup6,"Visible",'off')
set(handles.uibuttongroup9,"Visible",'off')
current=getappdata(0,'current');
setappdata(0,'oldimage',current);
flip=flipdim(current,1);
axes(handles.axes1); 
imshow(flip)
setappdata(0,'current',flip);

% --------------------------------------------------------------------
function flipVertical_Callback(hObject, eventdata, handles)
% hObject    handle to flipVertical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uibuttongroup2,"Visible",'off')
set(handles.uibuttongroup1,"Visible",'off')
set(handles.uibuttongroup3,"Visible",'off')
set(handles.uibuttongroup4,"Visible",'off')
set(handles.uibuttongroup5,"Visible",'off')
set(handles.uibuttongroup6,"Visible",'off')
set(handles.uibuttongroup9,"Visible",'off')
current=getappdata(0,'current');
setappdata(0,'oldimage',current);
flip=flipdim(current,2);
axes(handles.axes1); 
imshow(flip)
setappdata(0,'current',flip);

% --------------------------------------------------------------------
function gaussian_Callback(hObject, eventdata, handles)
% hObject    handle to gaussian (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uibuttongroup6,"Visible","off")
set(handles.uibuttongroup2,"Visible","off")
set(handles.uibuttongroup5,"Visible","off")
set(handles.uibuttongroup3,"Visible","off")
set(handles.uibuttongroup4,"Visible","off")
set(handles.uibuttongroup9,"Visible",'off')
set(handles.uibuttongroup1,"Visible","on")

% --------------------------------------------------------------------
function saltPaper_Callback(hObject, eventdata, handles)
% hObject    handle to saltPaper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uibuttongroup1,"Visible","off")
set(handles.uibuttongroup2,"Visible","off")
set(handles.uibuttongroup5,"Visible","off")
set(handles.uibuttongroup3,"Visible","off")
set(handles.uibuttongroup4,"Visible","off")
set(handles.uibuttongroup9,"Visible",'off')
set(handles.uibuttongroup6,"Visible","on")

% --------------------------------------------------------------------
function sinusoidal_Callback(hObject, eventdata, handles)
% hObject    handle to sinusoidal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uibuttongroup2,"Visible",'off')
set(handles.uibuttongroup1,"Visible",'off')
set(handles.uibuttongroup3,"Visible",'off')
set(handles.uibuttongroup4,"Visible",'off')
set(handles.uibuttongroup5,"Visible",'off')
set(handles.uibuttongroup6,"Visible",'off')
set(handles.uibuttongroup9,"Visible",'on')


% --------------------------------------------------------------------
function colors_Callback(hObject, eventdata, handles)
% hObject    handle to colors (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function complement_Callback(hObject, eventdata, handles)
% hObject    handle to complement (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uibuttongroup2,"Visible",'off')
set(handles.uibuttongroup1,"Visible",'off')
set(handles.uibuttongroup3,"Visible",'off')
set(handles.uibuttongroup4,"Visible",'off')
set(handles.uibuttongroup5,"Visible",'off')
set(handles.uibuttongroup6,"Visible",'off')
set(handles.uibuttongroup9,"Visible",'off')
current=getappdata(0,'current');
setappdata(0,'oldimage',current);
IM2=imcomplement(current);
axes(handles.axes1);
imshow(IM2);
setappdata(0,'current',IM2);

% --------------------------------------------------------------------
function motionFilter_Callback(hObject, eventdata, handles)
% hObject    handle to motionFilter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uibuttongroup2,"Visible",'off')
set(handles.uibuttongroup1,"Visible",'off')
set(handles.uibuttongroup3,"Visible",'off')
set(handles.uibuttongroup4,"Visible",'off')
set(handles.uibuttongroup5,"Visible",'off')
set(handles.uibuttongroup6,"Visible",'off')
set(handles.uibuttongroup9,"Visible",'off')
current=getappdata(0,'current');
setappdata(0,'oldimage',current);
h= fspecial('motion',50,40);
filterredRGB= imfilter(current,h);
axes(handles.axes1)
imshow(filterredRGB)
setappdata(0,'current',filterredRGB);

% --------------------------------------------------------------------
function equalazation_Callback(hObject, eventdata, handles)
% hObject    handle to equalazation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uibuttongroup2,"Visible",'off')
set(handles.uibuttongroup1,"Visible",'off')
set(handles.uibuttongroup3,"Visible",'off')
set(handles.uibuttongroup4,"Visible",'off')
set(handles.uibuttongroup5,"Visible",'off')
set(handles.uibuttongroup6,"Visible",'off')
set(handles.uibuttongroup9,"Visible",'off')
 current=getappdata(0,'current');
setappdata(0,'oldimage',current);
I=rgb2gray(current);
eq=histeq(I);
axes(handles.axes1); 
imshow(eq)
setappdata(0,'current',eq);

% --------------------------------------------------------------------
function low_Callback(hObject, eventdata, handles)
% hObject    handle to low (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uibuttongroup2,"Visible",'off')
set(handles.uibuttongroup1,"Visible",'off')
set(handles.uibuttongroup3,"Visible",'off')
set(handles.uibuttongroup4,"Visible",'off')
set(handles.uibuttongroup5,"Visible",'off')
set(handles.uibuttongroup6,"Visible",'off')
set(handles.uibuttongroup9,"Visible",'off')
current=getappdata(0,'current');
setappdata(0,'oldimage',current);
   I=rgb2gray(current)
noise=imnoise(I,'salt & pepper');
a3=fspecial('average',[7,7]);
t_sp_a3=filter2(a3,noise);
axes(handles.axes1); 
imshow(t_sp_a3/255)
setappdata(0,'current',t_sp_a3/255);

% --------------------------------------------------------------------
function blue_Callback(hObject, eventdata, handles)
% hObject    handle to blue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uibuttongroup2,"Visible",'off')
set(handles.uibuttongroup1,"Visible",'off')
set(handles.uibuttongroup3,"Visible",'off')
set(handles.uibuttongroup4,"Visible",'off')
set(handles.uibuttongroup5,"Visible",'off')
set(handles.uibuttongroup6,"Visible",'off')
set(handles.uibuttongroup9,"Visible",'off')
current=getappdata(0,'current');
setappdata(0,'oldimage',current);
blue=current;
blue(:,:,1)=0;
blue(:,:,2)=0;
axes(handles.axes1);
imshow(blue)
setappdata(0,'current',blue);

% --------------------------------------------------------------------
function green_Callback(hObject, eventdata, handles)
% hObject    handle to green (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uibuttongroup2,"Visible",'off')
set(handles.uibuttongroup1,"Visible",'off')
set(handles.uibuttongroup3,"Visible",'off')
set(handles.uibuttongroup4,"Visible",'off')
set(handles.uibuttongroup5,"Visible",'off')
set(handles.uibuttongroup6,"Visible",'off')
set(handles.uibuttongroup9,"Visible",'off')
current=getappdata(0,'current');
setappdata(0,'oldimage',current);
green=current;
green(:,:,1)=0;
green(:,:,3)=0;
axes(handles.axes1);
imshow(green)
setappdata(0,'current',green);

% --------------------------------------------------------------------
function red_Callback(hObject, eventdata, handles)
% hObject    handle to red (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uibuttongroup2,"Visible",'off')
set(handles.uibuttongroup1,"Visible",'off')
set(handles.uibuttongroup3,"Visible",'off')
set(handles.uibuttongroup4,"Visible",'off')
set(handles.uibuttongroup5,"Visible",'off')
set(handles.uibuttongroup6,"Visible",'off')
set(handles.uibuttongroup9,"Visible",'off')
current=getappdata(0,'current');
setappdata(0,'oldimage',current);
red=current;
red(:,:,2:3)=0;
axes(handles.axes1);
imshow(red)
setappdata(0,'current',red);

% --------------------------------------------------------------------
function gray_Callback(hObject, eventdata, handles)
% hObject    handle to gray (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uibuttongroup2,"Visible",'off')
set(handles.uibuttongroup1,"Visible",'off')
set(handles.uibuttongroup3,"Visible",'off')
set(handles.uibuttongroup4,"Visible",'off')
set(handles.uibuttongroup5,"Visible",'off')
set(handles.uibuttongroup6,"Visible",'off')
set(handles.uibuttongroup9,"Visible",'off')
current=getappdata(0,'current');
setappdata(0,'oldimage',current);
a_gray=rgb2gray(current);
axes(handles.axes1); 
imshow(a_gray)
setappdata(0,'current',a_gray);

% --------------------------------------------------------------------
function blackWite_Callback(hObject, eventdata, handles)
% hObject    handle to blackWite (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uibuttongroup2,"Visible",'off')
set(handles.uibuttongroup1,"Visible",'off')
set(handles.uibuttongroup3,"Visible",'off')
set(handles.uibuttongroup4,"Visible",'off')
set(handles.uibuttongroup5,"Visible",'off')
set(handles.uibuttongroup6,"Visible",'off')
set(handles.uibuttongroup9,"Visible",'off')
current=getappdata(0,'current');
setappdata(0,'oldimage',current);
a_bw=im2bw(current,.44);
axes(handles.axes1);
imshow(a_bw)
setappdata(0,'current',a_bw);

% --------------------------------------------------------------------
function lighting_Callback(hObject, eventdata, handles)
% hObject    handle to lighting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function erosion_Callback(hObject, eventdata, handles)
% hObject    handle to erosion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function contour_Callback(hObject, eventdata, handles)
% hObject    handle to contour (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function blur_Callback(hObject, eventdata, handles)
% hObject    handle to blur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function histogram_Callback(hObject, eventdata, handles)
% hObject    handle to histogram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uibuttongroup3,"Visible","off")
set(handles.uibuttongroup5,"Visible","off")
set(handles.uibuttongroup1,"Visible","off")
set(handles.uibuttongroup4,"Visible","off")
set(handles.uibuttongroup2,"Visible","off")
set(handles.uibuttongroup6,"Visible","off")
set(handles.uibuttongroup9,"Visible",'off')
histogramme

% --------------------------------------------------------------------
function convolution_Callback(hObject, eventdata, handles)
% hObject    handle to convolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uibuttongroup2,"Visible",'off')
set(handles.uibuttongroup1,"Visible",'off')
set(handles.uibuttongroup3,"Visible",'off')
set(handles.uibuttongroup4,"Visible",'off')
set(handles.uibuttongroup5,"Visible",'off')
set(handles.uibuttongroup6,"Visible",'off')
set(handles.uibuttongroup9,"Visible",'off')
current=getappdata(0,'current');
setappdata(0,'oldImage',current);
ang=inputdlg('Put matrix','Matrix');
H=str2num(ang{:});
current = imfilter(current, H,'conv');
axes(handles.axes1);
imshow(current);
setappdata(0,'current',current);

% --------------------------------------------------------------------
function blur3_Callback(hObject, eventdata, handles)
% hObject    handle to blur3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uibuttongroup2,"Visible",'off')
set(handles.uibuttongroup1,"Visible",'off')
set(handles.uibuttongroup3,"Visible",'off')
set(handles.uibuttongroup4,"Visible",'off')
set(handles.uibuttongroup5,"Visible",'off')
set(handles.uibuttongroup6,"Visible",'off')
set(handles.uibuttongroup9,"Visible",'off')
current=getappdata(0,'current');
setappdata(0,'oldImage',current);
filterWindow3 = ones(3) / 9;
current = imfilter(current, filterWindow3);
axes(handles.axes1);
imshow(current);
setappdata(0,'current',current);

% --------------------------------------------------------------------
function Blur5_Callback(hObject, eventdata, handles)
% hObject    handle to Blur5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uibuttongroup2,"Visible",'off')
set(handles.uibuttongroup1,"Visible",'off')
set(handles.uibuttongroup3,"Visible",'off')
set(handles.uibuttongroup4,"Visible",'off')
set(handles.uibuttongroup5,"Visible",'off')
set(handles.uibuttongroup6,"Visible",'off')
set(handles.uibuttongroup9,"Visible",'off')
current=getappdata(0,'current');
setappdata(0,'oldImage',current);
filterWindow3 = ones(5,5) / 25;
current = imfilter(current, filterWindow3,'conv');
axes(handles.axes1);
imshow(current);
setappdata(0,'current',current);


% --------------------------------------------------------------------
function blur9_Callback(hObject, eventdata, handles)
% hObject    handle to blur9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uibuttongroup2,"Visible",'off')
set(handles.uibuttongroup1,"Visible",'off')
set(handles.uibuttongroup3,"Visible",'off')
set(handles.uibuttongroup4,"Visible",'off')
set(handles.uibuttongroup5,"Visible",'off')
set(handles.uibuttongroup6,"Visible",'off')
set(handles.uibuttongroup9,"Visible",'off')
current=getappdata(0,'current');
setappdata(0,'oldImage',current);
filterWindow3 = ones(9) / 91;
current = imfilter(current, filterWindow3);
axes(handles.axes1);
imshow(current);
setappdata(0,'current',current);


% --------------------------------------------------------------------
function blur15_Callback(hObject, eventdata, handles)
% hObject    handle to blur15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uibuttongroup2,"Visible",'off')
set(handles.uibuttongroup1,"Visible",'off')
set(handles.uibuttongroup3,"Visible",'off')
set(handles.uibuttongroup4,"Visible",'off')
set(handles.uibuttongroup5,"Visible",'off')
set(handles.uibuttongroup6,"Visible",'off')
set(handles.uibuttongroup9,"Visible",'off')
current=getappdata(0,'current');
setappdata(0,'oldImage',current);
filterWindow3 = ones(15) / 255;
current = imfilter(current, filterWindow3);
axes(handles.axes1);
imshow(current);

setappdata(0,'current',current);

% --------------------------------------------------------------------
function sobel_Callback(hObject, eventdata, handles)
% hObject    handle to sobel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uibuttongroup2,"Visible",'off')
set(handles.uibuttongroup1,"Visible",'off')
set(handles.uibuttongroup3,"Visible",'off')
set(handles.uibuttongroup4,"Visible",'off')
set(handles.uibuttongroup5,"Visible",'off')
set(handles.uibuttongroup6,"Visible",'off')
set(handles.uibuttongroup9,"Visible",'off')
current=getappdata(0,'current');
setappdata(0,'oldimage',current);
current=im2gray(current);
current = edge(current,'sobel');
axes(handles.axes1);
imshow(current);
setappdata(0,'current',current);

% --------------------------------------------------------------------
function canny_Callback(hObject, eventdata, handles)
% hObject    handle to canny (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uibuttongroup2,"Visible",'off')
set(handles.uibuttongroup1,"Visible",'off')
set(handles.uibuttongroup3,"Visible",'off')
set(handles.uibuttongroup4,"Visible",'off')
set(handles.uibuttongroup5,"Visible",'off')
set(handles.uibuttongroup6,"Visible",'off')
set(handles.uibuttongroup9,"Visible",'off')
current=getappdata(0,'current');
setappdata(0,'oldimage',current);
current=im2gray(current);
current = edge(current,'canny');
axes(handles.axes1);
imshow(current);
setappdata(0,'current',current);

% --------------------------------------------------------------------
function prewitt_Callback(hObject, eventdata, handles)
% hObject    handle to prewitt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uibuttongroup2,"Visible",'off')
set(handles.uibuttongroup1,"Visible",'off')
set(handles.uibuttongroup3,"Visible",'off')
set(handles.uibuttongroup4,"Visible",'off')
set(handles.uibuttongroup5,"Visible",'off')
set(handles.uibuttongroup6,"Visible",'off')
set(handles.uibuttongroup9,"Visible",'off')
current=getappdata(0,'current');
setappdata(0,'oldimage',current);
I=im2gray(current);
ed2= edge(I,'prewitt');
axes(handles.axes1); 
imshow(ed2);
setappdata(0,'current',ed2);

% --------------------------------------------------------------------
function robert_Callback(hObject, eventdata, handles)
% hObject    handle to robert (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uibuttongroup2,"Visible",'off')
set(handles.uibuttongroup1,"Visible",'off')
set(handles.uibuttongroup3,"Visible",'off')
set(handles.uibuttongroup4,"Visible",'off')
set(handles.uibuttongroup5,"Visible",'off')
set(handles.uibuttongroup6,"Visible",'off')
set(handles.uibuttongroup9,"Visible",'off')
current=getappdata(0,'current');
setappdata(0,'oldimage',current);
current=im2gray(current);
current = edge(current,'roberts');
axes(handles.axes1);
imshow(current);
setappdata(0,'current',current);

% --------------------------------------------------------------------
function zerocross_Callback(hObject, eventdata, handles)
% hObject    handle to zerocross (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uibuttongroup2,"Visible",'off')
set(handles.uibuttongroup1,"Visible",'off')
set(handles.uibuttongroup3,"Visible",'off')
set(handles.uibuttongroup4,"Visible",'off')
set(handles.uibuttongroup5,"Visible",'off')
set(handles.uibuttongroup6,"Visible",'off')
set(handles.uibuttongroup9,"Visible",'off')
current=getappdata(0,'current');
setappdata(0,'oldimage',current);
current=im2gray(current);
current = edge(current,'zerocross');
axes(handles.axes1);
imshow(current);
setappdata(0,'current',current);

% --------------------------------------------------------------------
function cube_Callback(hObject, eventdata, handles)
% hObject    handle to cube (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uibuttongroup2,"Visible",'off')
set(handles.uibuttongroup1,"Visible",'off')
set(handles.uibuttongroup3,"Visible",'off')
set(handles.uibuttongroup4,"Visible",'off')
set(handles.uibuttongroup5,"Visible",'off')
set(handles.uibuttongroup6,"Visible",'off')
set(handles.uibuttongroup9,"Visible",'off')
current=getappdata(0,'current');
setappdata(0,'oldimage',current);


st1=[1 1 1; 1 1 1;1 1 1];
current= imerode(current,st1);
axes(handles.axes1);
imshow(current);
setappdata(0,'current',current);

% --------------------------------------------------------------------
function cercle_Callback(hObject, eventdata, handles)
% hObject    handle to cercle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uibuttongroup2,"Visible",'off')
set(handles.uibuttongroup1,"Visible",'off')
set(handles.uibuttongroup3,"Visible",'off')
set(handles.uibuttongroup4,"Visible",'off')
set(handles.uibuttongroup5,"Visible",'off')
set(handles.uibuttongroup6,"Visible",'off')
set(handles.uibuttongroup9,"Visible",'off')
current=getappdata(0,'current');
setappdata(0,'oldimage',current);

st2=[0 1 0 ;1 1 1;0 1 0];
current= imerode(current,st2);
axes(handles.axes1);
imshow(current);
setappdata(0,'current',current);

% --------------------------------------------------------------------
function vertical_Callback(hObject, eventdata, handles)
% hObject    handle to vertical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uibuttongroup2,"Visible",'off')
set(handles.uibuttongroup1,"Visible",'off')
set(handles.uibuttongroup3,"Visible",'off')
set(handles.uibuttongroup4,"Visible",'off')
set(handles.uibuttongroup5,"Visible",'off')
set(handles.uibuttongroup6,"Visible",'off')
set(handles.uibuttongroup9,"Visible",'off')
current=getappdata(0,'current');
setappdata(0,'oldimage',current);

st3=[0 1 0 ; 0 1 0;0 1 0];
current= imerode(current,st3);
axes(handles.axes1);
imshow(current);
setappdata(0,'current',current);
% --------------------------------------------------------------------
function horizontal_Callback(hObject, eventdata, handles)
% hObject    handle to horizontal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uibuttongroup2,"Visible",'off')
set(handles.uibuttongroup1,"Visible",'off')
set(handles.uibuttongroup3,"Visible",'off')
set(handles.uibuttongroup4,"Visible",'off')
set(handles.uibuttongroup5,"Visible",'off')
set(handles.uibuttongroup6,"Visible",'off')
set(handles.uibuttongroup9,"Visible",'off')
current=getappdata(0,'current');
setappdata(0,'oldimage',current);

st3=[0 0 0 ;1 1 1;0 0 0];
current= imerode(current,st3);
axes(handles.axes1);
imshow(current);
setappdata(0,'current',current);

% --------------------------------------------------------------------
function forLighting_Callback(hObject, eventdata, handles)
% hObject    handle to forLighting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uibuttongroup6,"Visible","off")
set(handles.uibuttongroup1,"Visible","off")
set(handles.uibuttongroup5,"Visible","off")
set(handles.uibuttongroup3,"Visible","off")
set(handles.uibuttongroup4,"Visible","off")
set(handles.uibuttongroup9,"Visible",'off')
set(handles.uibuttongroup2,"Visible","on")

% --------------------------------------------------------------------
function darking_Callback(hObject, eventdata, handles)
% hObject    handle to darking (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uibuttongroup6,"Visible","off")
set(handles.uibuttongroup1,"Visible","off")
set(handles.uibuttongroup5,"Visible","off")
set(handles.uibuttongroup2,"Visible","off")
set(handles.uibuttongroup9,"Visible",'off')
set(handles.uibuttongroup4,"Visible","off")
set(handles.uibuttongroup3,"Visible","on")

% --------------------------------------------------------------------
function sharpen_Callback(hObject, eventdata, handles)
% hObject    handle to sharpen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uibuttongroup6,"Visible","off")
set(handles.uibuttongroup1,"Visible","off")
set(handles.uibuttongroup5,"Visible","off")
set(handles.uibuttongroup3,"Visible","off")
set(handles.uibuttongroup9,"Visible",'off')
set(handles.uibuttongroup2,"Visible","off")
set(handles.uibuttongroup4,"Visible","on")

% --------------------------------------------------------------------
function adjusment_Callback(hObject, eventdata, handles)
% hObject    handle to adjusment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uibuttongroup6,"Visible","off")
set(handles.uibuttongroup1,"Visible","off")
set(handles.uibuttongroup2,"Visible","off")
set(handles.uibuttongroup3,"Visible","off")
set(handles.uibuttongroup4,"Visible","off")
set(handles.uibuttongroup9,"Visible",'off')
set(handles.uibuttongroup5,"Visible","on")

% --- Executes on slider movement.
function saltpaperslider_Callback(hObject, eventdata, handles)
% hObject    handle to saltpaperslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
s=get(handles.saltpaperslider,'value');
current=getappdata(0,'current');
setappdata(0,'oldimage',current);
noise=imnoise(current,'salt & pepper',s);
axes(handles.axes1); 
imshow(noise)
setappdata(0,'rgb4',noise);

% --- Executes during object creation, after setting all properties.
function saltpaperslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to saltpaperslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in saltpaperboutton.
function saltpaperboutton_Callback(hObject, eventdata, handles)
% hObject    handle to saltpaperboutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rgb=getappdata(0,'rgb4');
setappdata(0,'current',rgb);
set(handles.saltpaperslider,"value",0);

% --- Executes on slider movement.
function adjusmentslider_Callback(hObject, eventdata, handles)
% hObject    handle to adjusmentslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
s=get(handles.adjusmentslider,'value');
current=getappdata(0,'current');
setappdata(0,'oldimage',current);
adjust=imadjust(current,[0;s],[]);
axes(handles.axes1); 
imshow(adjust);
setappdata(0,'rgb1',adjust);

% --- Executes during object creation, after setting all properties.
function adjusmentslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to adjusmentslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in adjusmentboutton.
function adjusmentboutton_Callback(hObject, eventdata, handles)
% hObject    handle to adjusmentboutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rgb=getappdata(0,'rgb1');
setappdata(0,'current',rgb);
set(handles.adjusmentslider,"value",0);

% --- Executes on slider movement.
function gaussianslider_Callback(hObject, eventdata, handles)
% hObject    handle to gaussianslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
s=get(handles.gaussianslider,'value');
current=getappdata(0,'current');
setappdata(0,'oldimage',current);
noise=imnoise(current,'gaussian',s);
axes(handles.axes1); 
imshow(noise)
setappdata(0,'rgb6',noise);

% --- Executes during object creation, after setting all properties.
function gaussianslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gaussianslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in gaussianboutton.
function gaussianboutton_Callback(hObject, eventdata, handles)
% hObject    handle to gaussianboutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rgb=getappdata(0,'rgb6');
setappdata(0,'current',rgb);
set(handles.gaussianslider,"value",0);

% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
x=get(handles.slider5,'value');
current=getappdata(0,'current');
setappdata(0,'oldimage',current);
t=imsharpen(current,'Radius',2*x,'Amount',4);
axes(handles.axes1); 
imshow(t)
setappdata(0,'rgb3',t);

% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in sharpenboutton.
function sharpenboutton_Callback(hObject, eventdata, handles)
% hObject    handle to sharpenboutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rgb=getappdata(0,'rgb3');
setappdata(0,'current',rgb);
set(handles.slider5,"value",0);

% --- Executes on button press in lightingboutton.
function lightingboutton_Callback(hObject, eventdata, handles)
% hObject    handle to lightingboutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rgb=getappdata(0,'rgb5');
setappdata(0,'current',rgb);
set(handles.lightingslider,"value",0);


% --- Executes on slider movement.
function lightingslider_Callback(hObject, eventdata, handles)
% hObject    handle to lightingslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
s=get(handles.lightingslider,'value');
current=getappdata(0,'current');
setappdata(0,'oldimage',current);
x=current+150*s;
axes(handles.axes1); 
imshow(x)
setappdata(0,'rgb5',x);

% --- Executes during object creation, after setting all properties.
function lightingslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lightingslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in darkingboutton.
function darkingboutton_Callback(hObject, eventdata, handles)
% hObject    handle to darkingboutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rgb=getappdata(0,'rgb2');
setappdata(0,'current',rgb);

% --- Executes on slider movement.
function darkingslider_Callback(hObject, eventdata, handles)
% hObject    handle to darkingslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
s=get(handles.darkingslider,'value');
current=getappdata(0,'current');
setappdata(0,'oldimage',current);
rr=(s)*(current.^1);
axes(handles.axes1); 
imshow(rr)
setappdata(0,'rgb2',rr);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function darkingslider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to darkingslider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in resetboutton.
function resetboutton_Callback(hObject, eventdata, handles)
% hObject    handle to resetboutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uibuttongroup2,"Visible",'off')
set(handles.uibuttongroup1,"Visible",'off')
set(handles.uibuttongroup3,"Visible",'off')
set(handles.uibuttongroup4,"Visible",'off')
set(handles.uibuttongroup5,"Visible",'off')
set(handles.uibuttongroup6,"Visible",'off')
set(handles.uibuttongroup9,"Visible",'off')
init=getappdata(0,'initimage');
setappdata(0,'oldimage',getappdata(0,'current'));
axes(handles.axes1);
imshow(init);
setappdata(0,'current',init);

% --- Executes on button press in importnboutton.
function importnboutton_Callback(hObject, eventdata, handles)
% hObject    handle to importnboutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
i=imgetfile();
i=imread(i);
axes(handles.axes1);
imshow(i);
setappdata(0,'current',i);
setappdata(0,'initimage',i);
setappdata(0,'oldimage',i);
guidata(hObject,handles);
set(handles.blur,'enable','on')
set(handles.histogram,'enable','on')
set(handles.reset,'enable','on')
set(handles.back,'enable','on')
set(handles.save,'enable','on')
set(handles.filter,'enable','on')
set(handles.noises,'enable','on')
set(handles.edit,'enable','on')
set(handles.lighting,'enable','on')
set(handles.erosion,'enable','on')
set(handles.contour,'enable','on')
set(handles.pushbutton15,'Visible','on')
set(handles.pushbutton14,'Visible','on')
set(handles.resetboutton,'Visible','on')
set(handles.pushbutton17,'Visible','on')

% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uibuttongroup2,"Visible",'off')
set(handles.uibuttongroup1,"Visible",'off')
set(handles.uibuttongroup3,"Visible",'off')
set(handles.uibuttongroup4,"Visible",'off')
set(handles.uibuttongroup5,"Visible",'off')
set(handles.uibuttongroup6,"Visible",'off')
set(handles.uibuttongroup9,"Visible",'off')
old=getappdata(0,'oldimage');
setappdata(0,'oldimage',getappdata(0,'current'));
axes(handles.axes1);
imshow(old);
setappdata(0,'current',old);

% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
current=getappdata(0,'current');
s=imputfile;
imwrite(current,s);

% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msgbox('exit')
pause(3);
close();
close();


% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uibuttongroup2,"Visible",'off')
set(handles.uibuttongroup1,"Visible",'off')
set(handles.uibuttongroup3,"Visible",'off')
set(handles.uibuttongroup4,"Visible",'off')
set(handles.uibuttongroup5,"Visible",'off')
set(handles.uibuttongroup6,"Visible",'off')
set(handles.uibuttongroup9,"Visible",'off')
promptMessage = sprintf("tu peut copier l'image");
titleBarCaption = 'Continue?';
button = questdlg(promptMessage, titleBarCaption, 'Continue', 'Cancel', 'Continue');
if strcmpi(button, 'Cancel')
  close(hFig); % Close down the figure - get rid of it.
  return;
end
current=getappdata(0,'current');
setappdata(0,'oldimage',current);
k = waitforbuttonpress;
point1 = get(gca,'CurrentPoint');    % button down detected
finalRect = rbbox;                   % return figure units
point2 = get(gca,'CurrentPoint');    % button up detected
point1 = point1(1,1:2);              % extract x and y
point2 = point2(1,1:2);
p1 = min(point1,point2);             % calculate locations
offset = abs(point1-point2);
% Find the coordinates of the box.
xCoords = [p1(1) p1(1)+offset(1) p1(1)+offset(1) p1(1) p1(1)];
yCoords = [p1(2) p1(2) p1(2)+offset(2) p1(2)+offset(2) p1(2)];
x1 = round(xCoords(1));
x2 = round(xCoords(2));
y1 = round(yCoords(5));
y2 = round(yCoords(3));
width = x2-x1;
height = y2-y1;
% The box from rbbox() disappears after drawing, so redraw the box over the image.
hold on
axis manual
plot(xCoords, yCoords, 'b-'); % redraw in dataspace units
pause(1)
% Display the cropped image.
delete(get(handles.axes1,'children'));
img = imcrop(current, [x1, y1, width, height]);
current=img
axes(handles.axes1);
imwrite(current,"current.jpg")
resdimage=imread("current.jpg")
imshow(resdimage);
setappdata(0,'current',current);


% --- Executes on slider movement.
function slider14_Callback(hObject, eventdata, handles)
% hObject    handle to slider14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
s=get(handles.slider14,'value');
current=getappdata(0,'current');
setappdata(0,'oldImage',current);
% Get the size of the image
[rows, cols, channels] = size(current);

% Generate the sinusoidal noise
frequency = s;
phase = 0;
noise = sin(2 * pi * frequency * (1:cols) + phase);
noise = repmat(noise, rows, 1, channels);
% Add the noise to the image
resul= current + uint8(noise * 128);
axes(handles.axes1)
imshow(resul)
setappdata(0,'rgb8',resul);

% --- Executes during object creation, after setting all properties.
function slider14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
rgb=getappdata(0,'rgb8');
setappdata(0,'current',rgb);
set(handles.slider14,"value",0);
% set(handles.uibuttongroup9,"Visible",'off')


% --------------------------------------------------------------------
function median_Callback(hObject, eventdata, handles)
% hObject    handle to median (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
current=getappdata(0,'current');
setappdata(0,'oldImage',current);
img2 = medfilt3(current);
axes(handles.axes1);
imshow(img2);
setappdata(0,'current',img2);


% --------------------------------------------------------------------
function fourier_Callback(hObject, eventdata, handles)
% hObject    handle to fourier (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
current=getappdata(0,'current');
setappdata(0,'oldImage',current);
I1=current;
I1=rgb2gray(I1);
F=fft2(I1);
s=abs(F);
Fsh = fftshift(F);
s2 = log(1+abs(Fsh));
F=ifftshift(Fsh);
f=ifft2(F);
img2=f;
axes(handles.axes1);
imshow(img2,[]);
setappdata(0,'current',img2);


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
current=getappdata(0,'current');
setappdata(0,'oldImage',current);
current = imgaussfilt(current,2);
axes(handles.axes1);
imshow(current);
setappdata(0,'current',current);
