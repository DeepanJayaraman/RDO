function [sur_F,PRESSRMS_KRG_1,best_op2_F, best_op1_F] = KRG_forall(varargin)
% X - Input,Y - Output, Option2 - correlation model, Option1 - regression
% model
X = cell2mat(varargin(1));
Y = cell2mat(varargin(2));
Ntheta = size(X,2);

op1 = {'dace_regpoly0','dace_regpoly1'};
op2 = {'@dace_corrcubic','@dace_correxp','@dace_corrgauss','@dace_corrlin','@dace_corrspherical','@dace_corrspline'};

if nargin ==2
    
    for j = 1:length(op1)
        for i = 1:length(op2)
            
            krg(i,j) = srgtsKRGSetOptions(X, Y , @dace_fit,...
                str2func(op1{j}),...
                str2func(op2{i}), 0.1*ones(1,Ntheta), 1e-6*ones(1,Ntheta),...
                1*ones(1,Ntheta));
            [PRESSRMS_KRG(i,j)] = srgtsCrossValidation(krg(i,j));
        end
    end
    [best_op2_F, best_op1_F] = find(PRESSRMS_KRG==min(PRESSRMS_KRG(:)));
    
    sur_F = srgtsKRGFit(krg(best_op2_F, best_op1_F));
    PRESSRMS_KRG_1 = PRESSRMS_KRG(best_op2_F, best_op1_F);
    
elseif nargin == 4
    
    Option2 = cell2mat(varargin(3));
    Option1 = cell2mat(varargin(4));
    best_op2_F = Option2; best_op1_F = Option1;
    
    i = Option2; j = Option1;
    krg = srgtsKRGSetOptions(X, Y , @dace_fit,...
        str2func(op1{j}),...
        str2func(op2{i}), 0.1*ones(1,Ntheta), 1e-6*ones(1,Ntheta),...
        1*ones(1,Ntheta));
    PRESSRMS_KRG_1 = srgtsCrossValidation(krg);
    sur_F = srgtsKRGFit(krg);
    
else
    error('Number of input arguments either 2 or 4')
end