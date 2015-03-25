num = 10;                              
cc = copper(num+1);                    
plot_ind = 1;                          
for k = logspace(0.1,1,6)
    f = (1/k):0.01:2;
    
    y = (log(f)+log(k))/log(k);        % special solution for n=1 (p=0)
    
    subplot(2,3,plot_ind)              
    plot(f,y, 'Color',cc(1,:));        
    hold on                            
    color_ind = 2;                     
    for p = linspace(0.5,(num+1)/2,num)
        x = (k^p - f.^-p)/(k^p - 1);   % general solution for n > 1 (i.e. p > 0)
        plot(f,x, 'Color',cc(plot_ind,:)); 
        ylim([0 2]);                   
        color_ind = color_ind+1;       
    end
    plot_ind = plot_ind+1;
end
