function [] = plot_digits_more(data, RC)
% plot_digits_more(XHat, 10)
figure                                          
colormap(gray)                                 
for i = 1:RC^2                            
    subplot(RC,RC,i)                             
    digit = reshape(data(:,i), [28,28])';    
    imagesc(digit)                
end
end

