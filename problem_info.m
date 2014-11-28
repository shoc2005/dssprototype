function [qcount, eqcount,ineqcount, varcount]=problem_info(problem)

switch problem
    case  'HANNE'
       
        wv=load('T1_true.mat');
        
        fhandles={@objectiveT1_1,@objectiveT1_2};
        ineqh=@inqualityT1;
        eqh=[];
        wv.true_pareto_x=wv.T1;
                
    case  'HANNE1'
        wv=load('HANNE1.mat');
        
        fhandles={@objectiveH1_1,@objectiveH1_2};
        ineqh=@inqualityH1;
        eqh=[];
      
    case 'DEB1'
        wv=load('DEB1.mat');
       
        fhandles={@objectiveDeb1_1,@ObjectiveDeb1_2};
        ineqh=[];
        eqh=[];
       
        
    case 'BINH1'
        
        wv=load('BINH1.mat');
        
        fhandles={@objectiveBinh1_1,@objectiveBinh1_2};
        ineqh=@inqualityBinh1;
        eqh=[];
        
        
    case 'BINH2'
        wv=load('BINH2.mat');
                
        fhandles={@objectiveBinh2_1, @objectiveBinh2_2, @objectiveBinh2_3};
        ineqh=@inqualityBinh2;
        eqh=[];
        
    case 'FONSECA1'
        wv=load('FONS1.mat');
                       
        fhandles={@objectiveFons1_1,@objectiveFons1_2};
        ineqh=[];
        eqh=[];
        
    case 'FONSECA2'
        
        wv=load('FONS2.mat');
        tol=mean(std(wv.true_pareto))/(1e+3);
       
        
        fhandles={@objectiveFons2_1,@objectiveFons2_2};
        ineqh=[];
        eqh=[];
        
    case 'KURSAWE'
        
        wv=load('KURSAWE.mat');
     
        
        fhandles={@objectiveKursaw1,@objectiveFons2_2};
        ineqh=[];
        eqh=[];
        
        
    case 'TAPPETA'
        wv=load('TAPPETA.mat');
                
        fhandles={@tappeta1,@tappeta2,@tappeta3};
        ineqh=@inqualityTappeta;
        eqh=[];
        
        
    case 'DOWNING'
        wv=load('DOWNING.mat');
               
        fhandles={@downing1,@downing2,@downing3};
        ineqh=@inqualityDowning;
        eqh=[];
                
    case 'VINNET'
        wv=load('VINNET.mat');
                
        fhandles={@vinnet1,@vinnet2,@vinnet3};
        ineqh=[];
        eqh=[];
                
    case 'VINNET2'
        wv=load('VINNET2.mat');
               
        fhandles={@vinnet2_1,@vinnet2_2,@vinnet2_3};
        ineqh=[];
        eqh=[];
               
    case 'RENDON'
        wv=load('RENDON.mat');
        
        
        fhandles={@rendon1,@rendon2};
        ineqh=[];
        eqh=[];
        
end;

varcount=size(wv.true_pareto_x,2);
qcount=size(fhandles,2);
eqcount=size(eqh,2);
if size(ineqh,2)~=0;
    ineqcount=size(feval(ineqh,ones(1,varcount)),2);
else
    ineqcount=0;
end;