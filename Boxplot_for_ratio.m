load('optimum_robust_1000000_samples_test.mat','fval','fval_lmom')

fval_pop = fval; fval_lmom_pop = fval_lmom;

NN = [10;25;50;100];

for i = 1:length(NN)
    N = NN(i);
    load(['optimum_robust_',num2str(N),'_samples_test'],...
        'fval','fval_lmom','fval_ext','fval_lmom_ext');
    
    switch N
        case 10
            fval_10 = fval./fval_pop; fval_ext_10 = fval_ext./fval_pop;
            fval_lmom_10 = fval_lmom./fval_lmom_pop; fval_lmom_ext_10 = fval_lmom_ext./fval_lmom_pop;
            V_10 = [fval_ext_10 fval_lmom_ext_10 fval_10 fval_lmom_10 ];
            
        case 25
            fval_25 = fval./fval_pop; fval_ext_25 = fval_ext./fval_pop;
            fval_lmom_25 = fval_lmom./fval_lmom_pop; fval_lmom_ext_25 = fval_lmom_ext./fval_lmom_pop;
            V_25 = [fval_ext_25 fval_lmom_ext_25 fval_25 fval_lmom_25 ];
            
        case 50
            fval_50 = fval./fval_pop; fval_ext_50 = fval_ext./fval_pop;
            fval_lmom_50 = fval_lmom./fval_lmom_pop; fval_lmom_ext_50 = fval_lmom_ext./fval_lmom_pop;
            V_50 = [fval_ext_50 fval_lmom_ext_50 fval_50 fval_lmom_50 ];
            
        case 100
            fval_100 = fval./fval_pop; fval_ext_100 = fval_ext./fval_pop;
            fval_lmom_100 = fval_lmom./fval_lmom_pop; fval_lmom_ext_100 = fval_lmom_ext./fval_lmom_pop;
            V_100 = [fval_ext_100 fval_lmom_ext_100 fval_100 fval_lmom_100 ];
    end
    
end
Box_16(V_10,V_25,V_50,V_100,'Robust deisgn - Rotor disk design')

saveas(gca,'Robust_design_rotordisk.fig')
set(gcf,'PaperUnits','inches','PaperPosition',[0 0  9.53 4.42])
print('-dpng', 'Robust_design_rotordisk.png', '-r400')



% load('optimum_robust_100000_samples_test.mat','V_SD','V_L2')
% 
% V_SD_pop = V_SD; V_L2_pop = V_L2;
% 
% NN = [10;25;50;100];
% 
% for i = 1:length(NN)
%     N = NN(i);
%     load(['optimum_robust_',num2str(N),'_samples_test'],...
%         'V_SD','V_L2','V_SD_ex','V_L2_ex');
%     
%     switch N
%         case 10
%             V_SD_10 = V_SD./V_SD_pop; V_SD_ex_10 = V_SD_ex./V_SD_pop;
%             V_L2_10 = V_L2./V_L2_pop; V_L2_ex_10 = V_L2_ex./V_L2_pop;
%             V_10 = [V_SD_10' V_L2_10' V_SD_ex_10' V_L2_ex_10'];
%             
%         case 25
%             V_SD_25 = V_SD./V_SD_pop; V_SD_ex_25 = V_SD_ex./V_SD_pop;
%             V_L2_25 = V_L2./V_L2_pop; V_L2_ex_25 = V_L2_ex./V_L2_pop;
%             V_25 = [V_SD_25' V_L2_25' V_SD_ex_25' V_L2_ex_25'];
%             
%         case 50
%             V_SD_50 = V_SD./V_SD_pop; V_SD_ex_50 = V_SD_ex./V_SD_pop;
%             V_L2_50 = V_L2./V_L2_pop; V_L2_ex_50 = V_L2_ex./V_L2_pop;
%             V_50 = [V_SD_50' V_L2_50' V_SD_ex_50' V_L2_ex_50'];
%             
%         case 100
%             V_SD_100 = V_SD./V_SD_pop; V_SD_ex_100 = V_SD_ex./V_SD_pop;
%             V_L2_100 = V_L2./V_L2_pop; V_L2_ex_100 = V_L2_ex./V_L2_pop;
%             V_100 = [V_SD_100' V_L2_100' V_SD_ex_100' V_L2_ex_100'];
%     end
%     
% end
% Box_16(V_10,V_25,V_50,V_100,'Robust deisgn - Rotor disk design')
