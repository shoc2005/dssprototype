function show_labels(src,eventdata, handle)

objnum=get(src,'UserData');

a=get(findobj(handle,'Type','Text','UserData',objnum), 'Visible');
if strcmp(a{1},'on');
    
    cl='off';
else

    cl='on';
end;
    
set(findobj(handle,'Type','Text','UserData',objnum), 'Visible', cl);