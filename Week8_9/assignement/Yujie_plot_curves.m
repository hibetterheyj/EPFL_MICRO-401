function [] = Yujie_plot_curves(AIC_curve,BIC_curve,params,datasetName,folder)
%PLOT_CURVES Summary of this function goes here
%   Detailed explanation goes here
figure('Color',[1 1 1]);
plot(AIC_curve,'--o', 'LineWidth', 1); hold on;
plot(BIC_curve,'--o', 'LineWidth', 1); hold on;
xlabel('K')
legend('AIC', 'BIC')
titleName = ['GMM (' params.cov_type ') Model Fitting Evaluation on ' datasetName];
title(titleName);
saveas(gcf,[folder datasetName '_' params.cov_type],'png'); % png
grid on

fprintf([datasetName '_' params.cov_type ' Finished!!!\n']);
end

