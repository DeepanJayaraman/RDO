clear;
close all;
load('optimum_robust_1000000_samples.mat')

i =2; j=2;

T = 0.05;
STD = 0.05;
x = round(x_F(i,:),2); 
x1 = -0.29; x2 = 0.3;
D1 = makedist('Normal',x1,STD);
        t1 = truncate(D1,-1,1);
        D2 = makedist('Normal',x2,STD);
        t2 = truncate(D2,-1,1);
        % Random variable
        R1 = random(t1,N,1);%
        R2 = random(t2,N,1);

F = aspenBerg([R1 R2]);
% FF = srgtsKRG
x = x_F_lmom(j,:);
x1 = -0.28; x2 = 0.3;
D1 = makedist('Normal',x1,STD);
        t1 = truncate(D1,-1,1);
        D2 = makedist('Normal',x2,STD);
        t2 = truncate(D2,-1,1);
        % Random variable
        R1 = random(t1,N,1);%
        R2 = random(t2,N,1);

Fl = aspenBerg([R1 R2]);

x = [-0.2799,-0.2799];
x1 = x(1); x2 = x(2);
D1 = makedist('Normal',x1,STD);
        t1 = truncate(D1,-1,1);
        D2 = makedist('Normal',x2,STD);
        t2 = truncate(D2,-1,1);
        % Random variable
        R1 = random(D1,N,1);%
        R2 = random(D2,N,1);

        
        
FA = aspenBerg([R1 R2]);

x = [0.2754,-0.2799];
x1 = x(1); x2 = x(2);
D1 = makedist('Normal',x1,STD);
        t1 = truncate(D1,-1,1);
        D2 = makedist('Normal',x2,STD);
        t2 = truncate(D2,-1,1);
        % Random variable
        R1 = random(t1,N,1);%
        R2 = random(t2,N,1);

FSF = aspenBerg([R1 R2]);

ah=subplot(1,1,1);
distributionPlot(FA,'histOri','right','color','r','widthDiv',[3 2],...
    'showMM',6,'xyOri','flipped');alpha(.25);
%distributionPlot(FSF,'histOri','right','color','r','widthDiv',[3 2],...
%    'showMM',6,'xyOri','flipped');alpha(.25);
distributionPlot(F,'histOri','left','color','g','widthDiv',[3 1],...
    'showMM',6,'xyOri','flipped');alpha(.25);
distributionPlot(Fl,'histOri','right','color','b','widthDiv',...
    [3 2],'showMM',6,'xyOri','flipped');alpha(.25);
h = findobj(gca,'Type','line');
h(1).Color = 'k'; h(2).Color = 'k'; h(3).Color = 'k'; 
h(4).Color = 'k'; h(5).Color = 'k'; h(6).Color = 'k'; 
h(7).Color = 'k'; h(8).Color = 'k'; h(9).Color = 'k'; 

xlabel('$f$','interpreter','latex')
ylabel('PDF')
set(gca,'fontname','times','fontsize',14,'Box','on')
% legend({'Deterministc design','25^{th} percentile','50^{th} percentile',...
%     '75^{th} percentile','RDO: C-moment','25^{th} percentile','50^{th} percentile',...
%     '75^{th} percentile', 'RDO: L-moment','25^{th} percentile','50^{th} percentile',...
%     '75^{th} percentile'},'NumColumns', 3,'fontsize',8,'location','best')

% xlim([0.75 2.5])
% ylim([0.4 1.6])
set(gca,'ytick',[])
% 
% saveas(gca,'RDO_variation_aspenberg.fig')
% set(gcf,'PaperUnits','inches','PaperPosition',[0 0  5.3 4.3])
% print('-dpng', 'RDO_variation_aspenberg.png', '-r400')