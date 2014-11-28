function n=save_to_db(type, data1,data2)
exp_name='DSS prototype';

%{
download http://jdbc.postgresql.org/download.html jar file of driver
copy jar file to MATLABROOT\java\... location
copy $MATLABROOT\toolbox\local\classpath.txt to other location
append jar file path to the classpath.txt and save it
override $MATLABROOT\toolbox\local\classpath.txt with new classpath.txt
start Matlab!
   
%}

conn = database('afrodita','postgres','postgres', 'org.postgresql.Driver', 'jdbc:postgresql://localhost:5432/afrodita');
if size(conn.Message,2)>0;
    error('No connection with database Afrodita',conn.Message);
end;

switch type
    case 1 %start experiment

        name=get(findobj('Tag','exp_name'),'string');
        kods=get(findobj('Tag','exp_num'),'string');
        expid=create_experiment(conn,exp_name,name,kods);
        set(findobj('Tag','exp_start'),'UserData',expid);

    case 2 %test problem start
        eksp_id=get(findobj('Tag','exp_start'),'UserData');
        
        pr_name=get(findobj('Tag','problem'),'string');
        problem_i=get(findobj('Tag','problem'),'Value');
        sql=sprintf('select opu_id from opt_uzdevums where upper(nosaukums)=upper(''%s'')',pr_name{problem_i});
        a=exec(conn,sql);
        a=fetch(a);
        opt_problem=a.Data{(1)};
        close(a);
        
        %eksp_id=get(findobj(gcf,'Tag','exp_start'),'UserData');
        al_name=get(findobj('Tag','method'),'string');
        method_i=get(findobj('Tag','method'),'Value');
        
        sql=sprintf('select opt_id from optim_algoritms where upper(nosaukums)=upper(''%s'')',al_name{method_i});
        a=exec(conn,sql);
        a=fetch(a);
        opt_algorithm=a.Data{(1)};
        close(a);
        
        options=[];
        options.m_propability=0; 
        options.popsize=0;
        options.gencount=0;
        options.lambaShare=0;
        options.iter_count=1;
        id=create_subexperiment(conn, eksp_id, opt_problem, ...
                 opt_algorithm, 1, 1, options);
        
        set(findobj('Tag','subexpid'),'String',num2str(id));   
        set(findobj('Tag','start_problem'),'UserData',[id,clock]);
        set(findobj('Tag','next'),'UserData',clock);    
             
    case 3 %test save metriks for plots
        sql=sprintf('insert into plots(pareto, progress, linijas, stabini_v, stabini_h, zirneklis, vri, attalums, iter_num, apeksid) values(%d,%d,%d,%d,%d,%d,%d,%d,%d,%d)',data1(1),data1(2),data1(3),data1(4),data1(5),data1(6),data1(7),data1(8),data2(2),data2(1));
        a=exec(conn,sql);
        close(a);
        % sql=sprintf('update ap_eksperiments set lielo_iter_skaits=%d, cpu_laiks=%f, lpp_apm=%d, stop_iem=%d', opt_id from optim_algorithms where upper(nosaukums)=upper(''%s'')',pr_name);
        
        
    case 4 %stop experiment
        data=get(findobj('Tag','start_problem'),'UserData');
        t=etime(data(1:end),clock);
        sql=sprintf('update ap_eksperiments set cpu_laiks=%f, lpp_apm=%d, stop_iem=%d, algo_ertums=%d where apeks_id=%d',t, data1(2), data1(1),data1(3), data(1));
        a=exec(conn,sql);
        close(a);
        
    case 5 %save metrics for iterations
        data=get(findobj('Tag','start_problem'),'UserData');
        apexp_id=data(1);
        iter=size(get(findobj('Tag','vri'),'Data'),1);
        
        
        
        t=etime(clock,get(findobj('Tag','next'),'UserData'));
        
        sf=get(findobj('Tag','uipanel11'),'UserData');; %attalums lidz merkim
        sf=sf(end);
        sql=sprintf('insert into metrikas (ap_eksperiments, iter_num, cpu_laiks, apmierinatiba, priority_change, step_change) values(%d, %d, %f, %f,%d,%d)',apexp_id,iter,t,sf(end),data1(1),data1(2));
        a=exec(conn,sql);
        close(a);
        set(findobj('Tag','next'),'UserData',clock);
    case 6 %save vri, objectives and varibles values
               
        data1=get(findobj('Tag','start_problem'),'UserData');
        apexp_id=data1(1);
        iter=size(get(findobj('Tag','vri'),'Data'),1);
        
        objectives(1:3)=0;
        tmp=get(findobj('Tag','curr_y'),'UserData');
        objectives(1:size(tmp,2))=tmp;
        
        variables(1:5)=0;
        tmp=get(findobj('Tag','curr_x'),'UserData');
        variables(1:size(tmp,2))=tmp;
        
        tmp=get(findobj('Tag','vri'),'Data');
        
        if strcmp(get(findobj('Tag','step'),'Visible'),'on');
            step=get(findobj('Tag','step'),'String');
            n=size(tmp,2)-1;
        else
            step='none';
            n=size(tmp,2);
        end;
        
        line={};
        for i=1:n;
            line{i}=tmp{1,i};
        end;
        vri=merge(4,line);
        
        
        sql=sprintf('insert into values (subexpid, iter_num, f1, f2, f3, x1,x2,x3,x4,x5,vri1,vri2,vri3, step) values(%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,''%s'',''%s'',''%s'',''%s'')',...
            apexp_id,iter,objectives(1),objectives(2),objectives(3),variables(1),variables(2),variables(3),variables(4),variables(5),vri{1},vri{2},vri{3}, step);
        a=exec(conn,sql);
        close(a);
end;
end

function res=merge(count, data)
res={};
for i=1:count;
    res{i}='';
end;

for i=1:size(data,2);
    if iscell(data);
        res{i}=data{i};
    else
        res{i}=num2str(data(i));
    end;
end;

end
