function [d] =  distance_to_centroids(X, Mu, type)
%MY_DISTX2Mu Computes the distance between X and Mu.
%
%   input -----------------------------------------------------------------
%
%       o X     : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o Mu    : (N x k), an Nxk matrix where the k-th column corresponds
%                          to the k-th centroid mu_k \in R^N
%       o type  : (string), type of distance {'L1','L2','LInf'}
%
%   output ----------------------------------------------------------------
%
%       o d      : (k x M), distances between X and Mu
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[~, M] = size(X);
[~, k] = size(Mu);
d = zeros(k, M);
switch type
    case 'L1'
        p = 'L1';
    case 'L2'
        p = 'L2';
    case 'LInf'
        p = 'LInf';
end
for jj = 1:M
    data = X(:,jj);
    for ii = 1:k
        currCenter = Mu(:,ii);
        currDis = compute_distance(data, currCenter, p);
        d(ii,jj) = currDis;
    end
end

end