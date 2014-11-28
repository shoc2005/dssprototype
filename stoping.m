function varargout = stoping(varargin)
% STOPING M-file for stoping.fig
%      STOPING, by itself, creates a new STOPING or raises the existing
%      singleton*.
%
%      H = STOPING returns the handle to a new STOPING or the handle to
%      the existing singleton*.
%
%      STOPING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STOPING.M with the given input arguments.
%
%      STOPING('Property','Value',...) creates a new STOPING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before stoping_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to stoping_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help stoping

% Last Modified by GUIDE v2.5 22-Sep-2010 13:54:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @stoping_OpeningFcn, ...
                   'gui_OutputFcn',  @stoping_OutputFcn, ...
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


% --- Executes just before stoping is made visible.
function stoping_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to stoping (see VARARGIN)

% Choose default command line output for stoping
handles.output = 'Yes';

% Update handles structure
guidata(hObject, handles);

% Insert custom Title and Text if specified by the user
if(nargin > 3)
    for index = 1:2:(nargin-3),
        switch lower(varargin{index})
        case 'title'
            set(hObject, 'Name', varargin{index+1});
        case 'string'
            set(handles.string, 'String', varargin{index+1});
        otherwise
            error('Invalid input arguments');
        end;
    end;
end;


% Determine the position of the dialog - centered on the callback figure
% if available, else, centered on the screen

% UIWAIT makes stoping wait for user response (see UIRESUME)
% uiwait(handles.figure1);
uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = stoping_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
delete(handles.figure1);


% --- Executes on button press in yes_button.
function yes_button_Callback(hObject, eventdata, handles)
% hObject    handle to yes_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = get(hObject,'String');

% Update handles structure
guidata(hObject, handles);

% Use UIRESUME instead of delete because the OutputFcn needs
% to get the updated handles structure.
 stop_c=get(findobj(gcf,'Tag','popupmenu3'),'value');
        
        
        switch stop_c
            case 2 %merkis ir sasniegts
                satisf_i=get(findobj(gcf,'Tag','t_proc'),'value');
                satisf=get(findobj(gcf,'Tag','t_proc'),'string');
                satisf=str2double(satisf(satisf_i));
                stop_iem=7;
            case 3 %merkis nav sasniegts
                stop_iem=get(findobj(gcf,'Tag','t_kapec'),'value');
                satisf=0;
        end;
        ertums_i=get(findobj(gcf,'Tag','ert'),'value');
        ertums=get(findobj(gcf,'Tag','ert'),'string');
        ertums=str2double(ertums(ertums_i));
        
set(findobj('Tag','stop_problem'),'UserData',[stop_iem,satisf,ertums]);      


uiresume(handles.figure1);


% --- Executes on button press in no_button.
function no_button_Callback(hObject, eventdata, handles)
% hObject    handle to no_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = get(hObject,'String');

% Update handles structure
guidata(hObject, handles);

% Use UIRESUME instead of delete because the OutputFcn needs
% to get the updated handles structure.
uiresume(handles.figure1);

% --- Executes on selection change in t_proc.
function t_proc_Callback(hObject, eventdata, handles)
% hObject    handle to t_proc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns t_proc contents as cell array
%        contents{get(hObject,'Value')} returns selected item from t_proc


% --- Executes during object creation, after setting all properties.
function t_proc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t_proc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in t_kapec.
function t_kapec_Callback(hObject, eventdata, handles)
% hObject    handle to t_kapec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns t_kapec contents as cell array
%        contents{get(hObject,'Value')} returns selected item from t_kapec


% --- Executes during object creation, after setting all properties.
function t_kapec_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t_kapec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3
val=get(hObject,'Value');
if val==2;
    set(findobj(gcf,'Tag','yes_button'),'Enable','on');
    set(findobj(gcf,'Tag','t_lpp'),'Visible','on');
    set(findobj(gcf,'Tag','t_proc'),'Visible','on');
    set(findobj(gcf,'Tag','t_navmerkis'),'Visible','off');
    set(findobj(gcf,'Tag','t_kapec'),'Visible','off');
    
    
elseif val==3;
    set(findobj(gcf,'Tag','yes_button'),'Enable','on');
    set(findobj(gcf,'Tag','t_navmerkis'),'Visible','on');
    set(findobj(gcf,'Tag','t_kapec'),'Visible','on');
    set(findobj(gcf,'Tag','t_lpp'),'Visible','off');
    set(findobj(gcf,'Tag','t_proc'),'Visible','off');
end;




% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
if isequal(get(handles.figure1, 'waitstatus'), 'waiting')
    % The GUI is still in UIWAIT, us UIRESUME
    uiresume(handles.figure1);
else
    % The GUI is no longer waiting, just close it
    delete(handles.figure1);
end


% --- Executes on selection change in ert.
function ert_Callback(hObject, eventdata, handles)
% hObject    handle to ert (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns ert contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ert


% --- Executes during object creation, after setting all properties.
function ert_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ert (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


