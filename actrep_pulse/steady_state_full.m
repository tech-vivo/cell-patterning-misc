
y0 = logspace(-4,4,100);
       
nz = 20;
nx = 20;                
nkx = 4;
nkz = 4;
for ky = logspace(-3,-0.001,4);
    figure('Name',['ky = ' num2str(ky), ' color indicates amount of repressor']);
    cnt = 1;
    for kx = logspace(-3,-0.001,nkx);
        for kz = logspace(-3,-0.001,nkz);
            subplot(nkx,nkz,cnt); hold on;
            for x0 = logspace(-1,2,nx)
                cc = jet(nz);
                ind = 1;
                for z0 = logspace(-1,2,nz)
                    F = 1 + x0 + z0;
                    G = 1 + kx*x0 + z0*kz - ky*y0 - x0*y0;
                    H = ky*y0 + kx*x0*y0;
                    y = (1/2/F)*(-G+sqrt(G.^2+4*F*H));
                    r = (y./y0/ky - 1);
                    r(r>0) = r(r>0)*ky/(1-ky);
                    plot3(log(y0),log(x0)*ones(size(yq)),r,'color',cc(ind,:));
                    ind = ind+1;
                end
            end
            xlabel(['kz = ' num2str(kz)]);
            ylabel(['kx = ' num2str(kx)]);
            zlim([-1 1]);
            view(3);
                    
            cnt = cnt+1;
        end
    end
end

