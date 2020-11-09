function [ logl ] = gmmLogLik(X, Priors, Mu, Sigma)
%MY_GMMLOGLIK Compute the likelihood of a set of parameters for a GMM
%given a dataset X
%
%   input------------------------------------------------------------------
%
%       o X      : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o Priors : (1 x K), the set of priors (or mixing weights) for each
%                           k-th Gaussian component
%       o Mu     : (N x K), an NxK matrix corresponding to the centroids mu = {mu^1,...mu^K}
%       o Sigma  : (N x N x K), an NxNxK matrix corresponding to the 
%                    Covariance matrices  Sigma = {Sigma^1,...,Sigma^K}
%
%   output ----------------------------------------------------------------
%
%      o logl       : (1 x 1) , loglikelihood
%%

% constant & init
M = size(X, 2);
K = numel(Priors);
Prob = zeros(M, K);
% 1) computing the likelihood of each point
for ii = 1:K
    Prob(:,ii) = gaussPDF(X, Mu(:,ii), Sigma(:,:,ii));
end
% 2) compute the inner sum with the priors
Prob_sum = sum(Prob .* Priors, 2);
% 3) sum the log -ed probabilities
logl = sum(log(Prob_sum));

end