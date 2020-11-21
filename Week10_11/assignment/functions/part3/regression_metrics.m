function [MSE, NMSE, Rsquared] = regression_metrics( yest, y )
%REGRESSION_METRICS Computes the metrics (MSE, NMSE, R squared) for 
%   regression evaluation
%
%   input -----------------------------------------------------------------
%   
%       o yest  : (P x M), representing the estimated outputs of P-dimension
%       of the regressor corresponding to the M points of the dataset
%       o y     : (P x M), representing the M continuous labels of the M 
%       points. Each label has P dimensions.
%
%   output ----------------------------------------------------------------
%
%       o MSE       : (1 x 1), Mean Squared Error
%       o NMSE      : (1 x 1), Normalized Mean Squared Error
%       o R squared : (1 x 1), Coefficent of determination
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% init
M = size(y, 2);
MSE = 0;
NMSE = 0;
% MSE & NMSE
NMSE_num = 0;
Mu = sum(y, 2) / M;
for ii = 1:M
    % computing MSE
    MSE = MSE + sum((yest(:,ii) - y(:,ii)).^2);
    % computing NMSE num
    NMSE_num = NMSE_num + sum((Mu - y(:,ii)).^2);
    if ii == M
        MSE = MSE / M;
        NMSE_num = NMSE_num / (M-1);
        NMSE = MSE / NMSE_num;
    end
end
% Rsquared
y_bar = Mu;
yest_bar = sum(yest, 2) / M;
den_sum = 0; num_sum1 = 0; num_sum2 = 0;
for ii = 1:M
    den_sum = den_sum + (y(:,ii)-y_bar) * (yest(:,ii) - yest_bar);
    num_sum1 = num_sum1 + (y(:,ii)-y_bar).^2;
    num_sum2 = num_sum2 + (yest(:,ii) - yest_bar).^2;
end
Rsquared = sum(den_sum.^2 ./ (num_sum1 .* num_sum2));

end