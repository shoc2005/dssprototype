function [method,method_i,problem,funcount, varcount]=get_params

methods=get(findobj('Tag','method'),'String');
method_i=get(findobj('Tag','method'),'Value');
method=methods{method_i};

problems=get(findobj('Tag','problem'),'String');
problem_i=get(findobj('Tag','problem'),'Value');

problem=problems{problem_i};

funcount=str2num(get(findobj('Tag','cc'),'String'));
varcount=str2num(get(findobj('Tag','vc'),'String'));