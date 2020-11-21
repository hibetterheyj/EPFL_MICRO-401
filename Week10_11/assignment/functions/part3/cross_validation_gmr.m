function [metrics] = cross_validation_gmr( X, y, F_fold, valid_ratio, k_range, params )
%CROSS_VALIDATION_GMR Implementation of F-fold cross-validation for regression algorithm.
%
%   input -----------------------------------------------------------------
%
%       o X         : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o y         : (P x M) array representing the y vector assigned to
%                           each datapoints
%       o F_fold    : (int), the number of folds of cross-validation to compute.
%       o valid_ratio  : (double), Testing Ratio.
%       o k_range   : (1 x K), Range of k-values to evaluate
%       o params    : parameter strcuture of the GMM
%
%   output ----------------------------------------------------------------
%       o metrics : (structure) contains the following elements:
%           - mean_MSE   : (1 x K), Mean Squared Error computed for each value of k averaged over the number of folds.
%           - mean_NMSE  : (1 x K), Normalized Mean Squared Error computed for each value of k averaged over the number of folds.
%           - mean_R2    : (1 x K), Coefficient of Determination computed for each value of k averaged over the number of folds.
%           - mean_AIC   : (1 x K), Mean AIC Scores computed for each value of k averaged over the number of folds.
%           - mean_BIC   : (1 x K), Mean BIC Scores computed for each value of k averaged over the number of folds.
%           - std_MSE    : (1 x K), Standard Deviation of Mean Squared Error computed for each value of k.
%           - std_NMSE   : (1 x K), Standard Deviation of Normalized Mean Squared Error computed for each value of k.
%           - std_R2     : (1 x K), Standard Deviation of Coefficient of Determination computed for each value of k averaged over the number of folds.
%           - std_AIC    : (1 x K), Standard Deviation of AIC Scores computed for each value of k averaged over the number of folds.
%           - std_BIC    : (1 x K), Standard Deviation of BIC Scores computed for each value of k averaged over the number of folds.
%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% init
K = numel(k_range);
N = size(X, 1);
P = size(y, 1);
metrics.mean_MSE  = zeros(1,K); metrics.std_MSE   = zeros(1,K);
metrics.mean_NMSE = zeros(1,K); metrics.std_NMSE  = zeros(1,K); 
metrics.mean_R2   = zeros(1,K); metrics.std_R2    = zeros(1,K);
metrics.mean_AIC  = zeros(1,K); metrics.std_AIC   = zeros(1,K); 
metrics.mean_BIC  = zeros(1,K); metrics.std_BIC   = zeros(1,K);
in = 1:N; out = N+1:N+P;
% run the experiments one by one
for ii = 1:K
    MSE_list = zeros(1,F_fold); NMSE_list = zeros(1,F_fold); R2_list = zeros(1,F_fold);
    AIC_list = zeros(1,F_fold); BIC_list = zeros(1,F_fold);
    params.k = k_range(ii);
    % conduct K-fold experiments
    for jj = 1:F_fold 
        [X_train, y_train, X_test, y_test ] = split_regression_data(X, y, valid_ratio);
        [Priors, Mu, Sigma] = gmmEM([X_train;y_train], params);
        [y_est, ~] = gmr(Priors, Mu, Sigma, X_test, in, out);
        [MSE_list(jj), NMSE_list(jj), R2_list(jj)] = regression_metrics(y_est, y_test);
        [AIC_list(jj), BIC_list(jj)] =  gmm_metrics([X_train;y_train], Priors, Mu, Sigma, params.cov_type);
    end
    metrics.mean_MSE(ii)  = mean(MSE_list);   metrics.std_MSE(ii)  = std(MSE_list); 
    metrics.mean_NMSE(ii) = mean(NMSE_list);  metrics.std_NMSE(ii) = std(NMSE_list);
    metrics.mean_R2(ii)   = mean(R2_list);    metrics.std_R2(ii)   = std(R2_list);
    metrics.mean_AIC(ii)  = mean(AIC_list);   metrics.std_AIC(ii)  = std(AIC_list);
    metrics.mean_BIC(ii)  = mean(BIC_list);   metrics.std_BIC(ii)  = std(BIC_list);
end

end