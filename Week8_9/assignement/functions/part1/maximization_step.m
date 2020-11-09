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
K = params.k;
Sigma = zeros(N, N, K);
% Update priors (1 x K)
Priors = sum(Pk_x, 2)'/M;
% Update mean (N x K)
Mu_den = sum(Pk_x, 2)'; % (1 x K)
Mu_num = zeros(N, K);
for ii = 1:M
    Mu_num = Mu_num + X(:,ii) * Pk_x(:,ii)';
end
Mu = Mu_num ./ Mu_den; % bsxfun(@rdivide, Mu_num, Mu_den)
% Update covariance matrix (N x N x K)
for ii = 1:K
    switch params.cov_type
        case {"full", "diag"}
            Sigma_num = bsxfun(@times, Pk_x(ii,:), bsxfun(@minus, X, Mu(:,ii)))*bsxfun(@minus, X, Mu(:,ii))';
            Sigma(:,:,ii) = Sigma_num/sum(Pk_x(ii,:));
            if params.cov_type == "diag"
                Sigma(:,:,ii) =  eye(N) .* Sigma(:,:,ii);
            end
        case 'iso'
            Sigma_num = sum(Pk_x(ii,:).*(distance_to_centroids(X, Mu(:,ii), 'L2').^2));
            Sigma(:,:,ii) = (Sigma_num/(N*sum(Pk_x(ii,:)))) * eye(N); 
    end
    % Add a tiny variance to avoid this numerical instability
    Sigma(:,:,ii) = Sigma(:,:,ii) + eye(N) * 1e-5;
end

end