% a little example problem from Uri Alon, describing nonlinearity and
% robustness to variation in initial conditions

t = 0:0.01:10;
cc = jet(5);
T = 0.5;
tt = 5;
for n = 0:7
    subplot(2,4,n+1)
    ind = 1;
    if(n>1)
        alpha = (n-1)*(1/T^(n-1) - 1)/tt;
    else
        alpha = -log(T)/tt;
    end
    for x0 = 0.6:0.1:1;
%              [t, y]=ode45(@repdecay_ode,t,x0,[],n,alpha);
%              plot(t,y);
        hold on
        if(n~=1)
            x = x0 * (1+x0^(n-1)*alpha*t/(n-1)).^(-1/(n-1));
        else
            x = x0 * exp(-alpha*t);
        end
        plot(t,x,'Color',cc(ind,:));
        ylim([0 1]);
        ind = ind+1;
    end
end