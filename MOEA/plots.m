function handle=plots(options)
plots_path='C:\dss_prototype\next_step\plots\'

handle=0;

last_iteration='-og'; %for last iteration
first_iteration='-ob'; %for first iteration
proc_iteration='-or'; %for run process
selected='-or'; % for best selected from population

% options.ref if figures need to call from other programs with own subplots

x=size(options.plots,1);
n=round(x/2);
m=fix(x/2);

if n>m;
    row=2;
    col=n;
else
    row=n;
    col=2;
end;

if x==1;
    row=1;
    col=1;
end;
    if options.ref==0;
        handle=subplot(row,col,1);
    end;


    
for i=1:row;
   for j=1:col;
        for p=1:x; % used selected plots
            if options.ref==0; % for MOGA algorithm
                subplot(row,col,p);
            end;
            %structure that represent plot information
            %options.plots{p,2} - represent plot number
            %options.plots{p,3}- return structure of plot values
            
            if options.gen==1;
                gr_opt=first_iteration;
            elseif options.gen==options.gencount;
                gr_opt=last_iteration;
            else 
                gr_opt=proc_iteration;
            end;
            
            
            
            if (strcmp(options.plots{p,1},'obj'))||(options.plots{p,2}==1); %plot values of objectives {2}-x axis and {3}-y axis
                %example of 'obj' sturcture number Nr.1
                %plot_elem.x -variable number
                %plot_elem.ya -objective number for x axis
                %plot_elem.yb -objective number for y axis
                %title(sprintf('Generation count=%d, Share value=%3.3f',options.gen, options.lambaShare)); 
                indx=options.plots{p,4};
                
                plot_elem=options.plots{p,3};
                
                if plot_elem.x~=0; 
                   xlabel(sprintf('x_%d',plot_elem.x)); 
                   ylabel(sprintf('f_%d',plot_elem.ya)); 
                else
                   xlabel(sprintf('f_%d',plot_elem.ya));
                   ylabel(sprintf('f_%d',plot_elem.yb));
                end;
                hold on;
%                axis([options.objminmax{plot_elem.ya}.min options.objminmax{plot_elem.ya}.max options.objminmax{plot_elem.yb}.min options.objminmax{plot_elem.yb}.max]);
               
                for i=1:size(options.objvals,1);
                    
                    if indx==i;
                        gr_opt=selected;
                    else
                        gr_opt=last_iteration;
                    end;
                    
                    hold on;
                    if plot_elem.x~=0; %if only one objective exists
                        plot(options.varvals(i,plot_elem.x),options.objvals(i,plot_elem.ya),gr_opt);
                        drawnow;
                    else
                        plot(options.objvals(i,plot_elem.ya),options.objvals(i,plot_elem.yb),gr_opt);
                        drawnow;
                    end;
                    
                end;
                
                %if options.gen==options.gencount;
                %    if options.truePareto~=size(options.truePareto,1);
                %        parfor i=1:size(options.truePareto,1);
                %            plot(options.truePareto(i,plot_elem.ya),options.truePareto(i,plot_elem.yb),'-or');
                %        end;
                %    end;
                %end;
            end; % end 'obj'

             if (strcmp(options.plots{p,1},'xvals'))||(options.plots{p,2}==2); %plot values of objectives {2}-x axis and {3}-y axis
                %example of 'xvals' sturcture number Nr.2
                %plot_elem.xa -variable number fo x axis
                %plot_elem.xb -variable number for y axis
                %title(sprintf('Generation=%d, Share value=%3.3f',options.gen, options.lambaShare)); 
                plot_elem=options.plots{p,3};
                
                
                xlabel(sprintf('x_%d',plot_elem.xa));
                ylabel(sprintf('x_%d',plot_elem.xb));
                hold on;
                
                
                indx=options.plots{p,4};
                
                parfor i=1:options.popsize;
                    if indx==i;
                        gr_opt=selected;
                    else
                        gr_opt=last_iteration;
                    end;
                    plot(options.varvals(i,plot_elem.xa),options.varvals(i,plot_elem.xb),gr_opt);
                    drawnow; 
                end;

            end; % end 'xvals
            
              if (strcmp(options.plots{p,1},'gd'))||(options.plots{p,2}==3); %plot general distance value for population
                
                title('General Distance (GD)'); 
                xlabel('generation number/iteration');
                ylabel('GD');
                hold on;
                grid on;
                plot(options.gendist,'-bs');
                set(findobj('Type','axes'),'XTick',[1:1:options.iter_count]);
                drawnow; 
                
            end; % end 'geberal distance'
            
              if (strcmp(options.plots{p,1},'bestvalue'))||(options.plots{p,2}==4); %plot individuals un print a best solution by scaled fitness
                
                %hold on;
                
                bar(options.scaled_fit','b');
                title(sprintf('Values of Solutions and best value is %d',min(options.scaled_fit))); 
                xlabel('solutios');
                ylabel('values');
                
                drawnow; 
                
              end; % end 'geberal distance'
              
             if (strcmp(options.plots{p,1},'erratio'))||(options.plots{p,2}==5); %plot error ratio
                
                %hold on;
                
                grid on;
                plot(options.erratio,'b');
                set(findobj('Type','axes'),'XTick',[1:1:options.iter_count]);
                title('Error Ratio'); 
                xlabel('generation number/iteration');
                ylabel('ER');
                
                drawnow; 
                
              end; % end 'plot error ratio'
              
              if (strcmp(options.plots{p,1},'spacing'))||(options.plots{p,2}==6); %plot error ratio
                
                %hold on;
                
                grid on;
                plot(options.spacing,'b');
                set(findobj('Type','axes'),'XTick',[1:1:options.iter_count]);
                title('Spacing'); 
                xlabel('generation number/iteration');
                ylabel('SP');
                
                drawnow; 
                
              end; % end 'spacing'
              
              if (strcmp(options.plots{p,1},'mparerror'))||(options.plots{p,2}==7); %plot error ratio
                
                %hold on;
                
                grid on;
                plot(options.mparetoer,'b');
                set(findobj('Type','axes'),'XTick',[1:1:options.iter_count]);
                title('Max Pareto Front Error'); 
                xlabel('generation number/iteration');
                ylabel('ME');
                
                drawnow; 
                
              end; % end 'max pareto front error'
              
              if (strcmp(options.plots{p,1},'ovng'))||(options.plots{p,2}==8); %plot error ratio
                %if options.gen==options.gencount;
                    %hold on;
                    grid on;
                    r=[options.ovng(:),options.ovngr(:)];
                    %r=[sum(options.ovng),sum(options.ovngr)];
                    bar(r,'group');
                    title('Overall Nondominated Vector Generation and Ratio'); 
                    legend('OVNG','OVNGR');
                    xlabel('1-ONVG, 2-ONVGR');
                    ylabel('count/value');
                    %                   drawnow; 
                %end;

              end; % end 'Overall Nondominated Vector Generation'
              
              if (strcmp(options.plots{p,1},'waves'))||(options.plots{p,2}==9); %plot error ratio ====reserved for
                
                %hold on;
                grid on;
                plot(options.waves,'b');
                set(findobj(gca,'Type','axes'),'XTick',[1:1:options.iter_count]);
                
                title('Waves'); 
                xlabel('generation number/iteration');
                ylabel('Max dominated count');
                
                drawnow; 
                
              end; % end 'Waves'
              
              if (strcmp(options.plots{p,1},'conver'))||(options.plots{p,2}==10); %plot error ratio
                
                hold on;
                grid on;
                plot(options.conver,'b');
                set(findobj('Type','axes'),'XTick',[1:1:options.iter_count]);
                title('Progress measure -absolute convergence'); 
                xlabel('generation number/iteration');
                ylabel('PM');
                
                drawnow; 
                
              end; % end 'Progress measure -absolute convergence'
              
                 if (strcmp(options.plots{p,1},'stdgd'))||(options.plots{p,2}==11); %plot error ratio
                
                hold on;
                grid on;
                plot(options.stdgd,'b');
                set(findobj('Type','axes'),'XTick',[1:1:options.iter_count]);
                title('Standart Deviation from General Distance'); 
                xlabel('generation number/iteration');
                ylabel('STDGD');
                
                drawnow; 
                
              end; % end 'stdgd'
              
              
               if (strcmp(options.plots{p,1},'satisf'))||(options.plots{p,2}==12); %DM satisfacion
                
                grid on;
                   hold on;
                plot(options.xstick,options.satisf,'-bs','LineWidth',2,...
                'MarkerEdgeColor','b',...
                'MarkerFaceColor','r',...
                'MarkerSize',5);
                if options.ref==0;
                    N=options.iter_count;
                else
                    N=size(options.satisf,2);
                end;
                set(findobj(gca,'Type','axes'),'XTickLabel',options.xstick,'XTick',options.xstick);    
                %set(findobj(gca,'Type','axes'),'XTickLabel',[options.iter_count-N+1:1:options.iter_count+1],'XTick',[1:1:options.iter_count+1]);
                title('Euclidean distance to the goal solution'); 
                xlabel('Iteration');
                ylabel('Distance');
                
                drawnow;
                sub_id=str2num(get(findobj('Tag','subexpid'),'String'));
                print(gcf, '-dpng', [plots_path,num2str(sub_id),'_dist.png']);
               
                
              end; % end 'stdgd'
              
               if (strcmp(options.plots{p,1},'steps'))||(options.plots{p,2}==13); %plot error ratio ====reserved for
                handle=gca;
                hold on;
                plot_elem=options.plots{p,3};
                for i=1:size(options.truePareto,1);
                    
                    if size(options.goal,2)==2;
                        plot(options.truePareto(i,plot_elem.ya), options.truePareto(i,plot_elem.yb),'-or');
                    else
                        plot3(options.truePareto(i,plot_elem.ya), options.truePareto(i,plot_elem.yb),options.truePareto(i,3),'-or');
                    end;
                end;
                handle=gca;
                
                if size(options.goal,2)==2;
                    
                    plot(options.goal(1, plot_elem.ya),options.goal(plot_elem.ya, plot_elem.yb),'--rs','LineWidth',1,...
                        'MarkerEdgeColor','k',...
                        'MarkerFaceColor','r',...
                        'MarkerSize',5);
                    %text(options.goal(1, plot_elem.ya)+0.02,options.goal(1, plot_elem.yb)+0.02,'goal');
                    
                    plot(options.y0(1, plot_elem.ya),options.y0(plot_elem.ya, plot_elem.yb),'--rs','LineWidth',1,...
                        'MarkerEdgeColor','k',...
                        'MarkerFaceColor','g',...
                        'MarkerSize',5);
                else
                    plot3(options.goal(1, plot_elem.ya),options.goal(1, plot_elem.yb),options.goal(1,3),'--rs','LineWidth',1,...
                        'MarkerEdgeColor','k',...
                        'MarkerFaceColor','r',...
                        'MarkerSize',5);
                    %text(options.goal(1, plot_elem.ya)+0.02,options.goal(1, plot_elem.yb)+0.02,'goal');
                    
                    plot3(options.y0(1, plot_elem.ya),options.y0(1, plot_elem.yb),options.y0(1,3),'--rs','LineWidth',1,...
                        'MarkerEdgeColor','k',...
                        'MarkerFaceColor','g',...
                        'MarkerSize',5);
                    
                end;
              %  text(options.goal(1, plot_elem.ya)+0.02,options.goal(1, plot_elem.yb)+0.02,'start');
                
                
                obj=options.objvals;
                N=size(options.objvals,1);
                for i=1:size(obj,1);
                    if i>1;
                    
                    if size(options.goal,2)==2;
                        plot(obj(i, plot_elem.ya),obj(i, plot_elem.yb),'-og');
                        text(obj(i, plot_elem.ya)+0.02,obj(i, plot_elem.yb)+0.02,num2str(options.iter_count-N+i));
                    else
                        plot3(obj(i, plot_elem.ya),obj(i, plot_elem.yb),obj(i, 3),'-og');
                        text(obj(i, plot_elem.ya)+0.02,obj(i, plot_elem.yb)+0.02,obj(i, 3)+0.02,num2str(options.iter_count-N+i));
                    end;
                    end;
                end;
                %title('Teorçtiskâ Pareto kopa');
                xlabel(sprintf('f_%d',plot_elem.ya));
                ylabel(sprintf('f_%d',plot_elem.yb));
                
                if size(options.goal,2)==3;
                    zlabel(sprintf('f_%d',3));
                end;
                
               sub_id=str2num(get(findobj('Tag','subexpid'),'String'));
                print(gcf, '-dpng', [plots_path,num2str(sub_id),'_pareto.png']);
                 
              end; % end 'steps'
              
              %plot preference information from DM
              if (strcmp(options.plots{p,1},'pref_inf'))||(options.plots{p,2}==14); %plot DM preference information
                  
                  
                          ml={};             
                  switch options.method;
                      case 'GDF'
                          
                            for i0=1:size(options.pref_inf,2);
                                if i0==(size(options.pref_inf,2)-1);
                                    ml{i0}=sprintf('Main criterion');
                                elseif i0==(size(options.pref_inf,2));
                                    ml{i0}=sprintf('Step');
                                else
                                    ml{i0}=sprintf('Marginal value m_%d',i0);
                                end;
                                
                            end;
                         
                            
                      case 'WSUM'
                          pos=size(options.pref_inf,2)+1;
                          for i0=1:size(options.pref_inf,1);
                             options.pref_inf(i0,pos)=sum(options.pref_inf(i0,:));
                          end;
                          
                            if options.ref==1;
                                for i0=1:size(options.pref_inf,2);
                                    ml{i0}=sprintf('w_%d',i0);
                                end;
                                
                            else
                                for i0=1:size(options.pref_inf,2)-1;
                                    ml{i0}=sprintf('w_%d',i0);
                                end;
                                    ml{end+1}='Sum of Weights';
                                    
                                
                            end;
                         
                          
                         
                      case 'ISWT'
                          ml{1}='Fun number';
                          for i0=1:size(options.pref_inf,2)-1;
                              ml{end+1}=sprintf('Upper value for f_%d',i0);                                                            
                          end;
                         
                            
                  end;
                  
                  grid on;
                  if size(options.pref_inf,1)==1;
                      options.pref_inf(2,:)=0;
                      bar(options.pref_inf);
                  else
                    bar(options.xstick,options.pref_inf);
                  end;
                  
                 
                  %title('Values of DM`s preference information');
                  xlabel('iteration');
                  ylabel('preference information');
                  legend(ml,'Location','best');
                  N=size(options.pref_inf,1);
                  title(['metode ',options.method,'']);  
                  
                  if options.ref==0;
                  %    N=options.iter_count;
                  set(findobj(gca,'Type','axes'),'XTickLabel',[0:1:options.iter_count],'XTick',[1:1:options.iter_count+1]);     
                  
                  else
                  %    N=size(options.satisf,2);
                  set(findobj(gca,'Type','axes'),'XTickLabel',[1:1:options.iter_count],'XTick',[1:1:options.iter_count]);     
                  
                  end;
                  %set(findobj(gca,'Type','axes'),'XTickLabel',[options.iter_count-N+1:1:options.iter_count+1],'XTick',[1:1:options.iter_count]);      
                      
                  
                  
                  drawnow;
                                    
              end;
              
              if (strcmp(options.plots{p,1},'opt_params'))||(options.plots{p,2}==15); %plot DM preference information
                  
                  title({sprintf('Method %s',options.method);...       
                  sprintf('Problem %s',options.problem);...
                  'Decison Maker type MOGA binary-coded';...
                  'MOGA options:';...
                  sprintf('  Lambda share value=%.2f',options.lambaShare);...
                  sprintf('  Population size=%d',options.popsize);...
                  sprintf('  Generation count=%d',options.gen);... 
                  sprintf('  Mutation probability=%.2f',options.m_propability);...
                  sprintf('  Genom length=%d',options.gen_length);...
                  sprintf('  Crosspoint=%d',options.crosspoint);...
                  sprintf('  Variable count=%d',options.varcount);...
                  sprintf('Noise=%d%%',options.noise);...
                  sprintf('Current goal [%2.3f, %2.3f]',options.goal(1),options.goal(2));...
                  sprintf('Current solution in objectives space [%2.3f, %2.3f]',options.metrics.objvals(end,1),options.metrics.objvals(end,2));...
                  sprintf('Current solution in variable space [%2.3f, %2.3f]',options.x0(1),options.x0(2));...
                  sprintf('Tolerance for objectives= %2.3f',options.Tol);...
                  sprintf('Euclid distance to the goal= %3.4f',options.satisf(end));
                  sprintf('Iterarion number= %d of %d (optional)',options.iter, options.iter_count);...
                  sprintf('Repeat number= %d of %d',options.repeat, options.repeat_count)},'HorizontalAlignment','Left','Position',[0 0 0]);
                  
                    
              %h = gca;
                  axis (handle,'off');
                  axis (handle,'tight');
              end;
                  
                  
                  
   end;
end;

            
end