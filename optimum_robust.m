function [y,fval,exitflag,output] = optimum_robust(x0,lb,ub,Sur_F,Sur_G1,Sur_G2)
% function [y,fval,exitflag,output] = optimum(lb,ub,options,Sur_F,Sur_G1,Sur_G2)
options = optimoptions(@fmincon);%,'algorithm','sqp'
problem = createOptimProblem('fmincon','objective',...
    @objfun,'x0',x0,'lb',lb,'ub',ub,'nonlcon',@nonlcon,'options',options); %5,
% gs = GlobalSearch('StartPointsToRun','bounds-ineqs','FunctionTolerance',1e-2,'XTolerance',1e-2);
gs =MultiStart('StartPointsToRun','bounds-ineqs');
[y,fval,exitflag,output] = run(gs,problem,100);


    function y = objfun(x)
        x(3)=750;
        y = srgtsKRGEvaluate(x,Sur_F);

    end

    function [c,ceq] = nonlcon(x)
        x(3)=750;
        g11 = srgtsKRGEvaluate(x,Sur_G1);
        g1 = g11-1;
        g21 =  srgtsKRGEvaluate(x,Sur_G2);
        g2 = g21;
        
        G1 = g1 ; % change the limit for deterministic case to 400
        G2 = g2 ;
        
        
        c = [G1,G2];
        ceq = [];
        
    end
end