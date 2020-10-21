function [RSS, AIC, BIC] =  compute_metrics(X, labels, Mu)
%MY_METRICS Computes the metrics (RSS, AIC, BIC) for clustering evaluation
%
%   input -----------------------------------------------------------------
%
%       o X        : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o labels   : (1 x M), a vector with predicted labels labels \in {1,..,k}
%                   corresponding to the k-clusters.
%       o Mu       : (N x k), matrix where the k-th column corresponds
%                          to the k-th centroid mu_k \in R^D
%
%   output ----------------------------------------------------------------
%
%       o RSS      : (1 x 1), Residual Sum of Squares
%       o AIC      : (1 x 1), Akaike Information Criterion
%       o BIC      : (1 x 1), Bayesian Information Criteria
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[N, M] = size(X);
[~, k] = size(Mu);

% RSS
RSS=0;
for i = 1:k
    idx = labels==i;
    X_cluster = X(:,idx);
    mu = Mu(:,i);
    RSS = RSS + sum(cell2mat(arrayfun(@(i) (norm(X_cluster(:,i)-mu))^2, 1:size(X_cluster,2), ...
            'UniformOutput', false)));
end

% AIC
B = k*N;
AIC = 2*B + RSS;

% BIC
BIC = log(M)*B + RSS;


end