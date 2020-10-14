function [Xinversed] = denormalize(X, param1, param2, normalization)
%DENORMALIZE Denormalize the data wrt to the normalization technique passed in
%parameter and param1 and param2 calculated during the normalization step
%normalization step
%
%   input -----------------------------------------------------------------
%
%       o X : (N x M), normalized data of M sample points of N features
%       o normalization : String indicating which normalization technique
%                         to use among minmax, zscore and none
%       o param1 : first parameter of the normalization
%       o param2 : second parameter of the normalization
%
%   output ----------------------------------------------------------------
%
%       o Xinversed : (N x M), the denormalized data

switch normalization
    case "minmax"
        X_cell    = num2cell(X,2);
        data_min  = num2cell(param1,2);
        data_max  = num2cell(param2,2);
        data_inv  = cellfun(@(DATA, MIN, MAX) DATA * (MAX-MIN) + MIN, ...
            X_cell, data_min, data_max, 'UniformOutput', false);
        Xinversed = cell2mat(data_inv);
    case "zscore"
        X_cell    = num2cell(X,2);
        data_mean = num2cell(param1,2);
        data_std  = num2cell(param2,2);
        data_inv  = cellfun(@(DATA, MEAN, STD) DATA * STD + MEAN, ...
            X_cell, data_mean, data_std, 'UniformOutput', false);
        Xinversed = cell2mat(data_inv);
    case "none"
        Xinversed = X;
    otherwise
        disp("Input Error");
end

end

