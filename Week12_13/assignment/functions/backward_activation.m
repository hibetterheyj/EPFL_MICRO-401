function [dZ] = backward_activation(Z, Sigma)
%BACKWARD_ACTIVATION Compute the derivative of the activation function
%evaluated in Z
%   inputs:
%       o Z (NxM) Z value, input of the activation function. The size N
%       depends of the number of neurons at the considered layer but is
%       irrelevant here.
%       o Sigma (string) type of the activation to use
%   outputs:
%       o dZ (NXM) derivative of the activation function

% init
[N, M] = size(Z);
% activation
switch Sigma
    case "sigmoid"
        sigma = ones(N, M) ./ (1 + exp(-Z));
        dZ = sigma.*(1-sigma);
    case "tanh"
        tanh = (exp(Z) - exp(-Z)) ./ (exp(Z) + exp(-Z));
        dZ = 1 - tanh.^2;
    case "relu"
        dZ = ones(N,M);
        dZ(Z<0) = 0;
    case "leakyrelu"
        dZ = ones(N,M);
        dZ(Z<0) = 0.01;
end

end