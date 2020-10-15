function [labels, Mu, Mu_init, iter] =  kmeans(X,K,init,type,MaxIter,plot_iter)
%MY_KMEANS Implementation of the k-means algorithm
%   for clustering.
%
%   input -----------------------------------------------------------------
%
%       o X        : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o K        : (int), chosen K clusters
%       o init     : (string), type of initialization {'sample','range'}
%       o type     : (string), type of distance {'L1','L2','LInf'}
%       o MaxIter  : (int), maximum number of iterations
%       o plot_iter: (bool), boolean to plot iterations or not (only works with 2d)
%
%   output ----------------------------------------------------------------
%
%       o labels   : (1 x M), a vector with predicted labels labels \in {1,..,k}
%                   corresponding to the k-clusters for each points.
%       o Mu       : (N x k), an Nxk matrix where the k-th column corresponds
%                          to the k-th centroid mu_k \in R^N
%       o Mu_init  : (N x k), same as above, corresponds to the centroids used
%                            to initialize the algorithm
%       o iter     : (int), iteration where algorithm stopped
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% TEMPLATE CODE (DO NOT MODIFY)
% Auxiliary Variable
[D, N] = size(X);
d_i    = zeros(K,N);
k_i    = zeros(1,N);
r_i    = zeros(K,N);
if plot_iter == [];plot_iter = 0;end
tolerance = 1e-6;
MaxTolIter = 10;

% Output Variables
Mu     = zeros(D, K);
labels = zeros(1,N);


%% INSERT CODE HERE
% Centroid μk Initialization
[Mu_init] =  kmeans_init(X, K, init);
[d] = distance_to_centroids(X, Mu_init, type);

%% TEMPLATE CODE (DO NOT MODIFY)
% Visualize Initial Centroids if N=2 and plot_iter active
colors     = hsv(K);
if (D==2 && plot_iter)
    options.title       = sprintf('Initial Mu with %s method', init);
    ml_plot_data(X',options); hold on;
    ml_plot_centroids(Mu_init',colors);
end


%% INSERT CODE HERE & bug很大！！！

% init label
% 初步计算每一列最大值所在index即为class值，然后需要assign到对应centroid
% labels = zeros(1,N);
% [~,labels]=max(d);
% 导出responsibility矩阵，根据class生成res矩阵，与d同样大小
resMap = zeros(size(d));
[resMap, labels] = updateLabel(d);
has_converged = false;
tol_iter = 0; iter = 0;
Mu_previous = Mu_init;

while ~has_converged
    iter = iter + 1;
    if iter>=2
        [d] = distance_to_centroids(X, Mu, type);
        [resMap, labels] = updateLabel(d);
    end
    disp("iter-"+num2str(iter)+": ");
    clusterPoints = sum(resMap,2)
    
    for i = 1:K
        idx = find(labels==i);
        num = sum(X(:,idx),2);
        den = clusterPoints(i);
        Mu(:,i) = num/den;
    end
    
    [has_converged, tol_iter] = check_convergence(Mu, Mu_previous, iter, ...
        tol_iter, MaxIter, MaxTolIter, tolerance);
    
    Mu_previous = Mu;
    
end

%% TEMPLATE CODE (DO NOT MODIFY)
if (D==2 && plot_iter)
    options.labels      = labels;
    options.class_names = {};
    options.title       = sprintf('Mu and labels after %d iter', iter);
    ml_plot_data(X',options); hold on;
    ml_plot_centroids(Mu',colors);
end


end

function [resMap, labels] = updateLabel(d)
    checkTie = {};
    for i = 1:size(d,2)
        sampleDis = d(:,i);
        minIndex = (sampleDis==min(sampleDis));
        resMap(:,i)=minIndex;
        if sum(minIndex) > 1
            checkTie{end+1} = i;
        end
    end
    if ~isempty(checkTie)
        %disp("need to modify")
        clusterPoints = sum(resMap,2);
        for i = 1:numel(checkTie)
            col = checkTie{i};
            currSample = resMap(:,col);
            idx = find(currSample==max(currSample));
            resMap(:,col) = (clusterPoints == min(clusterPoints(idx)));
        end
    end
    labels = cell2mat(arrayfun(@(i) find(resMap(:,i)==1), 1:size(resMap,2), ...
        'UniformOutput', false));

end