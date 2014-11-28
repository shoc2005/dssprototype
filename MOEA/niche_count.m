function options=niche_count(options)

%this function uses the normalized distance between two solutions (Deb, page 202)

%minvals=min(options.objvals,[],1);
%maxvals=max(options.objvals,[],1);

%options=update_share(options); %update share value;
niche_coutv=zeros(options.popsize,1);
for i=1:options.popsize;
  rank=options.ranks(i);
  solutions_in_rank=find(options.ranks==rank);
  matrix=zeros(size(solutions_in_rank,1));
  for l=1:size(matrix,1);
      for c=1:size(matrix,2);
          dist=0;
          for obj=1:options.objcount;
            dist=dist+((options.objvals(solutions_in_rank(l),obj)-options.objvals(solutions_in_rank(c),obj))/(options.objminmax{obj}.max-options.objminmax{obj}.min))^2;
          end;
          matrix(l,c)=share(sqrt(dist),options.lambaShare);  
      end;
      niche_coutv(solutions_in_rank(l))=sum(matrix(l,:));
   
  end;
end;
options.niche_coutv=niche_coutv;
end
  


function res=share(distance,lambaShare)


if distance<lambaShare;
    res=1-distance/lambaShare;
else
    res=0;
end;
end