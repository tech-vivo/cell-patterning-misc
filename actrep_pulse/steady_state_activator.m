
y0 = logspace(-4,4,100);
            
cnt = 1;
for ky = logspace(-5,-0.001,5);
    for kx = logspace(-3,-0.001,5);
        nx = 10;
        cc = jet(nx);
        ind = 1;
        subplot(5,5,cnt);
        hold on
        for x0 = logspace(-3,3,nx)
            U = 1 + x0;
            V = 1 + x0*kx - y0*(x0+ky);
            W = y0*(ky+x0*kx);
            y = (1/2/U)*(-V+sqrt(V.^2+4*U*W));
            r = (y-y0*ky)./(y0*(1-ky));
            plot(log(y0),r,'color',cc(ind,:));
            xlabel(['kx = ' num2str(kx) ' ky = ' num2str(ky)]);
            xlim([min(log(y0)) max(log(y0))]);
            ylim([0 1]);
            ind = ind+1;
        end
        cnt = cnt+1;
    end
end

figure; hold on
y0 = logspace(-4,4,100);
kx = 10^-3;
x0 = 10^2;
cc = jet(nx);
ind = 1;
for ky = logspace(-5,-0.001,nx);

    U = 1 + x0;
    V = 1 + x0*kx - y0*(x0+ky);
    W = y0*(ky+x0*kx);
    y = (1/2/U)*(-V+sqrt(V.^2+4*U*W));
    r = (y-y0*ky)./(y0*(1-ky));
    plot(log(y0),r,'color',cc(ind,:));
    xlabel(['kx = ' num2str(kx) ' ky = ' num2str(ky)]);
    xlim([min(log(y0)) max(log(y0))]);
    ylim([0 1]);
    ind = ind+1;
end




