clear;
%% OPTIMISATION - SD

N=1e6; % No. of samples
K=1; % Repetitions

load(['Analysis_surrogate_',num2str(N),'_Samples']);


% Initialization
x0 = [145.0998   73.8558   21.3815   55.3425   55.8555  198.0070   28.9065];

lb = [121,    21,  21, 21, 31, 151, 21];      % lower bound specification
ub = [147.5, 77.5, 78, 78, 88, 205, 48];      % upper bound specification

% Preallocation
x_F = ones(K,length(lb)); fval = ones(K,1); exitflag = ones(K,1);
x_F_lmom = ones(K,length(lb)); fval_lmom  = ones(K,1); exitflag_lmom  = ones(K,1);


% OPTIMISATION - SD

for k = 1:K
    % rbf
    [x_F(k,:),fval(k),exitflag(k),output] = opti(lb,lb,ub,surrrbf_F(k),...
        surrrbf_G1(k),surrrbf_G2(k),surrrbf_G3(k),surrrbf_G4(k),...
        surrrbf_F_SD(k),surrrbf_G1_SD(k),surrrbf_G2_SD(k),...
        surrrbf_G3_SD(k),surrrbf_G4_SD(k));
end


%% OPTIMISATION - L2

for k = 1:K
    % rbf
    [x_F_lmom(k,:),fval_lmom(k),exitflag_lmom(k),output_lmom] = opti(x0,lb,ub,surrrbf_F(k),...
        surrrbf_G1(k),surrrbf_G2(k),surrrbf_G3(k),surrrbf_G4(k),...
        surrrbf_F_l2(k),surrrbf_G1_l2(k),surrrbf_G2_l2(k),...
        surrrbf_G3_l2(k),surrrbf_G4_l2(k));
end

for k = 1:K
    %% vonmises stress
    load('Design_surrogate_RBF','Sur_F');
    x_R = [2.00E+11,3.00E-01,1.20E-05,6.05E+01,6.00E+00,...
        6.00E+02,3.00E+01,1.20E+02,3.77E+02,6.00E+02]; % Mean vaules of random variables
    V_SD(k) = srgtsRBFEvaluate([x_F(k,:),x_R],Sur_F);
    V_L2(k) = srgtsRBFEvaluate([x_F_lmom(k,:),x_R],Sur_F);
end

save(['optimum_robust_',num2str(N),'_samples_test'],'x_F','fval','exitflag',...
    'x_F_lmom','fval_lmom','exitflag_lmom','N','V_SD','V_L2');


% Optimization

function [y,fval,exitflag,output] = opti(x0,lb,ub,surrrbf_v,surrrbf_1,surrrbf_2,surrrbf_3,surrrbf_4,sur_F_SD,...
    sur_G1_SD,sur_G2_SD,sur_G3_SD,sur_G4_SD)
% rng (8) % Setting seed number for random number generation
options = optimoptions(@fmincon);
problem = createOptimProblem('fmincon','objective',...
    @objfun,'x0',x0,'lb',lb,'ub',ub,'nonlcon',@nonlcon,'options',options);
% gs = GlobalSearch;
gs =MultiStart;
[y,fval,exitflag,output] = run(gs,problem,100);

    function f = objfun(x)
        x1 = [x,2.00E+11,3.00E-01,1.20E-05,6.05E+01,6.00E+00,...
            6.00E+02,3.00E+01,1.20E+02,3.77E+02,6.00E+02];
        y1 = srgtsRBFEvaluate(x1,surrrbf_v); % response
        y2 =  srgtsRBFEvaluate(x1,sur_F_SD);  %SD 0r L2
        f = (y1+3*y2);
        
    end

    function [c,ceq] = nonlcon(x)
        %XR = [194000000000.000,0.290939275000000,1.17000000000000e-05,57.6105150600000,5.54897311800000,599.142184800000,29.0868317300000,102.583218100000,370.038650100000,582.045236800000];
        x1 = [x,2.00E+11,3.00E-01,1.20E-05,6.05E+01,6.00E+00,6.00E+02,3.00E+01,1.20E+02,3.77E+02,6.00E+02];
        %x1 = [x,XR];
        heat_flux = srgtsRBFEvaluate(x1,surrrbf_1)+3*srgtsRBFEvaluate(x1,sur_G1_SD);
        total_deformation = srgtsRBFEvaluate(x1,surrrbf_2)+3*srgtsRBFEvaluate(x1,sur_G2_SD);
        max_radial_stress = srgtsRBFEvaluate(x1,surrrbf_3)+3*srgtsRBFEvaluate(x1,sur_G3_SD);
        max_hoop_stress = srgtsRBFEvaluate(x1,surrrbf_4)+3*srgtsRBFEvaluate(x1,sur_G4_SD);
        
        g1 = heat_flux - 0.15; % 0.26; %0.15
        g2 = total_deformation - 70; %340; %70
        g4 = max_radial_stress - 1980; %5300; %980
        g3 = max_hoop_stress - 1050; % 2700; %550
        
        c = [g1,g2,g3,g4];
        ceq = [];
    end
end





