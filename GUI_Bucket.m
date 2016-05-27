function varargout = GUI_Bucket(varargin)
% GUI_BUCKET MATLAB code for GUI_Bucket.fig
%      GUI_BUCKET, by itself, creates a new GUI_BUCKET or raises the existing
%      singleton*.
%
%      H = GUI_BUCKET returns the handle to a new GUI_BUCKET or the handle to
%      the existing singleton*.
%
%      GUI_BUCKET('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_BUCKET.M with the given input arguments.
%
%      GUI_BUCKET('Property','Value',...) creates a new GUI_BUCKET or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Bucket_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Bucket_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Bucket

% Last Modified by GUIDE v2.5 18-Apr-2016 23:21:41

% Begin initialization code - DO NOT EDIT
global cnt;
global Acc;
%cnt = 0;
%Acc = 0;

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Bucket_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Bucket_OutputFcn, ...
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


% --- Executes just before GUI_Bucket is made visible.
function GUI_Bucket_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Bucket (see VARARGIN)

% Choose default command line output for GUI_Bucket
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_Bucket wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_Bucket_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject1, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1

% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject2, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2

% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject3, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3

% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject4, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4

% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject5, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global type_str;
table = imread('I:\Corn\CornApp2\GUI\Capture.png');
type = get(handles.uibuttongroup2,'SelectedObject');
type_str = get(type,'String');
set(handles.text9, 'String', type_str);
if strcmp(type_str,'1')
    set(handles.text21, 'String','3');
    set(handles.text22, 'String','12');
    set(handles.text23, 'String','0');
    set(handles.text24, 'String','0');
    set(handles.text25, 'String','285');
elseif strcmp(type_str,'2s')
    set(handles.text21, 'String','6');
    set(handles.text22, 'String','24');
    set(handles.text23, 'String','3');
    set(handles.text24, 'String','3');
    set(handles.text25, 'String','264');
elseif strcmp(type_str,'2')
    set(handles.text21, 'String','12');
    set(handles.text22, 'String','24');
    set(handles.text23, 'String','3');
    set(handles.text24, 'String','3');
    set(handles.text25, 'String','258');
elseif strcmp(type_str,'3s')
    set(handles.text21, 'String','18');
    set(handles.text22, 'String','48');
    set(handles.text23, 'String','3');
    set(handles.text24, 'String','3');
    set(handles.text25, 'String','228');
elseif strcmp(type_str,'3')
    set(handles.text21, 'String','24');
    set(handles.text22, 'String','48');
    set(handles.text23, 'String','3');
    set(handles.text24, 'String','3');
    set(handles.text25, 'String','222');
end 

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global type_str;
global cnt;
global Acc;

str1 = int2str(cnt);
str2 = strcat('Count : ',str1)
set(handles.text33, 'String',str2);
cnt = cnt+1;

[output, result] = simulate(type_str);
set(handles.text10, 'String', output);
disp(type_str);
disp(output);
if strcmp(type_str,output)
    im = imread('I:\Corn\CornApp2\GUI\Correct.png');
    Acc = Acc+1;
else
    im = imread('I:\Corn\CornApp2\GUI\Incorrect.png');
end
str1 = int2str(Acc*100/cnt);
str2 = strcat('Accuracy : ',str1);
str3 = strcat(str2,'%');
set(handles.text34, 'String',str3);


set(handles.text26, 'String',result(1));
set(handles.text27, 'String',result(2));
set(handles.text28, 'String',result(3));
set(handles.text29, 'String',result(4));
set(handles.text30, 'String',300-result(1)-result(2)-result(3)-result(4));

imshow(im,'Parent',handles.axes3);
