function [X, param1, param2] = normalize(data, normalization, param1, param2)
%NORMALIZE Normalize the data wrt to the normalization technique passed in
%parameter. If param1 and param2 are given, use them during the
%normalization step
%
%   input -----------------------------------------------------------------
%
%       o data : (N x M), a dataset of M sample points of N features
%       o normalization : String indicating which normalization technique
%                         to use among minmax, zscore and none
%       o param1 : (optional) first parameter of the normalization to be
%                  used instead of being recalculated if provided
%       o param2 : (optional) second parameter of the normalization to be
%                  used instead of being recalculated if provided
%
%   output ----------------------------------------------------------------
%
%       o X : (N x M), normalized data
%       o param1 : first parameter of the normalization
%       o param2 : second parameter of the normalization

switch nargin
    case 2
        switch normalization
            case "minmax"
                % method1
%                 % data_min
%                 param1 = min(data, [], 2);
%                 % data_max
%                 param2 = max(data, [], 2);
                % method2: using cell array
                data_cell = num2cell(data,2);
                data_min  = cellfun(@min, data_cell, 'UniformOutput', false);
                data_max  = cellfun(@max, data_cell, 'UniformOutput', false);
                data_norm = cellfun(@(DATA, MIN, MAX) (DATA-MIN)/(MAX-MIN), ...
                    data_cell, data_min, data_max, 'UniformOutput', false);
                X = cell2mat(data_norm);
                param1 = cell2mat(data_min);
                param2 = cell2mat(data_max);
            case "zscore"
                % method1
%                 % data_mean
%                 param1 = mean(data, 2);
%                 % data_std
%                 param2  = std(data, 0, 2);
                % method2: using cell array
                data_cell = num2cell(data,2);
                data_mean = cellfun(@mean, data_cell, 'UniformOutput', false);
                data_std  = cellfun(@std, data_cell, 'UniformOutput', false);
                data_norm = cellfun(@(DATA, MEAN, STD) (DATA-MEAN)/STD, ...
                    data_cell, data_mean, data_std, 'UniformOutput', false);
                X = cell2mat(data_norm);
                param1 = cell2mat(data_mean);
                param2 = cell2mat(data_std);
            case "none"
                param1 = 0; param2 = 0;
                X = data;
            otherwise
                disp("Input Error");
        end
    case 3
        switch normalization
            case "minmax"
                data_cell = num2cell(data,2);
                data_min  = num2cell(param1,2);
                % data_min = cellfun(@min, data_cell, 'UniformOutput', false);
                data_max  = cellfun(@max, data_cell, 'UniformOutput', false);
                data_norm = cellfun(@(DATA, MIN, MAX) (DATA-MIN)/(MAX-MIN), ...
                    data_cell, data_min, data_max, 'UniformOutput', false);
                X = cell2mat(data_norm);
                param1 = param1;
                param2 = cell2mat(data_max);
            case "zscore"
                data_cell = num2cell(data,2);
                data_mean = num2cell(param1,2);
                % data_mean = cellfun(@mean, data_cell, 'UniformOutput', false);
                data_std  = cellfun(@std, data_cell, 'UniformOutput', false);
                data_norm = cellfun(@(DATA, MEAN, STD) (DATA-MEAN)/STD, ...
                    data_cell, data_mean, data_std, 'UniformOutput', false);
                X = cell2mat(data_norm);
                param1 = param1;
                param2 = cell2mat(data_std);
            case "none"
                param1 = 0; param2 = 0;
                X = data;
            otherwise
                disp("Input Error");
        end
    case 4
        switch normalization
            case "minmax"
                data_cell = num2cell(data,2);
                data_min  = num2cell(param1,2);
                data_max  = num2cell(param2,2);
                data_norm = cellfun(@(DATA, MIN, MAX) (DATA-MIN)/(MAX-MIN), ...
                    data_cell, data_min, data_max, 'UniformOutput', false);
                X = cell2mat(data_norm);
            case "zscore"
                data_cell = num2cell(data,2);
                data_mean = num2cell(param1,2);
                data_std  = num2cell(param2,2);
                data_norm = cellfun(@(DATA, MEAN, STD) (DATA-MEAN)/STD, ...
                    data_cell, data_mean, data_std, 'UniformOutput', false);
                X = cell2mat(data_norm);
            case "none"
                param1 = 0; param2 = 0;
                X = data;
            otherwise
                disp("Input Error");
        end
    otherwise
        disp("Input Error");
end

end

