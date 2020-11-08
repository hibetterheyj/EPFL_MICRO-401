function [Priors,Mu,Sigma] = maximization_step(X, Pk_x, params)
%MAXIMISATION_STEP Compute the maximization step of the EM algorithm
%   input------------------------------------------------------------------
%       o X         : (N x M), a data set with M samples each being of 
%       o Pk_x      : (K, M) a KxM matrix containing the posterior probabilty
%                     that a k Gaussian is responsible for generating a point
%                     m in the dataset, output of the expectation step
%       o params    : The hyperparameters structure that contains k, the number of Gaussians
%                     and cov_type the coviariance type
%   output ----------------------------------------------------------------
%       o Priors    : (1 x K), the set of updated priors (or mixing weights) for each
%                           k-th Gaussian component
%       o Mu        : (N x K), an NxK matrix corresponding to the updated centroids 
%                           mu = {mu^1,...mu^K}
%       o Sigma     : (N x N x K), an NxNxK matrix corresponding to the
%                   updated Covariance matrices  Sigma = {Sigma^1,...,Sigma^K}
%%

% constans & init
[N, M] = size(X);
K = size(Pk_x, 1);
Sigma = zeros(N, N, K);

% update
% priors (1 x K)
Priors = sum(Pk_x, 2)'/M;

% mean (N x K)
% Mu_num = zeros(N,K);
% for ii = 1:K
%     for jj = 1:M
%         Mu_num(:,ii) = Pk_x(ii,jj) * X(:,jj) + Mu_num(:,ii);
%     end
% end
% Mu = bsxfun(@rdivide, Mu_num, M * Priors);
Mu = zeros(N,K);
for ii=1:K 
   Mu(:,ii) = sum(bsxfun(@times,Pk_x(ii,:),X),2)/sum(Pk_x(ii,:)); 
end

% covariance matrix
Sigma_num = zeros(N,N,K);
switch params.cov_type
    case {"full", "diag"}
        for ii = 1:K
%             for jj = 1:M
%                 Sigma_num(:,:,ii) = Pk_x(ii,jj) * (X(:,jj)-Mu(:,ii)) * (X(:,jj)-Mu(:,ii))' ...
%                     + Sigma_num(:,:,ii);
%             end
%             Sigma(:,:,ii) = Sigma_num(:,:,ii) / (M * Priors(ii));
            Sigma_num = bsxfun(@times, Pk_x(ii,:), bsxfun(@minus, X, Mu(:,ii)))*bsxfun(@minus, X, Mu(:,ii))';
            Sigma(:,:,ii) = Sigma_num/sum(Pk_x(ii,:));
        end
        if params.cov_type == "diag"
            Sigma =  bsxfun(@times, Sigma, eye(N));
        end
    case 'iso'
        for ii = 1:K
%             for jj = 1:M
%                 Sigma_num(:,:,ii) = diag(Pk_x(ii,jj) * (X(:,jj)-Mu(:,ii)).^2) ...
%                     + Sigma_num(:,:,ii);
%             end
%             Sigma(:,:,ii) = Sigma_num(:,:,ii) / (N * M * Priors(ii));
            Sigma_num = sum(Pk_x(ii,:).*(distance_to_centroids(X, Mu(:,ii), 'L2').^2));
            Sigma(:,:,ii) = (Sigma_num/(N*sum(Pk_x(ii,:)))) * eye(N); 
        end
end

end

