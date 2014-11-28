function varargout = ea_params(varargin)
% EA_PARAMS M-file for ea_params.fig
%      EA_PARAMS, by itself, creates a new EA_PARAMS or raises the existing
%      singleton*.
%
%      H = EA_PARAMS returns the handle to a new EA_PARAMS or the handle to
%      the existing singleton*.
%
%      EA_PARAMS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EA_PARAMS.M with the given input arguments.
%
%      EA_PARAMS('Property','Value',...) creates a new EA_PARAMS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ea_params_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ea_params_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ea_params

% Last Modified by GUIDE v2.5 27-Jun-2014 14:52:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ea_params_OpeningFcn, ...
                   'gui_OutputFcn',  @ea_params_OutputFcn, ...
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


% --- Executes just before ea_params is made visible.
function ea_params_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ea_params (see VARARGIN)

% Choose default command line output for ea_params
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ea_params wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ea_params_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in ea_m.
function ea_m_Callback(hObject, eventdata, handles)
% hObject    handle to ea_m (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns ea_m contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ea_m


% --- Executes during object creation, after setting all properties.
function ea_m_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ea_m (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pop_count_Callback(hObject, eventdata, handles)
% hObject    handle to pop_count (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pop_count as text
%        str2double(get(hObject,'String')) returns contents of pop_count as a double


% --- Executes during object creation, after setting all properties.
function pop_count_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pop_count (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ind_count_Callback(hObject, eventdata, handles)
% hObject    handle to ind_count (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ind_count as text
%        str2double(get(hObject,'String')) returns contents of ind_count as a double


% --- Executes during object creation, after setting all properties.
function ind_count_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ind_count (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mut_Callback(hObject, eventdata, handles)
% hObject    handle to mut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mut as text
%        str2double(get(hObject,'String')) returns contents of mut as a double


% --- Executes during object creation, after setting all properties.
function mut_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function maxiter_Callback(hObject, eventdata, handles)
% hObject    handle to maxiter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxiter as text
%        str2double(get(hObject,'String')) returns contents of maxiter as a double


% --- Executes during object creation, after setting all properties.
function maxiter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxiter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles anduser user data (see GUIDATA)
viv=get(findobj('Tag','viv_desc'),'UserData');
methods=get(findobj('Tag','method'),'String');
method_i=get(findobj('Tag','method'),'Value');
if strcmp(methods{method_i},'GDF');
    qc=str2num(get(findobj('Tag','cc'),'String'));
    if qc==2;
        set(findobj('Tag','w1'),'String',num2str(viv(1)));
        set(findobj('Tag','w2'),'String',num2str(viv(2)));
        set(findobj('Tag','main_obj'),'Value',viv(3));
        set(findobj('Tag','step'),'String',num2str(viv(4)));
    elseif qc==3;
        set(findobj('Tag','w1'),'String',num2str(viv(1)));
        set(findobj('Tag','w2'),'String',num2str(viv(2)));
        set(findobj('Tag','w3'),'String',num2str(viv(3)));
        set(findobj('Tag','main_obj'),'Value',viv(4));
        set(findobj('Tag','step'),'String',num2str(viv(5)));
    end;
end;

if strcmp(methods{method_i},'GUESS');
    qc=str2num(get(findobj('Tag','cc'),'String'));
    if qc==2;
        set(findobj('Tag','w1'),'String',num2str(viv(1)));
        set(findobj('Tag','w2'),'String',num2str(viv(2)));
        set(findobj('Tag','lo1'),'String',num2str(viv(3)));
        set(findobj('Tag','lo2'),'String',num2str(viv(4)));
        set(findobj('Tag','up1'),'String',num2str(viv(5)));
        set(findobj('Tag','up2'),'String',num2str(viv(6)));
        
    elseif qc==3;
        set(findobj('Tag','w1'),'String',num2str(viv(1)));
        set(findobj('Tag','w2'),'String',num2str(viv(2)));
        set(findobj('Tag','w3'),'String',num2str(viv(3)));
        set(findobj('Tag','lo1'),'String',num2str(viv(4)));
        set(findobj('Tag','lo2'),'String',num2str(viv(5)));
        set(findobj('Tag','lo3'),'String',num2str(viv(6)));
        set(findobj('Tag','up1'),'String',num2str(viv(7)));
        set(findobj('Tag','up2'),'String',num2str(viv(8)));
        set(findobj('Tag','up3'),'String',num2str(viv(9)));
    end;
end;

if strcmp(methods{method_i},'STEM');
    
    
    sz=str2num(get(findobj('Tag','cc'),'String'));
    
    st=sz;
    satFuns=viv(1:st);
    st=sz+1;
    unsatFuns=viv(st:sz*2);
    st=sz*2+1;
    econs=viv(st:sz*3);
    
    %satFuns=unique(sort(fix(satFuns)))';
    %unsatFuns=unique(sort(fix(unsatFuns)));
    
    satFuns=(round(satFuns));
    unsatFuns=(round(unsatFuns));
    
    satFuns=find(satFuns==1);
    unsatFuns=find(unsatFuns==1);
    ec={[],[],[]};
    for i=1:size(econs,2);
        ec{1,i}=econs(i);
    end;
    
    mcell={};
    for i=1:size(unsatFuns,2);
        mcell{i,1}=num2str(unsatFuns(i));
    end;
    
    set(findobj('Tag','w1'),'String',mcell);
    set(findobj('Tag','w1'),'Visible','on');
    set(findobj('Tag','w1'),'Value',size(unsatFuns,2));
    mcell={};
    for i=1:size(satFuns,2);
        mcell{i,1}=num2str(satFuns(i));
    end;
    
    set(findobj('Tag','w2'),'String',mcell);
    set(findobj('Tag','w1'),'Value',size(satFuns,2));
    set(findobj('Tag','w2'),'UserData',ec);
    
    uzlabot=get(findobj('Tag','w1'),'String');
    set(findobj('Tag','w1'),'Value',size(uzlabot,2));
    %set(findobj('Tag','w2'),'Value',size(uzlabot,2));
    pasliktinat=get(findobj('Tag','w2'),'String');
    set(findobj('Tag','w2'),'Value',1);
    %set(findobj('Tag','main_obj'),'Value',viv(3));
    %set(findobj('Tag','step'),'String',num2str(viv(4)));
    
end;

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
problems=get(findobj('Tag','problem'),'String');
problem_i=get(findobj('Tag','problem'),'Value');
methods=get(findobj('Tag','method'),'String');
method_i=get(findobj('Tag','method'),'Value');
set(findobj('Tag','enableEA'),'UserData',1); %enble EA control

subexp=str2num(get(findobj('Tag','subexpid'),'String'));
set(findobj('Tag','viv_desc'),'String','-');
set(findobj('Tag','dist_g'),'String','-');
set(findobj('Tag','c_pop'),'String','-');
set(findobj('Tag','cptime'),'String','-');
set(findobj('Tag','rem'),'String','-');
set(findobj('Tag','aproxtime'),'String','-');
figure(gcf);
[eaopt,yvals]=testM(methods{method_i},problems{problem_i},1, 1,0,subexp);

set(findobj('Tag','enableEA'),'UserData',0); %disable EA control



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(findobj('Tag','enableEA'),'UserData',0); %disable EA control



function g1_Callback(hObject, eventdata, handles)
% hObject    handle to g1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of g1 as text
%        str2double(get(hObject,'String')) returns contents of g1 as a double


% --- Executes during object creation, after setting all properties.
function g1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to g1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function g2_Callback(hObject, eventdata, handles)
% hObject    handle to g2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of g2 as text
%        str2double(get(hObject,'String')) returns contents of g2 as a double


% --- Executes during object creation, after setting all properties.
function g2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to g2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function g3_Callback(hObject, eventdata, handles)
% hObject    handle to g3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of g3 as text
%        str2double(get(hObject,'String')) returns contents of g3 as a double


% --- Executes during object creation, after setting all properties.
function g3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to g3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in new_goal.
function new_goal_Callback(hObject, eventdata, handles)
% hObject    handle to new_goal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns new_goal contents as cell array
%        contents{get(hObject,'Value')} returns selected item from new_goal


% --- Executes during object creation, after setting all properties.
function new_goal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to new_goal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


