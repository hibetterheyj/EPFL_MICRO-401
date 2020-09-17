function idxVec = hyj_grp2idx(groupVar)
%{
ref: 
1. https://www.mathworks.com/help/stats/grp2idx.html
2. https://ww2.mathworks.cn/help/matlab/ref/isa.html#
Ҫ�ܹ�Ӧ�Զ������룬Ԫ�����飬��ͨ����
%}
% isscalar(x)
groupNum = numel(groupVar);
uniqueVar = unique(groupVar);
idxVec = ones(groupNum,1);
% find���������õ�����
% find(a<3)
% find(string(species) =='virginica')
if isa(groupVar,'cell')
    for i = 1:numel(uniqueVar)
        idx = find(string(groupVar) == uniqueVar{i});
        idxVec(idx) = idxVec(idx) * i;
    end
else
    for i = 1:numel(uniqueVar)
        idx = find(species == uniqueVar(i));
        idxVec(idx) = idxVec(idx) * i;
    end
end

end