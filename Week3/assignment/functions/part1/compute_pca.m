function [Mu, C, EigenVectors, EigenValues] = compute_pca(X)
%COMPUTE_PCA Step-by-step implementation of Principal Component Analysis
%   In this function, the student should implement the Principal Component
%   Algorithm
%
%   input -----------------------------------------------------------------
%
%       o X      : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%
%   output ----------------------------------------------------------------
%
%       o Mu              : (N x 1), Mean Vector of Dataset
%       o C               : (N x N), Covariance matrix of the dataset
%       o EigenVectors    : (N x N), Eigenvectors of Covariance Matrix.
%       o EigenValues     : (N x 1), Eigenvalues of Covariance Matrix

% 1) Demean the Data
[~, M] = size(X);
Mu = mean(X, 2);
X_demean = X - Mu;

% 2) Covariance Matrix Computation
C = X_demean * X_demean.' / (M-1);

% 3) Eigenvalue Value Decomposition
[V,D] = eig(C);
[~,ind] = sort(diag(D),"descend"); % sort in descending way
EigenVectors = V(:,ind);
EigenValues = diag(D(ind, ind));

end

