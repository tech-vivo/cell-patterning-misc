% Will McFadden (wmcfadden)
% 

%%% diffusion parameters
Da = 0;
Dp = 0;
Dr = 0;

%%% steady state parameters (what happens at long times/reduced parameters)
kx = 0.00001;         % equilibrium constant for a alone
ky = 0.1;         % equilibrium constant for p alone
kz = 0.1;         % equilibrium constant for r alone
x0 = 2;         % bulk concentration of activator x 'positive feedback' rate of substrate on activator
y0 = 0.1;         % bulk concentration of substrate x 'repression' rate of repressor on substrate
z0 = 0;         % bulk concentration of repressor x 'positive feedback' rate of substrate on repressor
n_zx = 25;         % ratio of activation rate of activator to repression rate of repressor

%%% intermediate parameters (defining the overall speeds of the reactions)
s_x = 1;
s_y = 0.05;
s_z = 1;
s_xz = 1;
s_yz = 1;
s_xy = 1;

%%% fundamental equilibrium reaction parameters
kon_a = s_x*kx;
koff_a = s_x - kon_a;
kon_p = s_y*ky;
koff_p = s_y - kon_p;
kon_r = s_z*kz;
koff_r = s_z - kon_r;

%%% utility parameters for computational ease
yf = y0*(kon_r + koff_r);
zf = z0*(kon_p + koff_p);
xf = x0*(kon_p + koff_p);
nyf = n_zx*y0*(kon_a+koff_a);

%%% fundamental activator-repressor reaction parameters (the rates that
%%% each substance accelerates its part of the reaction)
kon_ap = nyf*(s_xy + s_yz - s_xz)/(nyf+yf);
kon_pa = s_xy - kon_ap;
koff_pr = s_xz - kon_pa;
kon_rp = s_yz - koff_pr;

%%% bulk solution concentrations (
p0 = yf/kon_rp;
a0 = xf/kon_pa;
r0 = zf/koff_pr;

N=50;     % grid size

%%% initial conditions
xini=0*kx*x0*ones(N,N);
zini=kz*z0*ones(N,N);
[xgr ygr] = meshgrid((0:N-1)/(N-1));
yini = y0*(0+0.05*rand(N,N));

%%% change to fundamental concentrations
aini = xini*s_y/kon_pa;
rini = zini*s_y/koff_pr;
pini = yini*s_z/kon_rp;

%%% setup matrix for input into ode45
v=reshape([aini pini rini],1,3*N^2);

%%% time parameters
tstep=1;
tend=100;
showsize = 1;

%%% run simulation
[t v] = ode45(@reac_dif_fun,[0:tstep:tend],v,[],N,Da,Dp,Dr,kon_a,koff_a,kon_p,koff_p,kon_r,koff_r,kon_ap,kon_rp,kon_pa,koff_pr,a0,p0,r0);

%%% output
a=v(:,1:N*N);
p=v(:,N*N+1:2*N*N);
r=v(:,2*N*N+1:end);


mx = max(max(p*kon_rp/(kon_r+koff_r)));
numplots = 4;
for i=1:numplots
subplot(3,numplots,2*numplots+i)

ktime=round((i-1)*(tend/tstep)/numplots+1);
time=(ktime*tstep);

pi=reshape(p(ktime,:),N,N);  
yi = pi*kon_rp/(kon_r+koff_r);
q = (yi/y0/ky - 1);
q(q>0) = q(q>0)*ky/(1-ky);
surf(xgr,ygr,yi,'EdgeColor','none');
zlim([0 0.15]);
caxis([0 0.15]);
view(3)
% title(sprintf('mean = %1.4f max = %1.4f',mean(mean(q)),max(max(q))));

end

% figure;
% numplots = 5;
% for i=1:numplots
% subplot(3,numplots,numplots+i)
% 
% ktime=round((i-1)*(tend/tstep)/numplots+1);
% time=(ktime*tstep);
% 
% ai=reshape(a(ktime,:),N,N);  
% xi = ai*kon_pa/(kon_p+koff_p);
% surf(xgr,ygr,xi,'EdgeColor','none');
% view(3)
% 
% end


