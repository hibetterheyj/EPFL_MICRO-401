function [X, unique_cards] = prepare_data(data)
%PREPARE_DATA Convert the list of cards and deck to a matrix representation
%             where each row is a unique card and each column a deck. The
%             value in each cell is the number of time the card appears in
%             the deck
%
%   input -----------------------------------------------------------------
%   
%       o data   : (60, M) a dataset of M decks. A deck contains 60 non
%       necesserally unique cards
%
%   output ----------------------------------------------------------------
%
%       o X  : (N x M) matrix representation of the frequency of appearance
%       of unique cards in the decks whit N the number of unique cards in
%       the dataset and M the number of decks
%       o unique_cards : {N x 1} the set of unique card names as a cell
%       array
%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% init
unique_cards = unique(data); 
M = size(data,2); % number of decks
N = numel(unique_cards); % number of different cards
X = zeros(N, M); % matrix representation of the frequency of cards

for ii = 1:M
    currdeck = data(:,ii);
    freMap = tabulate(currdeck);
    for jj = 1:size(freMap, 1)
        idx = ismember(unique_cards,freMap{jj,1})==1;
        X(idx, ii) = freMap{jj,2};
    end
end

end

