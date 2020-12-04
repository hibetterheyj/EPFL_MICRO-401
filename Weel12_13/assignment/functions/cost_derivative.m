function [dZ] = cost_derivative(Y, Yd, typeCost, typeLayer)
%COST_DERIVATIVE compute the derivative of the cost function w.r.t to the Z
%value of the last layer
%   inputs:
%       o Y (PxM) Output of the last layer of the network, should match
%       Yd
%       o Yd (PxM) Ground truth
%       o typeCost (string) type of the cost evaluation function
%       o typeLayer (string) type of the last layer
%   outputs:
%       o dZ (PxM) The derivative dE/dZL

% compute dE_dAL
switch typeCost
    case "LogLoss"
        dE_dAL = - Yd./Y + (1-Yd)./(1-Y);
    case "CrossEntropy"
        dE_dAL = - Yd./Y;
end
dAL_dZL = backward_activation(Y, typeLayer);
dZ = dE_dAL .* dAL_dZL;

end