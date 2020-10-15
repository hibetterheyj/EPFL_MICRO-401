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

% method1: using cellfun
% [~, M] = size(X);
% [~, k] = size(Mu);
% dataCell = num2cell(X,1);
% centerCell = num2cell(Mu,1);
% d = zeros(k, M);
% for i = 1:k
%     currCenter = centerCell{i};
%     switch type
%         case 'L1'
%             p = 1;
%         case 'L2'
%             p = 2;
%         case 'LInf'
%             p = 'inf';
%     end
%     % currDis = cellfun(@(dataCell) norm(dataCell-currCenter, p), dataCell, 'UniformOutput', false);
%     currDis = cellfun(@(dataCell) compute_distance(dataCell, currCenter, p), dataCell, 'UniformOutput', false);
%     d(i,:) = cell2mat(currDis);
% end

% method2: using arrayfun
switch type
    case 'L1'
        d = cell2mat(arrayfun(@(i) sum(abs(Mu(:,i)-X), 1), 1:size(Mu,2), 'UniformOutput', false)');
    case 'L2'
        d = cell2mat(arrayfun(@(i) sqrt(sum((Mu(:,i)-X).^2, 1)), 1:size(Mu,2), 'UniformOutput', false)');
    case "LInf"
        d = cell2mat(arrayfun(@(i) max(abs(Mu(:,i)-X), [], 1), 1:size(Mu,2), 'UniformOutput', false)');
end

end