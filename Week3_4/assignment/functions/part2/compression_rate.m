function [cr, compressedSize] = compression_rate(img,cimg,ApList,muList)
%COMPRESSION_RATE Calculate the compression rate based on the original
%image and all the necessary components to reconstruct the compressed image
%
%   input -----------------------------------------------------------------
%       o img : The original image   
%       o cimg : The compressed image
%       o ApList : List of projection matrices for each independent
%       channels
%       o muList : List of mean vectors for each independent channels
%
%   output ----------------------------------------------------------------
%
%       o cr : The compression rate
%       o compressedSize : The size of the compressed elements

%% compression rate
% num
s_Y = numel(cimg) * 64;
s_Ap = numel(ApList) * 64;
s_mu = numel(muList) * 64;
% den
s_img = numel(img) * 64;
cr = 1 - (s_Y+s_Ap+s_mu) / s_img;
%% Overall compressed size
compressedSize = s_Y + s_Ap + s_mu;
% convert the size to megabits
compressedSize = compressedSize / 1048576; 

end

