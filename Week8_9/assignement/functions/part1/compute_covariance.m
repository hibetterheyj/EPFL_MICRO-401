function [ Sigma ] = compute_covariance( X, X_bar, type )
%MY_COVARIANCE computes the covariance matrix of X given a covariance type.
%
% Inputs -----------------------------------------------------------------
%       o X     : (N x M), a data set with M samples each being of dimension N.
%                          each column corresponds to a datapoint
%       o X_bar : (N x 1), an Nx1 matrix corresponding to mean of data X
%       o type  : string , type={'full', 'diag', 'iso'} of Covariance matrix
%
% Outputs ----------------------------------------------------------------
%       o Sigma : (N x N), an NxN matrix representing the covariance matrix of the 
%                          Gaussian function
%%

% constant
[N, M] = size(X);

switch type
    case 'full'
        X = X - X_bar;
        Sigma = 1/(M-1) * X * X';
    case 'diag'
        X = X - X_bar;
        Sigma = eye(N) .* (1/(M-1) * X * X');
    case 'iso'
        Sigma_iso = 1/(N*M) * sum(sum((X - X_bar).^2));
        Sigma = eye(N) * Sigma_iso;
end

end

