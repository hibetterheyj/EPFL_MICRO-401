function [W, W0] = initialize_weights(LayerSizes, type)
%INITIALIZE_WEIGHTS Initialize the wieghts of the network according to the
%desired type of initialization
%   inputs:
%       o LayerSizes{L+1x1} Cell array containing the sizes of each layers.
%       Also contains the size of A0 input layer
%       o type (string) type of the desired initialization ('random' or 'zeros')
%
%   outputs:
%       o W {Lx1} cell array containing the weight matrices for all the layers 
%       o W0 {Lx1} cell array containing the bias matrices for all the layers

% Useful function randn, zeros and cell & {} for cell arrays

L = numel(LayerSizes)-1;
W = cell(L,1);   % weights S^l ¡Á S^{l?1}
W0 = cell(L,1); % bias    S^l ¡Á 1

switch type
    case "random" 
        for ii = 1:L
            W{ii} = randn(LayerSizes{ii+1}, LayerSizes{ii});
            W0{ii} = randn(LayerSizes{ii+1}, 1);
        end
    case "zeros"
        for ii = 1:L
            W{ii} = zeros(LayerSizes{ii+1}, LayerSizes{ii});
            W0{ii} = zeros(LayerSizes{ii+1}, 1);
        end
end

end

