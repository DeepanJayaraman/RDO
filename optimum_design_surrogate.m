
clear;
x0 = [50 600];   % Starting point
lb = [20 200];   % lower bound specification
ub = [80 1000];  % upper bound specification

n=73;

load (['Design_surrogate_',num2str(n),'_samples']);

global Sur_F; global Sur_G1; global Sur_G2;
Sur_F = sur_res;
Sur_G1 = sur_G1;
Sur_G2 = sur_G2;

% Fmincon
options = optimoptions(@fmincon,'Display','iter',...
    'StepTolerance',1e-12);
[y,fval,exitflag,output] = optimum(x0,lb,ub,options,Sur_F,Sur_G1,Sur_G2);

y_fmincon=y
fval_fmincon=fval

save(['Design_surrogate_DoE_',num2str(n),'_samples_optimum'],'y_fmincon',...
    'fval_fmincon')

function [y,fval,exitflag,output] = optimum(x0,lb,ub,options,Sur_F,Sur_G1,Sur_G2)
% function [y,fval,exitflag,output] = optimum(lb,ub,options,Sur_F,Sur_G1,Sur_G2)
options = optimoptions(@fmincon,'algorithm','sqp');
problem = createOptimProblem('fmincon','objective',...
    @objfun,'x0',x0,'lb',lb,'ub',ub,'nonlcon',@nonlcon,'options',options);
gs = GlobalSearch('StartPointsToRun','bounds-ineqs'); 
% gs =MultiStart('FunctionTolerance',1e-4,'XTolerance',1e-4,'StartPointsToRun','bounds-ineqs');
[y,fval,exitflag,output] = run(gs,problem);


    function y = objfun(x)
                x(3)=750;
        y = srgtsKRGEvaluate(x,Sur_F);
    end

    function [c,ceq] = nonlcon(x)
                x(3)=750;
        g1 = srgtsKRGEvaluate(x,Sur_G1);
        g2 =  srgtsKRGEvaluate(x,Sur_G2);
        
        
        G1 = g1 - 400; % change the limit for deterministic case to 400
        G2 = g2 - 0;
        
        
        c = [G1,G2];
        ceq = [];
        
    end
end