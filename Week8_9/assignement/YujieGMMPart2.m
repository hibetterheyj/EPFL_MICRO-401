addpath("./evaluation_functions")
addpath("./plot_functions")
addpath("./utils")
addpath("./functions/part1")
addpath("./functions/part2")

clear;
close all;
clc;

dataset_path = './data';

%% SEED: Remove this is you want to add randomness
seed = rng(42);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%         1) Load 2D GMM Fit Function Testing Dataset        %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
saveFolder = './YujieResult/';

dataset_list = {'1a', '1b'}; % {'1a', '1b', '1c'}
cov_list = {'full', 'diag', 'iso'};
repeats_test = 10; % 10

% dataset_list = {'1a'}; 
% cov_list = {'full'};
% repeats_test = 1;

for ii = 1:length(dataset_list)
    for jj = 1:length(cov_list)
        dataset = dataset_list{ii};
        
        switch dataset
            %% 1a) Load 2d GMM Dataset
            case '1a'
                if exist('X'); clear X; end
                if exist('labels'); clear labels;end
                load(strcat(dataset_path,'/2D-GMM.mat'))
                
                %% 1b) Load 2d Circle Dataset
            case '1b'
                if exist('X'); clear X; end
                if exist('labels'); clear labels;end
                load(strcat(dataset_path,'/2d-concentric-circles.mat'))
                
                %% 1c) Draw Data with ML_toolbox GUI
            case '1c'
                close all; clc;
                if exist('X'); clear X; end
                if exist('labels'); clear labels;end
                [X, labels] = ml_draw_data();
        end
        
        %% K-means Evaluation Parameters
        K_range = 1:10;
        repeats = repeats_test;
        %% Set GMM Hyper-parameters
        params.cov_type = cov_list{jj}; % 'full'
        params.k = 4;
        params.max_iter_init = 100;
        params.max_iter = 500;
        params.d_type = 'L2';
        params.init = 'plus';
        % Evaluate gmm-em to find the optimal k
        [AIC_curve, BIC_curve] = gmm_eval(X, K_range, repeats, params);
        % Plot Metric Curves
        Yujie_plot_curves(AIC_curve,BIC_curve,params,dataset,saveFolder)
        
    end
end
