function [y_est, var_est] = gmr(Priors, Mu, Sigma, X, in, out)
%GMR This function performs Gaussian Mixture Regression (GMR), using the 
% parameters of a Gaussian Mixture Model (GMM) for a D-dimensional dataset,
% for D= N+P, where N is the dimensionality of the inputs and P the 
% dimensionality of the outputs.
%
% Inputs -----------------------------------------------------------------
%   o Priors:  1 x K array representing the prior probabilities of the K GMM 
%              components.
%   o Mu:      D x K array representing the centers of the K GMM components.
%   o Sigma:   D x D x K array representing the covariance matrices of the 
%              K GMM components.
%   o X:       N x M array representing M datapoints of N dimensions.
%   o in:      1 x N array representing the dimensions of the GMM parameters
%                to consider as inputs.
%   o out:     1 x P array representing the dimensions of the GMM parameters
%                to consider as outputs. 
% Outputs ----------------------------------------------------------------
%   o y_est:     P x M array representing the retrieved M datapoints of 
%                P dimensions, i.e. expected means.
%   o var_est:   P x P x M array representing the M expected covariance 
%                matrices retrieved. 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% init
P = numel(out);
[D, K] = size(Mu);
[N, M] = size(X);
y_est = zeros(P, M);
var_est = zeros(P, P, M);
% Compute the Expectation and Variance of the Conditional
io = [in, out];
for ii = 1:D
    Mu_new(ii,:) = Mu(io(ii),:);
    for jj= 1:D
        Sigma_new(ii,jj,:) = Sigma(io(ii),io(jj),:);     
    end
end   
% Compute beta
beta_nom = zeros(K,M); % Nominator of mixing weight
for jj = 1:K
    beta_nom(jj,:) = Priors(jj)*gaussPDF(X, Mu_new(1:N,jj), Sigma_new(1:N,1:N,jj));    
end
beta = beta_nom./sum(beta_nom);
% Local regressive function => computing the expectation over the conditional density
Mu_reg = zeros(P,M,K);
for jj = 1:K
    Mu_reg(:,:,jj) = repmat(Mu_new(N+1:end,jj),1,M) + Sigma_new(N+1:end,1:N,jj) ...
                            *pinv(Sigma_new(1:N,1:N,jj)) * (X-Mu_new(1:N,jj));
    y_est  = y_est + repmat(beta(jj,:),P,1) .* Mu_reg(:,:,jj);
end

% Conditional Density for each regressive function
Sigma_reg = zeros(P,P,K);
for jj = 1:K
    Sigma_reg(:,:,jj) =  Sigma_new(N+1:end,N+1:end,jj) - Sigma_new(N+1:end,1:N,jj)...
        /(Sigma_new(1:N,1:N,jj))*Sigma_new(1:N,N+1:end,jj);
end
% Caluclate Sum
for m = 1:M
    var_est_sum = zeros(P); % Last term has to be summed up before it's squared
    for jj = 1:K
        var_est(:,:,m) = var_est(:,:,m) + beta(jj,m)*(Mu_reg(:,m,jj)*Mu_reg(:,m,jj)' +Sigma_reg(:,:,jj));
        var_est_sum = var_est_sum + beta(jj,m)*Mu_reg(:,m,jj);        
    end
    var_est(:,:,m) = var_est(:,:,m) - var_est_sum * var_est_sum';
end

end