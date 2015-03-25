% Will McFadden (wmcfadden)
% returns active fluid solution for Dirichlet boundary conditions

function [ F ] = act_flu_fun(q, dat )
    F = [];
    for n = 1:length(dat)
        data = dat{n};
        x = data{1};
        x = x-x(1);
        myo = data{2};
        v0 = data{3};
        vd = data{4};
        k = q(1);
        mu = myo_mu(q(2:end), myo);
        m0 = mean(mu);
        mu = mu-m0;
        d = x(end);
        for i=2:length(x)-1
            s0 = v0*exp(-x(i)/k) + (vd-v0*exp(-d/k))*sinh(x(i)/k)/sinh(d/k);
            intr = trapz(x(i+1:end),cosh((d-x(i+1:end))/k).*mu(i+1:end),1);
            sr = sinh(x(i)/k)*intr/sinh(d/k);
            intl = trapz(x(1:i-1),cosh(x(1:i-1)/k).*mu(1:i-1),1);
            sl = sinh((d-x(i))/k)*intl/sinh(d/k);
            
            F = [F; s0+sr-sl];
        end
        F = F;
    end
end