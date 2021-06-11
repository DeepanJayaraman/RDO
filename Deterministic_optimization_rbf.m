clear;
load('Design_surrogate_RBF_1.mat','Sur_F','Sur_G1','Sur_G2',...
    'Sur_G3','Sur_G4')

% Initialization
x0 = [145.0998   73.8558   21.3815   55.3425   55.8555  198.0070   28.9065];

lb = [121,    21,  21, 21, 31, 151, 21];        % lower bound specification
ub = [147.5, 77.5, 78, 78, 88, 205, 48];        % upper bound specification

options = optimoptions('fmincon','Display','iter');

[x_F,fval,exitflag,output]= opti(x0,lb,ub,...
    Sur_F,Sur_G1,Sur_G2,...
    Sur_G3,Sur_G4);

% save('Deterministic_SF','x_F','fval','exitflag');

function [y,fval,exitflag,output] = opti(x0,lb,ub,surrRBF_v,surrRBF_1,surrRBF_2,surrRBF_3,surrRBF_4)
% rng default
options = optimoptions(@fmincon);
problem = createOptimProblem('fmincon','objective',...
    @objfun,'x0',x0,'lb',lb,'ub',ub,'nonlcon',@nonlcon,'options',options);
gs =GlobalSearch;
%('StartPointsToRun','bounds-ineqs');
[y,fval,exitflag,output] = run(gs,problem);

    function y = objfun(x)
        x1 = [x,2.00E+11,3.00E-01,1.20E-05,6.05E+01,6.00E+00,6.00E+02,3.00E+01,1.20E+02,3.77E+02,6.00E+02];
        y = srgtsRBFEvaluate(x1,surrRBF_v);
    end

    function [c,ceq] = nonlcon(x)
        x1 = [x,2.00E+11,3.00E-01,1.20E-05,6.05E+01,6.00E+00,6.00E+02,3.00E+01,1.20E+02,3.77E+02,6.00E+02];
        heat_flux = srgtsRBFEvaluate(x1,surrRBF_1);
        total_deformation = srgtsRBFEvaluate(x1,surrRBF_2);
        max_radial_stress = srgtsRBFEvaluate(x1,surrRBF_3);
        max_hoop_stress = srgtsRBFEvaluate(x1,surrRBF_4);
        
        g1 = heat_flux - 0.15; % 0.26; %0.15
        g2 = total_deformation - 70; %340; %70
        g4 = max_radial_stress - 1980; %5300; %980
        g3 = max_hoop_stress - 1050; % 2700; %550
%         g5 = 1.5*srgtsRBFEvaluate(x1,surrRBF_v)-1.0704e+03; 
        c = [g1,g2,g3,g4];
        ceq = [];
    end
end

