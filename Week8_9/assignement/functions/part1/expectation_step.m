function [Pk_x] = expectation_step(X, Priors, Mu, Sigma, params)
%EXPECTATION_STEP Computes the expection step of the EM algorihtm
% input------------------------------------------------------------------
%       o X         : (N x M), a data set with M samples each being of 
%                           dimension N, each column corresponds to a datapoint.
%       o Priors    : (1 x K), the set of updated priors (or mixing weights) for each
%                           k-th Gaussian component
%       o Mu        : (N x K), an NxK matrix corresponding to the CURRENT centroids mu^(0) = {mu^1,...mu^K}
%       o Sigma     : (N x N x K), an NxNxK matrix corresponding to the CURRENT Covariance matrices   
% 					Sigma^(0) = {Sigma^1,...,Sigma^K} 
%       o params    : The hyperparameters structure that contains k, the number of Gaussians
% output----------------------------------------------------------------
%       o Pk_x      : (K, M) a KxM matrix containing the posterior probabilty that a k Gaussian is responsible
%                     for generating a point m in the dataset 
%%

% constans & init
K = numel(Priors);
[~, M] = size(X);
prob_prior = zeros(K, M);

% compute prob with prior
for ii = 1:K
    prob = gaussPDF(X, Mu(:,ii), Sigma(:,:,ii)); % output 1xM
    prob_prior(ii,:) = Priors(ii) * prob;
end

% normalize across k centroid axis
Pk_x = bsxfun(@rdivide, prob_prior, sum(prob_prior));;
end

