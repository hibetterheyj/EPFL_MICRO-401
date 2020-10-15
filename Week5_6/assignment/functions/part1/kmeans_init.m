function [Mu] =  kmeans_init(X, k, init)
%KMEANS_INIT This function computes the initial values of the centroids
%   for k-means algorithm, depending on the chosen method.
%
%   input -----------------------------------------------------------------
%   
%       o X     : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o k     : (double), chosen k clusters
%       o init  : (string), type of initialization {'sample','range'}
%
%   output ----------------------------------------------------------------
%
%       o Mu    : (D x k), an Nxk matrix where the k-th column corresponds
%                          to the k-th centroid mu_k \in R^N                   
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% N: dimensions, M: sample number
[N, M] = size(X);
switch init
    case "sample"
        %{ 
        random sampling: Sample  K  data points from  X  at random.
        %}
        % using `randsample`
        selectIndex = randsample(M, k);
        Mu = X(:,selectIndex);
        % using `datasample` 
        % Mu = datasample(X,k,2);
    case "range"
        %{
        random in a range: Select  K  data points uniformly at random 
        from the range of  X ; i.e. if we have a 2D dataset we select 
        points at random between  [min(X1),min(X2)]¡ú[max(X1),max(X2)]
        %}
        % maxX = max(X,[],2); 
        minX = min(X,[],2); rangeX = range(X,2);
        Mu = minX + rangeX.*rand(N,k);
end

% randsample, datasample, min, max, range




end