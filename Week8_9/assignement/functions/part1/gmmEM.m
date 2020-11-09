function [  Priors, Mu, Sigma, iter ] = gmmEM(X, params)
%MY_GMMEM Computes maximum likelihood estimate of the parameters for the
% given GMM using the EM algorithm and initial parameters
%   input------------------------------------------------------------------
%       o X         : (N x M), a data set with M samples each being of
%                           dimension N, each column corresponds to a datapoint.
%       o params : Structure containing the paramaters of the algorithm:
%           * cov_type: Type of the covariance matric among 'full', 'iso',
%           'diag'
%           * k: Number of gaussians
%           * max_iter: Max number of iterations

%   output ----------------------------------------------------------------
%       o Priors    : (1 x K), the set of FINAL priors (or mixing weights) for each
%                           k-th Gaussian component
%       o Mu        : (N x K), an NxK matrix corresponding to the FINAL centroids
%                           mu = {mu^1,...mu^K}
%       o Sigma     : (N x N x K), an NxNxK matrix corresponding to the
%                   FINAL Covariance matrices  Sigma = {Sigma^1,...,Sigma^K}
%       o iter      : (1 x 1) number of iterations it took to converge
%%

% Initialization
iter = 0;
[Priors, Mu, Sigma, ~] = gmmInit(X, params);
logl = gmmLogLik(X, Priors, Mu, Sigma);
threshold = 5e-4;
% optimization
while true
    % Expectation Step (E-step)
    [Pk_x] = expectation_step(X, Priors, Mu, Sigma, params);
    % Maximization (Update step) Step (M-step)
    [Priors,Mu,Sigma] = maximization_step(X, Pk_x, params);
    % Check convergence
    iter = iter + 1;
    last_logl = logl;
    logl = gmmLogLik(X, Priors, Mu, Sigma);
    if(iter >= params.max_iter || abs(last_logl - logl) <= threshold)
        break;
    end
end

end