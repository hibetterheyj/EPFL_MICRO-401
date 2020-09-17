function [X1, y1, X2, y2] = split_dataset(features, labels, ratio)

dataLen = length(features);
X1Len = ratio * dataLen;

X1 = features(1:X1Len,:);
y1 = labels(1:X1Len,:);

X2 = features(X1Len+1:dataLen,:);
y2 = labels(X1Len+1:dataLen,:);

end

