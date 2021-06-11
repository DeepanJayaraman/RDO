clear;
n = 73; %Samples used to create design surrogate

load(['Design_surrogate_',num2str(n),'_samples'],'d','H',...
    'sur_res','sur_G1','sur_G2');

N = 1e6; %samples  size for generating moments

K = 1; % repititions

% Preallocation

response_F = ones(length(d),N); con_G1 = ones(length(d),N);
con_G2 = ones(length(d),N);
Mean_F = ones(length(d),K); STD_F = ones(length(d),K); L2_F =  ones(length(d),K);
Mean_G1 = ones(length(d),K); STD_G1 = ones(length(d),K); L2_G1 =  ones(length(d),K);
Mean_G2 = ones(length(d),K); STD_G2 = ones(length(d),K); L2_G2 =  ones(length(d),K);
B = ones(N,K); B_ext = ones(N+1,K);


for j=1:K
    for i = 1:length(d)
        % Random variable
        B = normrnd(750,50,N,1);
        
        X = [d(i)*ones(N,1),H(i)*ones(N,1),B];
        

        
        response_F(i,:) = srgtsKRGEvaluate(X,sur_res);
        con_G1(i,:) = srgtsKRGEvaluate(X,sur_G1);
        con_G2(i,:) = srgtsKRGEvaluate(X,sur_G2);
        

        
        % Moments without extremes
        
        Mean_F(i,j) = mean(response_F(i,:));
        STD_F(i,j) = std(response_F(i,:));
        Lmom = lmom(response_F(i,:),2);
        L2_F(i,j) = Lmom(2);
        
        Mean_G1(i,j) = mean(con_G1(i,:));
        STD_G1(i,j) = std(con_G1(i,:));
        Lmom = lmom(con_G1(i,:),2);
        L2_G1(i,j) = Lmom(2);
        
        Mean_G2(i,j) = mean(con_G2(i,:));
        STD_G2(i,j) = std(con_G2(i,:));
        Lmom = lmom(con_G2(i,:),2);
        L2_G2(i,j) = Lmom(2);

        
    end
end

save(['Moments_baseDoE',num2str(n),'_',num2str(N),'_samples']);

% save(['Moments_baseDoE',num2str(n),'_',num2str(N),'_samples'],'Mean_F','STD_F','L2_F',...
%     'Mean_G1','STD_G1','L2_G1','Mean_G2','STD_G2','L2_G2');





%         % Adding Extremes
%         B_ext(:,j)= [A;Ext_B];
%
%         % Data with extremes
%         X_ext = [d(i)*ones(N,1),H(i)*ones(N,1),...
%             B_ext(:,j)];
%
%         Test1(i,:,j) = srgtsKRGEvaluate(X_ext,sur_res);
%         Test2(i,:,j) = srgtsKRGEvaluate(X_ext,sur_G1);
%         Test3(i,:,j) = srgtsKRGEvaluate(X_ext,sur_G2);

%                 response_F_ext(i,:,j) = srgtsKRGEvaluate(X_ext,sur_res);
%                 con_G1_ext(i,:,j)= srgtsKRGEvaluate(X_ext,sur_G1);
%                 con_G2_ext(i,:,j) = srgtsKRGEvaluate(X_ext,sur_G2);
