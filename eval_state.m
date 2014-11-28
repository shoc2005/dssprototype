function [state,options,optchanged] = eval_state(options,state,flag,interval)
ts=toc;

    set(findobj('Tag','cpop'),'String',[num2str(state.Generation),'/',get(findobj('Tag','pop_count'),'String')]);
    set(findobj('Tag','cptime'),'String',sprintf('%1.2f',ts));
    prog_time=str2num(get(findobj('Tag','pop_count'),'String'))*ts;
    set(findobj('Tag','aproxtime'),'String',sprintf('%5.0f',prog_time));
    set(findobj('Tag','rem'),'String',sprintf('%5.0f',prog_time-ts*(state.Generation)));
    set(findobj('Tag','dist_g'),'String','?');
    br=get(findobj('Tag','enableEA'),'UserData');
    if br==0;
        state.StopFlag='rem';
    end;
tic;    
figure(gcf);
optchanged=[];
end