function [y,fval,exitflag,output] = optimum_robust(x0,lb,ub,Sur_F,Sur_G1,Sur_G2,Sur_F_SD,Sur_G1_SD,Sur_G2_SD)
% function [y,fval,exitflag,output] = optimum(lb,ub,options,Sur_F,Sur_G1,Sur_G2)
% options = optimoptions(@fmincon,'algorithm','sqp');
problem = createOptimProblem('fmincon','objective',...
    @objfun,'x0',x0,'lb',lb,'ub',ub,'nonlcon',@nonlcon); %5,'options',options
gs = GlobalSearch;%('StartPointsToRun','bounds-ineqs','FunctionTolerance',1e-2,'XTolerance',1e-2);
% gs =MultiStart('StartPointsToRun','bounds');
[y,fval,exitflag,output] = run(gs,problem);


    function y = objfun(x)
        x(3)=750;
        y1 = srgtsKRGEvaluate(x,Sur_F);
        y2 = srgtsKRGEvaluate(x,Sur_F_SD);
        
        y = y1+y2;
    end

    function [c,ceq] = nonlcon(x)
        x(3)=750;
        g11 = srgtsKRGEvaluate(x,Sur_G1);
        g12 = srgtsKRGEvaluate(x,Sur_G1_SD);
        g1 = g11+g12-1;
        g21 =  srgtsKRGEvaluate(x,Sur_G2);
        g22 = srgtsKRGEvaluate(x,Sur_G2_SD);
        g2 = g21+g22;
        
        G1 = g1 ; % change the limit for deterministic case to 400
        G2 = g2 ;
        
        
        c = [G1,G2];
        ceq = [];
        
    end
end