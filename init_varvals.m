function varvals=init_varvals(problem,method)

switch upper(problem)
    case  'HANNE'
        dim=2;
    case  'HANNE1'
        dim=2;
    case 'DEB1'
        dim=2;
    case 'BINH1'
        dim=2;
    case 'FONSECA1'
        dim=2;
    case 'FONSECA2'
        dim=2;
    case 'KURSAWE'
        dim=2;
    case 'TAPPETA'
        dim=3;
    case 'DOWNING'
        dim=3;
    case 'VINNET'
        dim=3;
    case 'VINNET2'
        dim=3;
    case 'RENDON'
        dim=2;
        
end;

switch upper(method)
    case 'ISWT'
      varvals=[1,ones(1,dim).*100];  
    case {'WSUM','GOALATT'}
        varvals=[ones(1,dim)./dim];
    case 'GDF'
      varvals=[ones(1,dim)./dim,1,0.5];  
    case 'GUESS'
        varvals=[ones(1,3*dim)./dim];
    case 'STEM'
        varvals=[[1:dim],[1:dim],[1:dim]];
end;