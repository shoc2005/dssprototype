function varargout = testingtool(varargin)
% pârbaudît uzdevumu FONSECA2 sâkuma risinâjumu =06.10.2010.

% TESTINGTOOL M-file for testingtool.fig
%      TESTINGTOOL, by itself, creates a new TESTINGTOOL or raises the existing
%      singleton*.
%
%      H = TESTINGTOOL returns the handle to a new TESTINGTOOL or the handle to
%      the existing singleton*.
%
%      TESTINGTOOL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TESTINGTOOL.M with the given input arguments.
%
%      TESTINGTOOL('Property','Value',...) creates a new TESTINGTOOL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before testingtool_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to testingtool_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help testingtool

% Last Modified by GUIDE v2.5 05-May-2014 20:37:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @testingtool_OpeningFcn, ...
                   'gui_OutputFcn',  @testingtool_OutputFcn, ...
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


% --- Executes just before testingtool is made visible.
function testingtool_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to testingtool (see VARARGIN)

% Choose default command line output for testingtool
handles.output = hObject;
javaaddpath({'C:\JDBCdriver','C:\Program Files\MATLAB\R2008b\java\jar\postgresql-9.0-801.jdbc3.jar'})
%postgresql-9.0-801.jdbc3.jar
%pg73jdbc1.jar
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes testingtool wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = testingtool_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in method.
function method_Callback(hObject, eventdata, handles)
% hObject    handle to method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from method
problems=get(hObject,'String');
problem=problems{get(hObject,'Value')};
switch problem
    case {'ISWT'}
        set(findobj(gcf,'Tag','wt1'),'String','F1<=e1');
        set(findobj(gcf,'Tag','wt2'),'String','F2<=e2');
        set(findobj(gcf,'Tag','wt3'),'String','F3<=e3');
        set(findobj(gcf,'Tag','text9'),'Visible','on');
        set(findobj(gcf,'Tag','main_obj'),'Visible','on');
        set(findobj(gcf,'Tag','step'),'Visible','off');
        set(findobj(gcf,'Tag','text17'),'Visible','off');
        set(findobj(gcf,'Tag','text9'),'String','Main criterion');
        set(findobj(gcf,'Tag','w1'),'Style','edit');
        set(findobj(gcf,'Tag','w2'),'Style','edit');
        set(findobj(gcf,'Tag','w1'),'String','');
        set(findobj(gcf,'Tag','w2'),'String','');
        set(findobj(gcf,'Tag','uipanel12'),'Visible','off');
        set(findobj(gcf,'Tag','pushbutton9'),'Visible','off');
        set(findobj(gcf,'Tag','pushbutton12'),'Visible','off');
        set(findobj(gcf,'Tag','guess'),'Visible','off');
        
    case {'GDF'}
        set(findobj(gcf,'Tag','wt1'),'String','m1');
        set(findobj(gcf,'Tag','wt2'),'String','m2');
        set(findobj(gcf,'Tag','wt3'),'String','m3');
         set(findobj(gcf,'Tag','text9'),'Visible','on');
        set(findobj(gcf,'Tag','main_obj'),'Visible','on');
        set(findobj(gcf,'Tag','step'),'Visible','on');
        set(findobj(gcf,'Tag','text17'),'Visible','on');
        set(findobj(gcf,'Tag','step'),'String','0.001');
        set(findobj(gcf,'Tag','text9'),'String','Main criterion');
        set(findobj(gcf,'Tag','w1'),'Style','edit');
        set(findobj(gcf,'Tag','w2'),'Style','edit');
        set(findobj(gcf,'Tag','w1'),'String','');
        set(findobj(gcf,'Tag','w2'),'String','');
        set(findobj(gcf,'Tag','uipanel12'),'Visible','off');
        set(findobj(gcf,'Tag','pushbutton9'),'Visible','off');
        set(findobj(gcf,'Tag','pushbutton12'),'Visible','off');
        set(findobj(gcf,'Tag','guess'),'Visible','off');
        
    case {'WSUM'}
        set(findobj(gcf,'Tag','wt1'),'String','w1');
        set(findobj(gcf,'Tag','wt2'),'String','w2');
        set(findobj(gcf,'Tag','wt3'),'String','w3');
     
        set(findobj(gcf,'Tag','text9'),'Visible','off');
        set(findobj(gcf,'Tag','main_obj'),'Visible','off');
        set(findobj(gcf,'Tag','step'),'Visible','off');
        set(findobj(gcf,'Tag','text17'),'Visible','off');
        set(findobj(gcf,'Tag','text9'),'String','Main criterion');
        set(findobj(gcf,'Tag','w1'),'Style','edit');
        set(findobj(gcf,'Tag','w2'),'Style','edit');
        set(findobj(gcf,'Tag','w1'),'String','');
        set(findobj(gcf,'Tag','w2'),'String','');
        set(findobj(gcf,'Tag','uipanel12'),'Visible','off');
        set(findobj(gcf,'Tag','pushbutton9'),'Visible','off');
        set(findobj(gcf,'Tag','pushbutton12'),'Visible','off');
        set(findobj(gcf,'Tag','guess'),'Visible','off');
        
    case {'STEM'}
        set(findobj(gcf,'Tag','wt1'),'String','Improve');
        set(findobj(gcf,'Tag','w1'),'String',{});
        set(findobj(gcf,'Tag','w1'),'Style','popupmenu');
        set(findobj(gcf,'Tag','wt2'),'String','Relax');
        set(findobj(gcf,'Tag','w2'),'String',{});
        set(findobj(gcf,'Tag','w2'),'Style','popupmenu');
       
        set(findobj(gcf,'Tag','wt3'),'String','<=e');
        %set(findobj(gcf,'Tag','text17'),'String','e_11');
        set(findobj(gcf,'Tag','text9'),'String','Criterion number:');
        set(findobj(gcf,'Tag','step'),'Visible','off');
        set(findobj(gcf,'Tag','text17'),'Visible','off');
        set(findobj(gcf,'Tag','w2'),'Visible','on');
        set(findobj(gcf,'Tag','w1'),'Visible','on');
        set(findobj(gcf,'Tag','wt3'),'Visible','on');
        set(findobj(gcf,'Tag','w3'),'Visible','on');
        set(findobj(gcf,'Tag','text9'),'Visible','on');
        set(findobj(gcf,'Tag','main_obj'),'Visible','on');
        
        
        set(findobj(gcf,'Tag','uipanel12'),'Visible','on');
        set(findobj(gcf,'Tag','pushbutton9'),'Visible','on');
        set(findobj(gcf,'Tag','pushbutton12'),'Visible','on');
        set(findobj(gcf,'Tag','guess'),'Visible','off');
    case {'GUESS'}
        
        set(findobj(gcf,'Tag','wt1'),'String','f1');
        set(findobj(gcf,'Tag','wt2'),'String','f2');
        set(findobj(gcf,'Tag','wt3'),'String','f3');
        set(findobj(gcf,'Tag','text9'),'Visible','off');
        set(findobj(gcf,'Tag','main_obj'),'Visible','off');
        set(findobj(gcf,'Tag','step'),'Visible','off');
        set(findobj(gcf,'Tag','text17'),'Visible','off');
        %set(findobj(gcf,'Tag','step'),'String','0.001');
        %set(findobj(gcf,'Tag','text9'),'String','Galvenais kritçrijs');
        set(findobj(gcf,'Tag','text9'),'String','Reference point:');
        set(findobj(gcf,'Tag','text9'),'Visible','on');
        set(findobj(gcf,'Tag','w1'),'Style','edit');
        set(findobj(gcf,'Tag','w2'),'Style','edit');
        set(findobj(gcf,'Tag','w1'),'String','');
        set(findobj(gcf,'Tag','w2'),'String','');
        set(findobj(gcf,'Tag','w3'),'String','');
        set(findobj(gcf,'Tag','w1'),'Visible','on');
        set(findobj(gcf,'Tag','w2'),'Visible','on');
        set(findobj(gcf,'Tag','w3'),'Visible','on');
        set(findobj(gcf,'Tag','uipanel12'),'Visible','off');
        set(findobj(gcf,'Tag','pushbutton9'),'Visible','off');
        set(findobj(gcf,'Tag','pushbutton12'),'Visible','off');
        set(findobj(gcf,'Tag','guess'),'Visible','on');
end;

problem_Callback(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end;
test_methods={'GDF','ISWT','WSUM','STEM','GUESS'};
set(findobj(gcf,'Tag','method'),'String',test_methods);
set(findobj(gcf,'Tag','wt1'),'String','m1');
set(findobj(gcf,'Tag','wt2'),'String','m2');
set(findobj(gcf,'Tag','wt3'),'String','m3');





% --- Executes on selection change in problem.
function problem_Callback(hObject, eventdata, handles)
% hObject    handle to problem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns problem contents as cell array
%        contents{get(hObject,'Value')} returns selected item from problem


problems=get(findobj(gcf,'Tag','problem'),'String');
problem_i=get(findobj(gcf,'Tag','problem'),'Value');


method=get(findobj(gcf,'Tag','method'),'Value');

problem=problems{problem_i};
[qcount, eqcount,ineqcount, varcount]=problem_info(problem);
set(findobj(gcf,'Tag','cc'),'String',qcount);
set(findobj(gcf,'Tag','vc'),'String',varcount);
set(findobj(gcf,'Tag','ec'),'String',eqcount);
set(findobj(gcf,'Tag','ic'),'String',ineqcount);

names={};
vri={};
set(findobj(gcf,'Tag','vri'),'ColumnName',vri);
set(findobj(gcf,'Tag','history'),'ColumnName',names);

for i=1:qcount;
    names{end+1,1}=['f',num2str(i)];
    
        switch method
            case 2 %ISWT
                vri{end+1,1}=['e',num2str(i)];
            case 1 %GDF
                vri{end+1,1}=['m',num2str(i)];
            case 3 %WSUM
                vri{end+1,1}=['w',num2str(i)];             
        end;
end;

set(findobj(gcf,'Tag','ideal'),'String','');
set(findobj(gcf,'Tag','antiidealais'),'String','');
switch method
    case 2 %ISWT
        %vri{end+1,1}=['e',num2str(i)];
    case 1 %GDF
        vri{end+1,1}='step';
    case 3 %WSUM
        %vri{end+1,1}=['w',num2str(i)];
    case 4; %STEM
        vri{1,1}='Improve';
        vri{2,1}='Relax';
        vri{3,1}='e-values';
    case 5; %GUESS
        vri{1,1}='apper values';
        vri{2,1}='lower values';
        vri{3,1}='reference point';
end;
        o=[];
        o=problem_init(problem);
        set(findobj(gcf,'Tag','ideal'),'String',['[',num2str(o.ideal),']']);
        set(findobj(gcf,'Tag','antiidealais'),'String',['[',num2str(o.znad),']']);
        o=[];


for i=1:varcount;
    names{end+1,1}=['x',num2str(i)];
end;

%set(findobj(gcf,'Tag','history'),'RowName','sâkums');
set(findobj(gcf,'Tag','history'),'ColumnName',names);
set(findobj(gcf,'Tag','vri'),'ColumnName',vri);

%problem=get(hObject,'Value');




str={};
for i=1:qcount;
    str{end+1}=num2str(i);
end;

if method<=3||method==5;
    switch qcount
        case 2
            set(findobj(gcf,'Tag','w3'),'Visible','off');
            set(findobj(gcf,'Tag','wt3'),'Visible','off');
            
            set(findobj(gcf,'Tag','up3'),'Visible','off');
            set(findobj(gcf,'Tag','lo3'),'Visible','off');
            
            
        case 3
            set(findobj(gcf,'Tag','w3'),'Visible','on');
            set(findobj(gcf,'Tag','wt3'),'Visible','on');
            set(findobj(gcf,'Tag','up3'),'Visible','on');
            set(findobj(gcf,'Tag','lo3'),'Visible','on');
    end;
else
    set(findobj(gcf,'Tag','w3'),'Visible','on');
    set(findobj(gcf,'Tag','wt3'),'Visible','on');
    set(findobj(gcf,'Tag','w2'),'Visible','on');
    set(findobj(gcf,'Tag','wt2'),'Visible','on');
end;


a=get(findobj(gcf,'Tag','main_obj'),'Value');
set(findobj(gcf,'Tag','main_obj'),'String',str);
if a>size(str,2);
    a=size(str,2);
end;    
set(findobj(gcf,'Tag','main_obj'),'Value',a);
main_obj_Callback(hObject, eventdata, handles);


opt=[];
opt=problem_init(problem,opt);

set(findobj(gcf,'Tag','cstart_y'),'UserData',opt.truePareto);
set(findobj(gcf,'Tag','cstart_y'),'Value',1);
set(findobj(gcf,'Tag','cstart_y'),'String',get_list(opt.truePareto));
set(findobj(gcf,'Tag','cstart_x'),'UserData',opt.trueParetox);

set(findobj(gcf,'Tag','cgoal_y'),'UserData',opt.truePareto);
set(findobj(gcf,'Tag','cgoal_y'),'Value',size(opt.truePareto,1));
set(findobj(gcf,'Tag','cgoal_y'),'String',get_list(opt.truePareto));
set(findobj(gcf,'Tag','cgoal_x'),'UserData',opt.trueParetox);


%set(findobj(gcf,'Tag','goal_y'),'UserData',satisfaction(opt.y0,opt.goal));
%set(findobj(gcf,'Tag','curr_x'),'UserData',opt.x0);

%ind=get(findobj('Tag','cstart_y'),'Value');
ind=1;
data=get(findobj('Tag','cstart_y'),'UserData');

set(findobj(gcf,'Tag','start_y'),'String',vals_to_string(data(ind,:), opt.Tol));
set(findobj(gcf,'Tag','start_y'),'TooltipString',vals_to_string(data(ind,:), max(opt.y0)));
set(findobj(gcf,'Tag','start_y'),'UserData',data(ind,:));

set(findobj(gcf,'Tag','curr_y'),'String',vals_to_string(data(ind,:), opt.Tol));
set(findobj(gcf,'Tag','curr_y'),'TooltipString',vals_to_string(data(ind,:), max(opt.y0)));
set(findobj(gcf,'Tag','curr_y'),'UserData',data(ind,:));

%ind=get(findobj('Tag','cstart_y'),'Value');
ind=1;
data=get(findobj('Tag','cstart_x'),'UserData');

set(findobj(gcf,'Tag','start_x'),'String',vals_to_string(data(ind,:), max(opt.x0)));
set(findobj(gcf,'Tag','start_x'),'TooltipString',vals_to_string(data(ind,:), max(opt.x0)));
set(findobj(gcf,'Tag','start_x'),'UserData',data(ind,:));

set(findobj(gcf,'Tag','curr_x'),'String',vals_to_string(data(ind,:), max(opt.x0)));
set(findobj(gcf,'Tag','curr_x'),'TooltipString',vals_to_string(data(ind,:), max(opt.x0)));
set(findobj(gcf,'Tag','curr_x'),'UserData',data(ind,:));

%ind=get(findobj('Tag','cgoal_y'),'Value');
data=get(findobj('Tag','cgoal_y'),'UserData');
ind=size(data,1);

set(findobj(gcf,'Tag','goal_y'),'String',vals_to_string(data(ind,:), opt.Tol));
set(findobj(gcf,'Tag','goal_y'),'TooltipString',vals_to_string(data(ind,:), max(opt.goal)));
set(findobj(gcf,'Tag','goal_y'),'UserData',data(ind,:));

%ind=get(findobj('Tag','cgoal_y'),'Value');
data=get(findobj('Tag','cgoal_x'),'UserData');
ind=size(data,1);

set(findobj(gcf,'Tag','goal_x'),'String',vals_to_string(data(ind,:), max(opt.goalx)));
set(findobj(gcf,'Tag','goal_x'),'TooltipString',vals_to_string(data(ind,:), max(opt.goalx)));
set(findobj(gcf,'Tag','goal_x'),'UserData',data(ind,:));

%set(findobj(gcf,'Tag','curr_x'),'String',vals_to_string(opt.x0, max(opt.x0)));
%set(findobj(gcf,'Tag','curr_x'),'TooltipString',vals_to_string(opt.x0, max(opt.x0)));




% --- Executes during object creation, after setting all properties.
function problem_CreateFcn(hObject, eventdata, handles)
% hObject    handle to problem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end;
test_problems={'HANNE', 'HANNE1','DEB1', 'BINH1', 'FONSECA1','FONSECA2','KURSAWE', 'TAPPETA', 'DOWNING','VINNET','VINNET2','RENDON'};
set(findobj(gcf,'Tag','problem'),'String',test_problems);


% --- Executes on button press in pr.
function pr_Callback(hObject, eventdata, handles)
% hObject    handle to pr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pr


% --- Executes on button press in ll.
function ll_Callback(hObject, eventdata, handles)
% hObject    handle to ll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ll


% --- Executes on button press in zd.
function zd_Callback(hObject, eventdata, handles)
% hObject    handle to zd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of zd


% --- Executes on button press in sdh.
function sdh_Callback(hObject, eventdata, handles)
% hObject    handle to sdh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of sdh


% --- Executes on button press in sdv.
function sdv_Callback(hObject, eventdata, handles)
% hObject    handle to sdv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of sdv


% --- Executes on button press in pareto.
function pareto_Callback(hObject, eventdata, handles)
% hObject    handle to pareto (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pareto


% --- Executes on button press in start_problem.
function start_problem_Callback(hObject, eventdata, handles)
% hObject    handle to start_problem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%sâkt risinâjumu no inicializâcijas 

set(findobj(gcf,'Tag','vri'),'Data',{});
set(findobj(gcf,'Tag','history'),'Data',{});
set(findobj(gcf,'Tag','goal_x'),'UserData',[]);
set(findobj(gcf,'Tag','goal_y'),'UserData',[]);

problems=get(findobj(gcf,'Tag','problem'),'String');
problem_i=get(findobj(gcf,'Tag','problem'),'Value');
set(findobj('Tag','start_problem'),'UserData',problem_i);
set(findobj('Tag','ff'),'Visible','On');

methods=get(findobj(gcf,'Tag','method'),'String');
method_i=get(findobj(gcf,'Tag','method'),'Value');

opt=[];
opt=problem_init(problems{problem_i},opt);

set(findobj(gcf,'Tag','cstart_y'),'UserData',opt.truePareto);
set(findobj(gcf,'Tag','cstart_y'),'String',get_list(opt.truePareto));
set(findobj(gcf,'Tag','cstart_x'),'UserData',opt.trueParetox);

set(findobj(gcf,'Tag','cgoal_y'),'UserData',opt.truePareto);
set(findobj(gcf,'Tag','cgoal_y'),'String',get_list(opt.truePareto));
set(findobj(gcf,'Tag','cgoal_x'),'UserData',opt.trueParetox);


cgoal_y_Callback(hObject, eventdata, handles); %init goal
cstart_y_Callback(hObject, eventdata, handles); %init start





%[vals_ff,vri,all_vals_ff,for_method]=get_prefinf;


switch method_i
    case 2 %ISWT
        x0=opt.x0;
        w=init_varvals(problems{problem_i},methods{method_i});
        switch size(opt.y0,2)
            case 2
                set(findobj(gcf,'Tag','w1'),'String',w(2));
                set(findobj(gcf,'Tag','w2'),'String',w(3));
                set(findobj(gcf,'Tag','w1'),'Visible','on');
                set(findobj(gcf,'Tag','w2'),'Visible','on');
            case 3
                set(findobj(gcf,'Tag','w1'),'String',w(2));
                set(findobj(gcf,'Tag','w2'),'String',w(3));
                set(findobj(gcf,'Tag','w3'),'String',w(4));
                set(findobj(gcf,'Tag','w1'),'Visible','on');
                set(findobj(gcf,'Tag','w2'),'Visible','on');
                set(findobj(gcf,'Tag','w3'),'Visible','on');
        end;
        
        switch w(1) %galvçnais kritçrijs
            case 1
                set(findobj(gcf,'Tag','w1'),'Visible','off');
            case 2
                set(findobj(gcf,'Tag','w2'),'Visible','off');
            case 3
                set(findobj(gcf,'Tag','w3'),'Visible','off');
        end;
        set(findobj(gcf,'Tag','main_obj'),'Value',w(1));
       %set(findobj(gcf,'Tag','ideal'),'String','');
       %set(findobj(gcf,'Tag','antiidealais'),'String','');
        
        %vri{end+1,1}=['e',num2str(i)];
    case 1 %GDF
        x0=opt.x0;
        w=init_varvals(problems{problem_i},methods{method_i});
        set(findobj(gcf,'Tag','step'),'String',w(end));
        
        switch size(opt.y0,2)
            case 2
                set(findobj(gcf,'Tag','w1'),'String',w(1));
                set(findobj(gcf,'Tag','w2'),'String',w(2));
            case 3
                set(findobj(gcf,'Tag','w1'),'String',w(1));
                set(findobj(gcf,'Tag','w2'),'String',w(2));
                set(findobj(gcf,'Tag','w3'),'String',w(3));
        end;
        
        set(findobj(gcf,'Tag','main_obj'),'Value',w(end-1));
        
        switch size(opt.y0,2)
            case 2
                set(findobj(gcf,'Tag','w1'),'Visible','on');
                set(findobj(gcf,'Tag','w2'),'Visible','on');
            case 3
                set(findobj(gcf,'Tag','w1'),'Visible','on');
                set(findobj(gcf,'Tag','w2'),'Visible','on');
                set(findobj(gcf,'Tag','w3'),'Visible','on');
        end;
        
        switch w(end-1) %galvçnais kritçrijs
            case 1
                set(findobj(gcf,'Tag','w1'),'Visible','off');
            case 2
                set(findobj(gcf,'Tag','w2'),'Visible','off');
            case 3
                set(findobj(gcf,'Tag','w3'),'Visible','off');
        end;
        set(findobj(gcf,'Tag','main_obj'),'Value',w(end-1));
        %set(findobj(gcf,'Tag','ideal'),'String','');
       %set(findobj(gcf,'Tag','antiidealais'),'String','');
       
        
        
    case 3 %WSUM
        x0=opt.x0;
        w=init_varvals(problems{problem_i},methods{method_i});
        switch size(opt.y0,2)
            case 2
                set(findobj(gcf,'Tag','w1'),'String',w(1));
                set(findobj(gcf,'Tag','w2'),'String',w(2));
                set(findobj(gcf,'Tag','w1'),'Visible','on');
                set(findobj(gcf,'Tag','w2'),'Visible','on');
            case 3
                set(findobj(gcf,'Tag','w1'),'String',w(1));
                set(findobj(gcf,'Tag','w2'),'String',w(2));
                set(findobj(gcf,'Tag','w3'),'String',w(3));
                set(findobj(gcf,'Tag','w1'),'Visible','on');
                set(findobj(gcf,'Tag','w2'),'Visible','on');
                set(findobj(gcf,'Tag','w3'),'Visible','on');
        end;
        %set(findobj(gcf,'Tag','ideal'),'String','');
       %set(findobj(gcf,'Tag','antiidealais'),'String','');
       
        
    case 4; %STEM
       set(findobj(gcf,'Tag','w1'),'String',{});
       %set(findobj(gcf,'Tag','w1'),'Value',1);
       set(findobj(gcf,'Tag','w2'),'String',{});
       %set(findobj(gcf,'Tag','w2'),'Value',1);
       set(findobj(gcf,'Tag','w3'),'String','');
       %set(findobj(gcf,'Tag','ideal'),'String','');
       %set(findobj(gcf,'Tag','antiidealais'),'String','');
       
    case 5; %GUESS
        set(findobj(gcf,'Tag','w1'),'String','');
        set(findobj(gcf,'Tag','w2'),'String','');
        set(findobj(gcf,'Tag','w2'),'String','');
        set(findobj(gcf,'Tag','up1'),'String','');
        set(findobj(gcf,'Tag','up2'),'String','');
        set(findobj(gcf,'Tag','up3'),'String','');
        set(findobj(gcf,'Tag','lo1'),'String','');
        set(findobj(gcf,'Tag','lo2'),'String','');
        set(findobj(gcf,'Tag','lo3'),'String','');
        %set(findobj(gcf,'Tag','ideal'),'String','');
        %set(findobj(gcf,'Tag','antiidealais'),'String','');
end;
 set(findobj(gcf,'Tag','next'),'String','Get first solution');

 set(findobj(gcf,'Tag','method'),'Enable','off');   
 set(findobj(gcf,'Tag','problem'),'Enable','off');
 set(findobj(gcf,'Tag','start_problem'),'Enable','off');
 set(findobj(gcf,'Tag','next'),'Enable','on');
 set(findobj(gcf,'Tag','stop_problem'),'Enable','off');
 set(findobj(gcf,'Tag','stop_problem'),'Enable','on');
 set(findobj(gcf,'Tag','vri'),'Data',[]);
 set(findobj(gcf,'Tag','history'),'Data',[]);
  set(findobj(gcf,'Tag','vri'),'RowName',{});
 set(findobj(gcf,'Tag','history'),'RowName',{});
  
 save_to_db(2); %start sub experiment
set(findobj(gcf,'Tag','pushbutton5'),'Enable','off');
 	

% --- Executes on button press in stop_problem.
function stop_problem_Callback(hObject, eventdata, handles)
% hObject    handle to stop_problem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%pos_size = get(handles.figure1,'Position');
user_response=stoping('Title','STOP'); 

switch user_response
    case 'Ok'
        set(findobj(gcf,'Tag','method'),'Enable','on');
        set(findobj(gcf,'Tag','problem'),'Enable','on');
        set(findobj(gcf,'Tag','start_problem'),'Enable','on');
        set(findobj(gcf,'Tag','stop_problem'),'Enable','off');
        set(findobj(gcf,'Tag','next'),'Enable','off');
        
       
        data=get(findobj('Tag','stop_problem'),'UserData');
        save_to_db(4,data);
        
        set(findobj(gcf,'Tag','pushbutton5'),'Enable','on');
        subexpid=str2num(get(findobj('Tag','subexpid'),'String'));
        eval_metrics(subexpid);
        
        
    case 'Cancel'
end;





% --- Executes on selection change in main_obj.
function main_obj_Callback(hObject, eventdata, handles)
% hObject    handle to main_obj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns main_obj contents as cell array
%        contents{get(hObject,'Value')} returns selected item from main_obj

methods=get(findobj(gcf,'Tag','method'),'String');
method_i=get(findobj(gcf,'Tag','method'),'Value');
switch method_i
    case 2 %ISWT
        n=get(findobj(gcf,'Tag','main_obj'),'Value');
         cc=get(findobj(gcf,'Tag','cc'),'String');
        switch str2num(cc)
            case 2
                set(findobj(gcf,'Tag','w1'),'Visible','on');
                set(findobj(gcf,'Tag','w2'),'Visible','on');
            case 3
                set(findobj(gcf,'Tag','w1'),'Visible','on');
                set(findobj(gcf,'Tag','w2'),'Visible','on');
                set(findobj(gcf,'Tag','w3'),'Visible','on');
        end;
        
         switch n %galvçnais kritçrijs
            case 1
                set(findobj(gcf,'Tag','w1'),'Visible','off');
            case 2
                set(findobj(gcf,'Tag','w2'),'Visible','off');
            case 3
                set(findobj(gcf,'Tag','w3'),'Visible','off');
        end;
        %vri{end+1,1}=['e',num2str(i)];
    case 1 %GDF
        n=get(findobj(gcf,'Tag','main_obj'),'Value');
        
        
        cc=get(findobj(gcf,'Tag','cc'),'String');
        switch str2num(cc)
            case 2
                set(findobj(gcf,'Tag','w1'),'Visible','on');
                set(findobj(gcf,'Tag','w2'),'Visible','on');
            case 3
                set(findobj(gcf,'Tag','w1'),'Visible','on');
                set(findobj(gcf,'Tag','w2'),'Visible','on');
                set(findobj(gcf,'Tag','w3'),'Visible','on');
        end;
        
        switch n %galvçnais kritçrijs
            case 1
                set(findobj(gcf,'Tag','w1'),'Visible','off');
            case 2
                set(findobj(gcf,'Tag','w2'),'Visible','off');
            case 3
                set(findobj(gcf,'Tag','w3'),'Visible','off');
        end;
        
        
        
    case 3 %WSUM
          n=get(findobj(gcf,'Tag','main_obj'),'Value');
        switch n %galvçnais kritçrijs
            case 1
                set(findobj(gcf,'Tag','w1'),'Visible','on');
                set(findobj(gcf,'Tag','m1'),'Visible','on');
            case 2
                set(findobj(gcf,'Tag','m2'),'Visible','on');
                set(findobj(gcf,'Tag','w2'),'Visible','on');
            case 3
                set(findobj(gcf,'Tag','m3'),'Visible','on');
                set(findobj(gcf,'Tag','w3'),'Visible','on');
        end;
        
        %vri{end+1,1}=['w',num2str(i)];
end;



% --- Executes during object creation, after setting all properties.
function main_obj_CreateFcn(hObject, eventdata, handles)
% hObject    handle to main_obj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function w1_Callback(hObject, eventdata, handles)
% hObject    handle to w1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of w1 as text
%        str2double(get(hObject,'String')) returns contents of w1 as a double


% --- Executes during object creation, after setting all properties.
function w1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to w1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function w2_Callback(hObject, eventdata, handles)
% hObject    handle to w2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of w2 as text
%        str2double(get(hObject,'String')) returns contents of w2 as a double
[method,method_i,problem,funcount, varcount]=get_params;

switch method
    case 'STEM'
        data=get(findobj(gcf,'Tag','w2'),'UserData');
        list=cellstr(get(findobj(gcf,'Tag','w2'),'String'));
        index=get(findobj(gcf,'Tag','w2'),'Value');
        index=list{index};
        set(findobj(gcf,'Tag','wt3'),'String',['<=e',index]);
        try
        set(findobj(gcf,'Tag','w3'),'String',num2str(data{1,str2num(index)}));
        catch
            set(findobj(gcf,'Tag','w3'),'String','');
        end
end;


% --- Executes during object creation, after setting all properties.
function w2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to w2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function w3_Callback(hObject, eventdata, handles)
% hObject    handle to w3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of w3 as text
%        str2double(get(hObject,'String')) returns contents of w3 as a double


% --- Executes during object creation, after setting all properties.
function w3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to w3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in next.
function next_Callback(hObject, eventdata, handles)
% hObject    handle to next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 set(findobj(gcf,'Tag','next'),'String','Next iteration->');
 vri_history=get(findobj(gcf,'Tag','vri'),'Data');
 history=get(findobj(gcf,'Tag','history'),'Data');
 
[method,method_i,problem,funcount, varcount]=get_params;

his={};

%{
switch method_i
    case 1 %GDF
        for i=1:funcount;
            obj_name=['w',num2str(i)];
            vri{1,i}=get(findobj(gcf,'Tag',obj_name),'String');
        end;
        vri{1,end+1}=get(findobj(gcf,'Tag','step'),'String');
        vri{1,get(findobj(gcf,'Tag','main_obj'),'Value')}='1';
        
        
        
    case 2 %ISWT
    case 3 %WSUM
        
end;
%}
[vals_ff,vri,all_vals_ff,for_method]=get_prefinf;




opt=[];
opt=problem_init(problem,opt);

x0=get(findobj(gcf,'Tag','curr_x'),'UserData');
y_0=get(findobj(gcf,'Tag','curr_y'),'UserData');
noise=get(findobj(gcf,'Tag','exp_num'),'Value');
if ~strcmp(method,'STEM');
    if sum(isnan(for_method))>=1;
        msgbox('Kâda no VRI vçrtîbâm nav skaitlis!');
        return;
        
    end;
end;

switch method
    case 'GDF'
        
        for_method=setNoise(method,noise,for_method);
        [new_x,new_y]=geoff_inicialize(x0,for_method,problem);
    case 'ISWT'
        for_method=setNoise(method,noise,for_method);
        [new_x,new_y]=iswt_inicialize(x0,for_method(1),for_method(2:end),problem);
    case 'WSUM'
        if sum(for_method)~=1;
            msgbox('Svaru vçrtîbu summai jâbût 1!');
            return;
        end;
        if ~isempty(find(for_method<=0));
            msgbox('Svaru vçrtîbâm jâbût >0 !');
            return;
        end;
        for_method=setNoise(method,noise,for_method);
        [new_x,new_y]=wsum_inicialize(x0,for_method,problem);
    case 'STEM'
        %if size(vri_history,1)==0;
        %    prev_vals=opt.y0;
        %else
            dd=get(findobj(gcf,'Tag','curr_y'),'UserData');
            prev_vals=dd(end,:);
        %end;
        opt.goal=get(findobj(gcf,'Tag','goal_y'),'UserData');
        %satFuns<=econs
        %unsatFuns<prev
        opt.y0=y_0;
        opt.x0=x0;
        [new_x,new_y]=stem_inicialize(x0,prev_vals,all_vals_ff.pasliktinat,all_vals_ff.uzlabot,all_vals_ff.e,problem,size(vri_history,1)+1,opt.ideal);
    case 'GUESS'
        [new_x,new_y]=guess_inicialize(x0,all_vals_ff.velamas,all_vals_ff.lower,all_vals_ff.upper,problem,opt.goal);
        
end;


set(findobj(gcf,'Tag','curr_x'),'UserData',new_x);
set(findobj(gcf,'Tag','curr_y'),'UserData',new_y);
set(findobj(gcf,'Tag','curr_x'),'String',num2str(new_x));
set(findobj(gcf,'Tag','curr_y'),'String',num2str(new_y));

new_goal=get(findobj('Tag','new_goal'),'Value');
if (isempty(new_goal)==0);
    if new_goal==2;
        new_goal=[str2num(get(findobj('Tag','g1'),'String')),str2num(get(findobj('Tag','g2'),'String')),str2num(get(findobj('Tag','g3'),'String'))];
         %%opt.goal=get(findobj('Tag','goal_y'),'UserData');
         s=size(opt.y0,2);
         
         satif=satisfaction(new_y,new_goal(1:s));
    else
         satif=satisfaction(new_y,get(findobj(gcf,'Tag','goal_y'),'UserData'));
    end;
else
    satif=satisfaction(new_y,get(findobj(gcf,'Tag','goal_y'),'UserData'));
end;


all_satif=get(findobj(gcf,'Tag','uipanel11'),'UserData');
all_satif(end+1)=satif;
set(findobj(gcf,'Tag','uipanel11'),'UserData',all_satif);


for i=1:funcount;
    his{1,end+1}=new_y(i);
end;

for i=1:varcount;
    his{1,end+1}=new_x(i);
end;

yvals_all= get(findobj(gcf,'Tag','start_y'),'UserData');%stores values of obtained yvalues
yvals_all(end+1,:)=new_y; %changes satisfaction
set(findobj(gcf,'Tag','start_y'),'UserData',yvals_all);

values=get(findobj(gcf,'Tag','start_x'),'UserData'); 
values(end+1,:)=new_x;
set(findobj(gcf,'Tag','start_x'),'UserData',values);

m=size(vri_history,1);
n=size(vri_history,2);
%m x n

new_history={};
m_history={};
rows={};

if n==0;
    new_history=vri;
    rows{1,1}='iter.1';
    m_history=his;
else
    for i=1:m+1;
        for j=1:n;
            new_history{i,j}='';
        end;
        
        for j=1:varcount+funcount;
            m_history{i,j}='';
        end;
        %if i==m+1;
        %    rows{i,1}='sâkums';
        %else
            rows{i,1}=['iter.',num2str(m+2-i)];
        %end;
        
    end;
    
    for i=1:size(vri,2);
        new_history{1,i}=vri{i};
    end;
    
    for i=1:size(his,2);
        m_history{1,i}=his{i}; %for criteria history
    end;
    
    
    for i=2:m+1;
        for j=1:n;
            new_history{i,j}=vri_history{i-1,j};
        end;
        
        for j=1:varcount+funcount;
            m_history{i,j}=history{i-1,j};
        end;
        
    end;
    
end;

data1=[0 0]; 
switch method
    case 'GDF'
        if size(new_history,1)>1;
            
            main_fun=get(findobj(gcf,'tag','main_obj'),'Value');
            if str2num(new_history{2,main_fun})==1;
                data1(1)=0;
            else
                data1(1)=1;
            end;
            step=get(findobj(gcf,'tag','step'),'string');
            
            if strcmp(new_history{2,end},step);
                data1(2)=0;
            else
                data1(2)=1;
            end;
        else
            data1(1)=0;
            data1(2)=0;
        end;
        
    case 'ISWT'
        if size(new_history,1)>1;
            
            main_fun=get(findobj(gcf,'tag','main_obj'),'Value');
            if strcmp(new_history{2,main_fun},'*');
                data1(1)=0;
            else
                data1(1)=1;
            end;
           %step=get(findobj(gcf,'tag','step'),'string');
            
            %if strcmp(new_history{2,end},step);
            %    data1(2)=0;
            %else
                data1(2)=0;
            %end;
        else
            data1(1)=0;
            data1(2)=0;
        end;
    case 'WSUM'
        if size(new_history,1)>1;
            
            for i=1:size(new_history,2);
                a{i}=new_history{1,i};
                b{i}=new_history{2,i};
            end;
            
            if sum(strcmp(a,b))==size(a,2);
                data1(1)=0;
            else
                data1(1)=1;
            end;
           %step=get(findobj(gcf,'tag','step'),'string');
            
            %if strcmp(new_history{2,end},step);
            %    data1(2)=0;
            %else
                data1(2)=0;
            %end;
        else
            data1(1)=0; %priority change
            data1(2)=0; %change_step_size
        end;
    case {'STEM','GUESS'}
         data1(1)=0; %priority change
         data1(2)=0; %change_step_size
end


set(findobj(gcf,'Tag','vri'),'Data',new_history);
set(findobj(gcf,'Tag','vri'),'RowName',rows);        


set(findobj(gcf,'Tag','history'),'Data',m_history);
set(findobj(gcf,'Tag','history'),'RowName',rows);  
 
refresh_Callback(hObject, eventdata, handles); 

save_to_db(5,data1);
save_to_db(6,{});
sub_id=str2num(get(findobj('Tag','subexpid'),'String'));
eval_metrics(sub_id);

% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on key press with focus on method and none of its controls.
function method_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to method (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over method.
function method_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function step_Callback(hObject, eventdata, handles)
% hObject    handle to step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of step as text
%        str2double(get(hObject,'String')) returns contents of step as a double


% --- Executes during object creation, after setting all properties.
function step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(findobj(gcf,'Tag','start_problem'),'Enable','off');
set(findobj(gcf,'Tag','problem'),'Enable','off');
set(findobj(gcf,'Tag','method'),'Enable','off');
set(findobj(gcf,'Tag','refresh'),'Enable','off');

set(findobj(gcf,'Tag','exp_start'),'Enable','on');
set(findobj(gcf,'Tag','pushbutton5'),'Enable','off');

set(findobj(gcf,'Tag','exp_num'),'Enable','on');

% --- Executes on button press in exp_start.
function exp_start_Callback(hObject, eventdata, handles)
% hObject    handle to exp_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
kods=str2num(get(findobj(gcf,'Tag','exp_num'),'String'));
if isempty(kods)==1;
    msgbox('Eksperimenta kodam jâbût skaitlim!');
    return;
end;

if (kods<0)||(kods>40);
    msgbox('Nepareizs eksperimenta kods!');
    return;
end;

%if kods==5;
    problems={'HANNE'; 'HANNE1';'DEB1';'BINH1';'FONSECA1';'FONSECA2';'KURSAWE';'TAPPETA';'DOWNING';'VINNET';'VINNET2';'RENDON'};
    set(findobj(gcf,'Tag','pareto'),'Enable','on');
    set(findobj(gcf,'Tag','exp_num'),'Value',0); %0% noise
%elseif kods==0;
%{
    problems={'FONSECA2';'KURSAWE'};
    set(findobj(gcf,'Tag','pareto'),'Enable','on');
    set(findobj(gcf,'Tag','exp_num'),'Value',0); %0% noise
else
    problems={'HANNE'; 'DEB1';'BINH1';'FONSECA1';'TAPPETA';'DOWNING';'VINNET';'VINNET2';'RENDON'};
    set(findobj(gcf,'Tag','pareto'),'Enable','off');
    
    if (kods>=25)&&(kods<=40);
        set(findobj(gcf,'Tag','exp_num'),'Value',10); % 10% nose
    elseif (kods>=10)&&(kods<=24);
        set(findobj(gcf,'Tag','exp_num'),'Value',0); %0% noise
    end;
    
end;
%}

set(findobj(gcf,'Tag','problem'),'String',problems);



set(findobj(gcf,'Tag','start_problem'),'Enable','on');
set(findobj(gcf,'Tag','problem'),'Enable','on');
set(findobj(gcf,'Tag','method'),'Enable','on');
set(findobj(gcf,'Tag','refresh'),'Enable','on');

method_Callback(handles.method, eventdata, handles);
problem_Callback(handles.problem, eventdata, handles);
save_to_db(1);


set(findobj(gcf,'Tag','exp_start'),'Enable','off');
set(findobj(gcf,'Tag','pushbutton5'),'Enable','on');

set(findobj(gcf,'Tag','exp_num'),'Enable','off');




function exp_name_Callback(hObject, eventdata, handles)
% hObject    handle to exp_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of exp_name as text
%        str2double(get(hObject,'String')) returns contents of exp_name as a double


% --- Executes during object creation, after setting all properties.
function exp_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to exp_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function exp_num_Callback(hObject, eventdata, handles)
% hObject    handle to exp_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of exp_num as text
%        str2double(get(hObject,'String')) returns contents of exp_num as a double


% --- Executes during object creation, after setting all properties.
function exp_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to exp_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over text29.
function text29_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to text29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
web web http://creativecommons.org/licenses/by/3.0/ -browser


% --- Executes during object creation, after setting all properties.
function text29_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over start_y.
function start_y_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to start_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on next and none of its controls.
function next_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to next (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in refresh.
function refresh_Callback(hObject, eventdata, handles)
% hObject    handle to refresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

pr=0;
ll=0;
zd=0;
sdh=0;
sdv=0;
pareto=0;
lppvi=0;
alm=0;
values=0;


if get(findobj(gcf,'Tag','pr'),'Value')==1;
    pr=1;
end;

if get(findobj(gcf,'Tag','ll'),'Value')==1;
    ll=1;
end;

if get(findobj(gcf,'Tag','zd'),'Value')==1;
    zd=1;
end;

if get(findobj(gcf,'Tag','sdv'),'Value')==1;
    sdv=1;
end;

if get(findobj(gcf,'Tag','sdh'),'Value')==1;
    sdh=1;
end;

if get(findobj(gcf,'Tag','pareto'),'Value')==1;
    pareto=1;
end;

if get(findobj(gcf,'Tag','lppvi'),'Value')==1;
    lppvi=1;
end;

if get(findobj(gcf,'Tag','alm'),'Value')==1;
    alm=1;
end;

len=get(findobj(gcf,'Tag','len'),'Value');
values=get(findobj(gcf,'Tag','start_y'),'UserData');



show_plots(pr,ll,zd,sdh,sdv,pareto,lppvi,alm, values, len);



% --- Executes on button press in lppvi.
function lppvi_Callback(hObject, eventdata, handles)
% hObject    handle to lppvi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of lppvi


% --- Executes on selection change in len.
function len_Callback(hObject, eventdata, handles)
% hObject    handle to len (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns len contents as cell array
%        contents{get(hObject,'Value')} returns selected item from len


% --- Executes during object creation, after setting all properties.
function len_CreateFcn(hObject, eventdata, handles)
% hObject    handle to len (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in alm.
function alm_Callback(hObject, eventdata, handles)
% hObject    handle to alm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of alm


% --- Executes on selection change in popupmenu5.
function popupmenu5_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu5


% --- Executes during object creation, after setting all properties.
function popupmenu5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu6.
function popupmenu6_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu6


% --- Executes during object creation, after setting all properties.
function popupmenu6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu7.
function popupmenu7_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu7


% --- Executes during object creation, after setting all properties.
function popupmenu7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on step and none of its controls.
function step_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to step (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
if strcmp(eventdata.Character,',')==1;
    msgbox('Lietojiet punktu kâ decimâlzîmi!');
end;


% --- Executes on key press with focus on w3 and none of its controls.
function w3_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to w3 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
if strcmp(eventdata.Character,',')==1;
    msgbox('Lietojiet punktu kâ decimâlzîmi!');
end;


% --- Executes on key press with focus on w2 and none of its controls.
function w2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to w2 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
if strcmp(eventdata.Character,',')==1;
    msgbox('Lietojiet punktu kâ decimâlzîmi!');
end;


% --- Executes on key press with focus on w1 and none of its controls.
function w1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to w1 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
if strcmp(eventdata.Character,',')==1;
    msgbox('Lietojiet punktu kâ decimâlzîmi!');
end;


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
m=get(findobj(gcf,'Tag','uzlabot'),'Value');

    numbers=get(findobj(gcf,'Tag','main_obj'),'String');
    value=numbers(get(findobj(gcf,'Tag','main_obj'),'Value'));
    d=sum(ismember(get(findobj(gcf,'Tag','w1'),'String'),value));
    d2=sum(ismember(get(findobj(gcf,'Tag','w2'),'String'),value));
    if d~=1&&d2~=1;
        if m==1;
            
            uzlabot=get(findobj(gcf,'Tag','w1'),'String');
            uzlabot(end+1)=value;
            
            
            set(findobj(gcf,'Tag','w1'),'String',uzlabot);
            set(findobj(gcf,'Tag','w1'),'Value',size(uzlabot,2));
        else
            pasliktinat=get(findobj(gcf,'Tag','w2'),'String');
            pasliktinat(end+1)=value;
           
            
            set(findobj(gcf,'Tag','w2'),'String',pasliktinat);
            set(findobj(gcf,'Tag','w2'),'Value',size(pasliktinat,2));
            w2_Callback(hObject, eventdata, handles)
            
        end;
    end;
    


% --- Executes on button press in uzlabot.
function uzlabot_Callback(hObject, eventdata, handles)
% hObject    handle to uzlabot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of uzlabot


% --- Executes on button press in pasliktinat.
function pasliktinat_Callback(hObject, eventdata, handles)
% hObject    handle to pasliktinat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pasliktinat


% --- Executes on button press in clear_uzlabot.
function clear_uzlabot_Callback(hObject, eventdata, handles)
% hObject    handle to clear_uzlabot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
list=get(findobj(gcf,'Tag','w1'),'String');
index=get(findobj(gcf,'Tag','w1'),'Value');
list=delete_elem(list,index);
set(findobj(gcf,'Tag','w1'),'String',list);
set(findobj(gcf,'Tag','w1'),'Value',size(list,2));



% --- Executes on button press in clear_pasliktinat.
function clear_pasliktinat_Callback(hObject, eventdata, handles)
% hObject    handle to clear_pasliktinat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
list=get(findobj(gcf,'Tag','w2'),'String');
index=get(findobj(gcf,'Tag','w2'),'Value');
list=delete_elem(list,index);
set(findobj(gcf,'Tag','w2'),'String',list);
set(findobj(gcf,'Tag','w2'),'Value',size(list,2));

try
    data=get(findobj(gcf,'Tag','w2'),'UserData');
    data{index,1}=[];
    data{index,2}=[];
    data{index,3}=[];
    set(findobj(gcf,'Tag','w2'),'UserData',data);
catch
    
end;

%set(findobj(gcf,'Tag','w2'),'String',{});


% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 data=get(findobj(gcf,'Tag','w2'),'UserData');
 %index=get(findobj(gcf,'Tag','w2'),'Value');
         list=cellstr(get(findobj(gcf,'Tag','w2'),'String'));
        index=str2num(list{get(findobj(gcf,'Tag','w2'),'Value')})

 data{1,index}=str2num(get(findobj(gcf,'Tag','w3'),'String'));

 set(findobj(gcf,'Tag','w2'),'UserData',data);

function strcell=delete_elem(strcell,item_index)
        tmp={};
        strcell=cellstr(strcell);
        for i=1:size(strcell,1);
            if i~=item_index;
                tmp{end+1}=strcell{i};
            end;
        end;
        strcell=tmp;



function up1_Callback(hObject, eventdata, handles)
% hObject    handle to up1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of up1 as text
%        str2double(get(hObject,'String')) returns contents of up1 as a double


% --- Executes during object creation, after setting all properties.
function up1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to up1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function up2_Callback(hObject, eventdata, handles)
% hObject    handle to up2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of up2 as text
%        str2double(get(hObject,'String')) returns contents of up2 as a double


% --- Executes during object creation, after setting all properties.
function up2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to up2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function up3_Callback(hObject, eventdata, handles)
% hObject    handle to up3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of up3 as text
%        str2double(get(hObject,'String')) returns contents of up3 as a double


% --- Executes during object creation, after setting all properties.
function up3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to up3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lo1_Callback(hObject, eventdata, handles)
% hObject    handle to lo1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lo1 as text
%        str2double(get(hObject,'String')) returns contents of lo1 as a double


% --- Executes during object creation, after setting all properties.
function lo1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lo1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lo2_Callback(hObject, eventdata, handles)
% hObject    handle to lo2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lo2 as text
%        str2double(get(hObject,'String')) returns contents of lo2 as a double


% --- Executes during object creation, after setting all properties.
function lo2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lo2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lo3_Callback(hObject, eventdata, handles)
% hObject    handle to lo3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lo3 as text
%        str2double(get(hObject,'String')) returns contents of lo3 as a double


% --- Executes during object creation, after setting all properties.
function lo3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lo3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
 %set(findobj(gcf,'Tag','next'),'String','Nâkama iterâcija->');
 vri_history=get(findobj(gcf,'Tag','vri'),'Data');
 history=get(findobj(gcf,'Tag','history'),'Data');
 values=get(findobj(gcf,'Tag','start_y'),'UserData');
 dist=get(findobj(gcf,'Tag','uipanel11'),'UserData');
new_values=[];
new_dist=[];
 
[method,method_i,problem,funcount, varcount]=get_params;

new_history={};
for i=1:size(history,1);
    
    for j=1:size(history,2);
        if i>1;
            new_history{i-1,j}=history{i,j};
        end;
    end;
end;

new_values=values(1:end-1,:);
new_dist=dist(1:end-1);
        
new_vri_history={};
for i=1:size(history,1);
    for j=1:size(vri_history,2);
        if i>1;
            new_vri_history{i-1,j}=vri_history{i,j};
           
        end;
    end;
    
end;

new_x=[];
new_y=[];
if size(new_history,1)>0;
    for i=1:funcount;
        new_y(i)=new_history{1,i};
    end;


    for j=1:varcount;
        new_x(j)=new_history{1,funcount+j};
    end;
end;

if size(new_history,1)==0;
    new_x=get(findobj(gcf,'Tag','start_x'),'UserData');
    new_x=new_x(1,:);
    new_y=get(findobj(gcf,'Tag','start_y'),'UserData');
    new_y=new_y(1,:);
end;


set(findobj(gcf,'Tag','curr_x'),'UserData',new_x);
set(findobj(gcf,'Tag','curr_y'),'UserData',new_y);
set(findobj(gcf,'Tag','curr_x'),'String',num2str(new_x));
set(findobj(gcf,'Tag','curr_y'),'String',num2str(new_y));

set(findobj(gcf,'Tag','vri'),'Data',new_vri_history);
set(findobj(gcf,'Tag','history'),'Data',new_history);  

set(findobj(gcf,'Tag','start_y'),'UserData',new_values);
set(findobj(gcf,'Tag','uipanel11'),'UserData', new_dist);

rows={};
m=size(new_vri_history,1);

if size(new_history,1)>0;
    for i=1:size(new_vri_history,1);
            rows{i,1}=['iter.',num2str(m-i+1)];
    end;
end;;    
set(findobj(gcf,'Tag','vri'),'RowName',rows); 
set(findobj(gcf,'Tag','history'),'RowName',rows);

%set(findobj(gcf,'Tag','len'),'Value');

 
refresh_Callback(hObject, eventdata, handles); 
%save_to_db(5,data1);
%save_to_db(6,{});


% --- Executes on selection change in cstart_y.
function cstart_y_Callback(hObject, eventdata, handles)
% hObject    handle to cstart_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns cstart_y contents as cell array
%        contents{get(hObject,'Value')} returns selected item from cstart_y
y_i=get(findobj(gcf,'Tag','cstart_y'),'Value');
all_vals=get(findobj(gcf,'Tag','cstart_y'),'UserData');


set(findobj(gcf,'Tag','start_y'),'UserData',all_vals(y_i,:));
set(findobj(gcf,'Tag','start_y'),'String',num2str(all_vals(y_i,:)));
set(findobj(gcf,'Tag','curr_y'),'UserData',all_vals(y_i,:));
set(findobj(gcf,'Tag','curr_y'),'String',num2str(all_vals(y_i,:)));

all_vals=get(findobj(gcf,'Tag','cstart_x'),'UserData');
set(findobj(gcf,'Tag','start_x'),'UserData',all_vals(y_i,:));
set(findobj(gcf,'Tag','start_x'),'String',num2str(all_vals(y_i,:)));

set(findobj(gcf,'Tag','curr_x'),'UserData',all_vals(y_i,:));
set(findobj(gcf,'Tag','curr_x'),'String',num2str(all_vals(y_i,:)));

satif=satisfaction(get(findobj(gcf,'Tag','start_y'),'UserData'),get(findobj(gcf,'Tag','goal_y'),'UserData'));
set(findobj(gcf,'Tag','uipanel11'),'UserData',satif);

% --- Executes during object creation, after setting all properties.
function cstart_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cstart_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in cgoal_y.
function cgoal_y_Callback(hObject, eventdata, handles)
% hObject    handle to cgoal_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns cgoal_y contents as cell array
%        contents{get(hObject,'Value')} returns selected item from cgoal_y
y_i=get(findobj(gcf,'Tag','cgoal_y'),'Value');
all_vals=get(findobj(gcf,'Tag','cgoal_y'),'UserData');
if y_i>size(all_vals,1);
    y_i=size(all_vals,1);
end;

set(findobj(gcf,'Tag','goal_y'),'UserData',all_vals(y_i,:));
set(findobj(gcf,'Tag','goal_y'),'String',num2str(all_vals(y_i,:)));

all_vals=get(findobj(gcf,'Tag','cgoal_x'),'UserData');
set(findobj(gcf,'Tag','goal_x'),'UserData',all_vals(y_i,:));
set(findobj(gcf,'Tag','goal_x'),'String',num2str(all_vals(y_i,:)));

satif=satisfaction(get(findobj(gcf,'Tag','start_y'),'UserData'),get(findobj(gcf,'Tag','goal_y'),'UserData'));
set(findobj(gcf,'Tag','uipanel11'),'UserData',satif);



% --- Executes during object creation, after setting all properties.
function cgoal_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cgoal_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cstart_x_Callback(hObject, eventdata, handles)
% hObject    handle to cstart_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cstart_x as text
%        str2double(get(hObject,'String')) returns contents of cstart_x as a double


% --- Executes during object creation, after setting all properties.
function cstart_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cstart_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cgoal_x_Callback(hObject, eventdata, handles)
% hObject    handle to cgoal_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cgoal_x as text
%        str2double(get(hObject,'String')) returns contents of cgoal_x as a double


% --- Executes during object creation, after setting all properties.
function cgoal_x_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cgoal_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ff.
function ff_Callback(hObject, eventdata, handles)
% hObject    handle to ff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns ff contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ff


% --- Executes during object creation, after setting all properties.
function ff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in enableEA.
function enableEA_Callback(hObject, eventdata, handles)
% hObject    handle to enableEA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

open('ea_params.fig');



