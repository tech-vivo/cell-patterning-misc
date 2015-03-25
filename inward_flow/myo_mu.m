% Will McFadden (wmcfadden)
function [ F ] = myo_mu(q, xdata )
    F = q(1)*xdata.^q(3)./(q(2)^q(3) + xdata.^q(3));
end