function [dist] = deck_distance(deck, Mu, type)
%DECK_DISTANCE Calculate the distance between a partially filled deck and
%the centroides
%
%   input -----------------------------------------------------------------
%   
%       o deck : (N x 1) a partially filled deck
%       o Mu : (N x K) Value of the centroids
%       o type : type of distance to use {'L1', 'L2', 'Linf'}
%
%   output ----------------------------------------------------------------
%
%       o dist : K X 1 the distance to the k centroids
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% To be updated!
% N = size(deck, 1); % 642
% K = size(Mu, 2); % 8
% dist = ones(K, 1);

% distance with subset of the centroids
% where the subset corresponds to non-zero cards
idx = find(deck>0);
[dist] =  distance_to_centroids(deck(idx), Mu(idx), type);

end

