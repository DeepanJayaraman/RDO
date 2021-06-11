clear;
n = 73;     % DoE
N = 1e6;     % Sample size
I = 1;    % Repetitions

load (['Analysis_surrogate_baseDoE_',num2str(n),'_',num2str(N),'_Samples'],...
    'sur_F','sur_G1','sur_G2','sur_F_SD','sur_G1_SD','sur_G2_SD',...
    'sur_F_lmom','sur_G1_lmom','sur_G2_lmom');

% Optimiation options
x0 = [50 600];   % Starting point
lb = [20 200];   % lower bound specification
ub = [80 1000];  % upper bound specification

% Preallocation
y_SD = ones(I,2); fval_SD = ones(I,1); exitflag_SD = ones(I,1);
y_lmom = ones(I,2); fval_lmom = ones(I,1); exitflag_lmom = ones(I,1);

for i = 1:I
[y_SD(i,:),fval_SD(i),exitflag_SD(i)] = optimum_robust(x0,lb,ub,...
    sur_F_SD(i),sur_G1_SD(i),sur_G2_SD(i));
[y_lmom(i,:),fval_lmom(i),exitflag_lmom(i)] = optimum_robust(x0,lb,ub,...
    sur_F_lmom(i),sur_G1_lmom(i),sur_G2_lmom(i));
end

save(['Robust_',num2str(n),'_',num2str(N),'_Samples1'],'y_SD','fval_SD','exitflag_SD',...
    'y_lmom','fval_lmom','exitflag_lmom','N')