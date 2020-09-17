function plot2dsamples(Xsetosa, Xversicolor, Xvirginica, pairs, labels)

for i = 1:6
    idx1 = pairs(i, 1);idx2 = pairs(i, 2);
    subplot(2,3,i);
    plot([Xsetosa(:,idx1) Xversicolor(:,idx1) Xvirginica(:,idx1)],...
         [Xsetosa(:,idx2) Xversicolor(:,idx2) Xvirginica(:,idx2)], '.')
    xlabel(labels{idx1})
    ylabel(labels{idx2})
end

end