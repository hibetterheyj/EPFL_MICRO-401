function [dZ, dW, dW0] = backward_pass(dE, W, A, Z, Sigmas)
%BACKWARD_PASS This function calculate the backward pass of the network with
%   inputs:
%       o dE (PxM) The derivative dE/dZL
%       o W {Lx1} cell array containing the weight matrices for all the layers 
%       o b {Lx1} cell array containing the bias matrices for all the layers
%       o A {L+1x1} cell array containing the results of the activation functions
%       at each layer. Also contain the input layer A0
%       o Z {Lx1} cell array containing the Z values at each layer
%       o Sigmas {Lx1} cell array containing the type of the activation
%       functions for all the layers
%
%   outputs:
%       o dZ {Lx1} cell array containing the derivatives dE/dZl values at each layer
%       o dW {Lx1} cell array containing the derivatives of the weights at
%       each layer
%       o dW0 {Lx1} cell array containing the derivatives of the bias at each layer

% init
M = size(dE,2);
L = numel(Sigmas);
dZ = cell(L,1);
dW = cell(L,1);
dW0 = cell(L,1);
% calculation
% dE_dZL the derivative of the cost function
dZ{L} = dE;
% dAL_dZL
for ii = L:-1:1
    if ii == L
        dZ{ii} = dE;
    else
        % dAl_dZl
        dAl_dZl{ii} = backward_activation(Z{ii}, Sigmas{ii});
        % dZ dE_dZl
        dZ{ii} = W{ii+1}' * dZ{ii+1} .* dAl_dZl{ii};
    end
    % dW0 dE_dW0l
    dW0{ii} = sum(dZ{ii}, 2) / M;
    % dW dE_dWl
    %disp(size(dZ{ii}));disp(size(A{ii}));
    dW{ii} = dZ{ii} * A{ii}' / M; % A with (L+1) elements, $A^{l-1}$ = A{l}
end

end