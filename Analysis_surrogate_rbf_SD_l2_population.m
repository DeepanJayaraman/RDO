clear;

n = 399; % Number of DoE
K = 1; % No of iterations
N = 1e6; % Samples

load('data_399.mat')
X = data_399(1:390,1:17);

load(['Moments_generation_',num2str(N),'_samples_norm'])
% X = X1; % Design variabls (7)


%% Analysis surrgate generation

% responce 
response_F = von;
response_G1 = con1;
response_G2 = con2;
response_G3 = con3;
response_G4 = con4;

% SD
response_F_SD  = sd_von;
response_G1_SD = sd_con1;
response_G2_SD = sd_con2;
response_G3_SD = sd_con3;
response_G4_SD = sd_con4;



%% responce  - Lmoment
% l2
response_F_l2  = l2_von;
response_G1_l2 = l2_con1;
response_G2_l2 = l2_con2;
response_G3_l2 = l2_con3;
response_G4_l2 = l2_con4;



% Preallocation
PRESSRMS_rbf =ones(6,3);

%% Response RBF----------------------------------------------------------------------
% Volume

Y = response_F;

[~,~,~,best_ord] =  rbf_fit(X(1:390,:),Y(1:390,1),10);

best_opt = 2;
for k=1:K
    surrrbf_F(k) = rbf_fit_with_options(X(1:390,:), Y(1:390,k),best_opt,best_ord);
end

% Cons1--------------------------------------------------------------------

Y = response_G1;

[~,~,~,best_ord] =  rbf_fit(X(1:390,:),Y(1:390,1),10);

for k=1:K
    surrrbf_G1(k) = rbf_fit_with_options(X(1:390,:), (Y(1:390,k)),best_opt,best_ord);
end

% Cons2--------------------------------------------------------------------

Y = response_G2;

[~,~,~,best_ord] =  rbf_fit(X(1:390,:),Y(1:390,1),10);

for k=1:K
    surrrbf_G2(k) = rbf_fit_with_options(X(1:390,:), (Y(1:390,k)),best_opt,best_ord);
end

% Cons3--------------------------------------------------------------------
Y = response_G3;

[~,~,~,best_ord] =  rbf_fit(X(1:390,:),Y(1:390,1),10);

for k=1:K
    surrrbf_G3(k) = rbf_fit_with_options(X(1:390,:), (Y(1:390,k)),best_opt,best_ord);
end

% Cons4--------------------------------------------------------------------
Y = response_G4;

[~,~,~,best_ord] =  rbf_fit(X(1:390,:),Y(1:390,1),10);

for k=1:K
    surrrbf_G4(k) = rbf_fit_with_options(X(1:390,:), (Y(1:390,k)),best_opt,best_ord);
end



%% SD 

% Volume

Y = response_F_SD;

[~,~,~,best_ord] =  rbf_fit(X(1:390,:),Y(1:390,1),10);

for k=1:K
    surrrbf_F_SD(k) = rbf_fit_with_options(X(1:390,:), (Y(1:390,k)),best_opt,best_ord);
end

% Cons1--------------------------------------------------------------------

Y = response_G1_SD;

[~,~,~,best_ord] =  rbf_fit(X(1:390,:),Y(1:390,1),10);

for k=1:K
    surrrbf_G1_SD(k) = rbf_fit_with_options(X(1:390,:), (Y(1:390,k)),best_opt,best_ord);
end

% Cons2--------------------------------------------------------------------

Y = response_G2_SD;

[~,~,~,best_ord] =  rbf_fit(X(1:390,:),Y(1:390,1),10);

for k=1:K
    surrrbf_G2_SD(k) = rbf_fit_with_options(X(1:390,:), (Y(1:390,k)),best_opt,best_ord);
end

% Cons3--------------------------------------------------------------------
Y = response_G3_SD;

[~,~,~,best_ord] =  rbf_fit(X(1:390,:),Y(1:390,1),10);

for k=1:K
    surrrbf_G3_SD(k) = rbf_fit_with_options(X(1:390,:), (Y(1:390,k)),best_opt,best_ord);
end

% Cons4--------------------------------------------------------------------
Y = response_G4_SD;

[~,~,~,best_ord] =  rbf_fit(X(1:390,:),Y(1:390,1),10);

for k=1:K
    surrrbf_G4_SD(k) = rbf_fit_with_options(X(1:390,:), (Y(1:390,k)),best_opt,best_ord);
end


%% L2

% Volume

Y = response_F_l2;

[~,~,~,best_ord] =  rbf_fit(X(1:390,:),Y(1:390,1),10);

for k=1:K
    surrrbf_F_l2(k) = rbf_fit_with_options(X(1:390,:), (Y(1:390,k)),best_opt,best_ord);
end

% Cons1--------------------------------------------------------------------

Y = response_G1_l2;

[~,~,~,best_ord] =  rbf_fit(X(1:390,:),Y(1:390,1),10);

for k=1:K
    surrrbf_G1_l2(k) = rbf_fit_with_options(X(1:390,:), (Y(1:390,k)),best_opt,best_ord);
end

% Cons2--------------------------------------------------------------------

Y = response_G2_l2;

[~,~,~,best_ord] =  rbf_fit(X(1:390,:),Y(1:390,1),10);

for k=1:K
    surrrbf_G2_l2(k) = rbf_fit_with_options(X(1:390,:), (Y(1:390,k)),best_opt,best_ord);
end

% Cons3--------------------------------------------------------------------
Y = response_G3_l2;

[~,~,~,best_ord] =  rbf_fit(X(1:390,:),Y(1:390,1),10);

for k=1:K
    surrrbf_G3_l2(k) = rbf_fit_with_options(X(1:390,:), (Y(1:390,k)),best_opt,best_ord);
end

% Cons4--------------------------------------------------------------------
Y = response_G4_l2;

[~,~,~,best_ord] =  rbf_fit(X(1:390,:),Y(1:390,1),10);

for k=1:K
    surrrbf_G4_l2(k) = rbf_fit_with_options(X(1:390,:), (Y(1:390,k)),best_opt,best_ord);
end

%%
save (['Analysis_surrogate_',num2str(N),'_Samples'],'surrrbf_F','surrrbf_G1','surrrbf_G2',...
    'surrrbf_G3','surrrbf_G4','surrrbf_F_SD','surrrbf_G1_SD','surrrbf_G2_SD',...
    'surrrbf_G3_SD','surrrbf_G4_SD','surrrbf_F_l2','surrrbf_G1_l2','surrrbf_G2_l2',...
    'surrrbf_G3_l2','surrrbf_G4_l2');


