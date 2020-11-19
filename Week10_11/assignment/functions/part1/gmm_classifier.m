function [Yest] = gmm_classifier(Xtest, models, labels)
%GMM_CLASSIFIER Classifies datapoints of X_test using ML Discriminant Rule
%   input------------------------------------------------------------------
%
%       o Xtest    : (N x M_test), a data set with M_test samples each being of
%                           dimension N, each column corresponds to a datapoint.
%       o models    : (1 x N_classes) struct array with fields:
%                   | o Priors : (1 x K), the set of priors (or mixing weights) for each
%                   |            k-th Gaussian component
%                   | o Mu     : (N x K), an NxK matrix corresponding to the centroids
%                   |            mu = {mu^1,...mu^K}
%                   | o Sigma  : (N x N x K), an NxNxK matrix corresponding to the
%                   |            Covariance matrices  Sigma = {Sigma^1,...,Sigma^K}
%       o labels    : (1 x N_classes) unique labels of X_test.
%   output ----------------------------------------------------------------
%       o Yest  :  (1 x M_test), a vector with estimated labels y \in {0,...,N_classes}
%                   corresponding to X_test.
%%
    
% assuming equal class distribution

% init
N_classes = numel(labels);
M_test = size(Xtest, 2);
K = numel(models(1).Priors);
minus_log_lik = zeros(N_classes, M_test);

% ML Discriminant Rule to estimate labels
for ii = 1:N_classes
    Priors = models(ii).Priors;
    Mu = models(ii).Mu;
    Sigma = models(ii).Sigma;
    %Compute the likelihood of each datapoint for each K
    P_xi = zeros(K,M_test);
    for jj=1:K
        P_xi(jj,:) = gaussPDF(Xtest, Mu(:,jj), Sigma(:,:,jj));
    end
    %Compute the total log likelihood
    alpha_P_xi = Priors*P_xi;
    alpha_P_xi(alpha_P_xi < realmin) = realmin;
    minus_log_lik(ii,:) = -log(alpha_P_xi);
end
[~, est] = min(minus_log_lik);
Yest = labels(est);

end