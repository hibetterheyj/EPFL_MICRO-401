function [AIC_curve, BIC_curve] =  gmm_eval(X, K_range, repeats, params)
%GMM_EVAL Implementation of the GMM Model Fitting with AIC/BIC metrics.
%
%   input -----------------------------------------------------------------
%       o X        : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o K_range  : (1 X K), Range of k-values to evaluate
%       o repeats  : (1 X 1), # times to repeat k-means
%       o params : Structure containing the paramaters of the algorithm:
%           * cov_type: Type of the covariance matric among 'full', 'iso',
%           'diag'
%           * d_type: Distance metric for the k-means initialization
%           * init: Type of initialization for the k-means
%           * max_iter_init: Max number of iterations for the k-means
%           * max_iter: Max number of iterations for EM algorithm
%
%   output ----------------------------------------------------------------
%       o AIC_curve  : (1 X K), vector of max AIC values for K-range
%       o BIC_curve  : (1 X K), vector of max BIC values for K-range
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% initialization
AIC_curve = zeros(size(K_range));
BIC_curve = zeros(size(K_range));
% repetitive evaluations
for jj = 1:numel(K_range)
    params.k = K_range(jj);
    for ii = 1: repeats
        [Priors, Mu, Sigma, ~] = gmmEM(X, params);
        [AIC, BIC] =  gmm_metrics(X, Priors, Mu, Sigma, params.cov_type);
        AIC_curve(jj) = AIC_curve(jj) + AIC;
        BIC_curve(jj) = BIC_curve(jj) + BIC;
        if ii == repeats
            AIC_curve(jj) = AIC_curve(jj)/repeats;
            BIC_curve(jj) = BIC_curve(jj)/repeats;
        end
    end
end

end