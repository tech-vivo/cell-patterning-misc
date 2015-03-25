
yq = logspace(-8,8,100);
            
cnt = 1;
for kz = logspace(-6,-2,10);
    nz = 20;
    cc = jet(nz);
    ind = 1;
    subplot(5,2,cnt);
    hold on
    for z0 = logspace(1,5,nz)
        I = 1 + z0;
        J = 1 + z0*kz - yq;
        K = yq;
        y = (1/2/I)*(-J+sqrt(J.^2+4*I*K));
        r = y./yq;
        plot(log(yq),r,'color',cc(ind,:));
        xlabel(['kz = ' num2str(kz)]);
        xlim([min(log(yq)) max(log(yq))]);
        ylim([0 1]);
        ind = ind+1;
    end
    cnt = cnt+1;
end


