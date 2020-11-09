function [ Priors0, Mu0, Sigma0, labels0 ] = gmmInit(X, params)
%MY_GMMINIT Computes initial estimates of the parameters of a GMM 
% to be used for the EM algorithm
%   input------------------------------------------------------------------
%
%       o X         : (N x M), a data set with M samples each being of 
%                           dimension N, each column corresponds to a datapoint.
%       o params : Structure containing the paramaters of the algorithm:
%           * cov_type: Type of the covariance matric among 'full', 'iso',
%           'diag'
%           * k: Number of clusters for the k-means initialization
%           * d_type: Distance metric for the k-means initialization
%           * init: Type of initialization for the k-means
%           * max_iter_init: Max number of iterations for the k-means
%   output ----------------------------------------------------------------
%       o Priors0   : (1 x K), the set of priors (or mixing weights) for each
%                           k-th Gaussian component
%       o Mu0       : (N x K), an NxK matrix corresponding to the centroids 
%                           mu = {mu^1,...mu^K}
%       o Sigma0    : (N x N x K), an NxNxK matrix corresponding to the 
%                       Covariance matrices  Sigma = {Sigma^1,...,Sigma^K}
%       o labels0   : (1 x M), a vector of labels \in {1,...,k} 
%                           corresponding to the k-th Gaussian component

% constant
K = params.k;
N = size(X, 1);
Sigma0 = zeros(N, N, K);
% Initialize Priors0
Priors0 = 1/K * ones(1,K);
% Compute labels0 (labels) and Mu0 (means) using K-means
[labels0, Mu0, ~, ~] =  kmeans(X, K, params.init, params.d_type, ...
                               params.max_iter_init, false);
% Compute Sigma0
for ii = 1:K
    Sigma0(:,:,ii) = compute_covariance(X(:,labels0==ii), Mu0(:,ii), params.cov_type);
end

end