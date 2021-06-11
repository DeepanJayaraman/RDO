
% clear;

% SIEMENS DATA OPTIMIZATION

% Input variables
load('data_399.mat')

% Design Variables
X1 = data_399(:,1:7);
% Noise Parameters (Material)
X2 = data_399(:,8:17);

%% Surrogate for vonmises stress and constraints
load('Design_surrogate_RBF')

%% uncertainty propagation

N = 1e6;                                      % N = sample size for uncertainty propagation
I = 399;                                     % DoE points
K = 1;                                       % Repetitions
std_P = 0.05;                                % percentage for std

%%
for k = 1:K
    for i = 1:length(X1)
        
        R1 = normrnd(X2(i,1),std_P*X2(i,1),N,1);           % Youngs modulus (Pa)
        R2 = normrnd(X2(i,2),std_P*X2(i,2),N,1);           % Poison's ratio
        R3 = normrnd(X2(i,3),std_P*X2(i,3),N,1);           % Coefficient of thermal expansion (1/oC)
        R4 = normrnd(X2(i,4),std_P*X2(i,4),N,1);           % Thermal conductivity (W/mK)
        R5 = normrnd(X2(i,5),std_P*X2(i,5),N,1);           % Heat transfer coefficient at top (W/m^2K)
        R6 = normrnd(X2(i,6),std_P*X2(i,6),N,1);           % Temperature at top (deg C)
        R7 = normrnd(X2(i,7),std_P*X2(i,7),N,1);           % temperature at bottom (deg C)
        R8 = normrnd(X2(i,8),std_P*X2(i,8),N,1);           % Heat transfer coeeficient at bottom (W/m^2K)
        R9 = normrnd(X2(i,9),std_P*X2(i,9),N,1);           % Rotational velaocity (rad/s)
        R10 = normrnd(X2(i,10),std_P*X2(i,10),N,1);        % Force (N)
        


        
        XX=(X1(i,:).*ones(N,length(X1(1,:))));
 
        
        R = [R1,R2,R3,R4,R5,R6,R7,R8,R9,R10];

        X = [XX,R];
  
        
        % Response generation
        % Response generation
        obj = srgtsRBFEvaluate(X,Sur_F);
        cons1 = srgtsRBFEvaluate(X,Sur_G1);
        cons2 = srgtsRBFEvaluate(X,Sur_G2);
        cons3 = srgtsRBFEvaluate(X,Sur_G3);
        cons4= srgtsRBFEvaluate(X,Sur_G4);
 
        
        von(i,k) = mean(obj);                           % Mean - conventional
        sd_von(i,k) = std(obj);                         % Std - Conventional
        l = lmom(obj,2);
        l2_von(i,k) = l(2);                             % Lmoment
        
        con1(i,k) = mean(cons1);                        % Mean - conventional
        sd_con1(i,k) = std(cons1);                      % Std - Conventional
        l = lmom(cons1,2);
        l2_con1(i,k) = l(2);                            % Lmoment
        
        con2(i,k) = mean(cons2);                        % Mean - conventional
        sd_con2(i,k) = std(cons2);                      % Std - Conventional
        l = lmom(cons2,2);
        l2_con2(i,k) = l(2);                            % Lmoment
        
        con3(i,k) = mean(cons3);                        % Mean - conventional
        sd_con3(i,k) = std(cons3);                      % Std - Conventional
        l = lmom(cons3,2);
        l2_con3(i,k) = l(2);                            % Lmoment
        
        con4(i,k) = mean(cons4);                        % Mean - conventional
        sd_con4(i,k) = std(cons4);                      % Std - Conventional
        l = lmom(cons4,2);
        l2_con4(i,k) = l(2);                            % Lmoment
        
    end
end


save(['Moments_generation_',num2str(N),'_samples_norm'],'von','con1','con2','con3',...
    'con4','sd_von','sd_con1','sd_con2','sd_con3','sd_con4',...
        'l2_von','l2_con1','l2_con2','l2_con3','l2_con4','X1');
