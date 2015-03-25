%%% diffusion parameters
Da = 0.28;
Dp = 0.15;

%%% fundamental equilibrium reaction parameters
kon_a = 8.6*10^-3;
koff_a = 5.4*10^-3;
kon_p = 4.7*10^-2;
koff_p = 7.3*10^-3;

%%% fundamental activator-repressor reaction parameters (the rates that
%%% each substance accelerates its part of the reaction)
koff_ap = 0.19;
koff_pa = 2;

%%% bulk solution concentrations (
p0 = 1.0;
a0 = 1.56;

alpha = 1;
beta = 2;

Nx=136;     % grid size
Ny=1;
%%% initial conditions
[xgr ygr] = meshgrid(0:Nx-1,0:Ny-1);
xgr = xgr';
ygr = ygr';
%%% concentrations
aini = 1*a0*kon_a/(kon_a+koff_a)*ones(Nx,Ny);
pini = 0*p0*kon_p/(kon_p+koff_p)*ones(Nx,Ny);
vxini = 0.1*(exp(-0.01*(xgr-0.33*mean(xgr)).^2)-exp(-0.01*(xgr-1.66*mean(xgr)).^2));

vyini = zeros(Nx,Ny);

tvoff = 300;
tvon = 100;

%%% setup matrix for input into ode45
r0=reshape([aini pini ],1,2*Nx*Ny);
v0=reshape([vxini vyini ],1,2*Nx*Ny);

%%% time parameters
tstep=0.1;
tend=600;
showsize = 10;

%%% run simulation
[t r] = ode45(@reac_dif_fun,[0:tstep:tend],r0,[],Nx,Ny,Da,Dp,kon_a,koff_a,kon_p,koff_p,koff_ap,koff_pa,alpha,beta,a0,p0,v0,tvon,tvoff);
%%% output
a=r(:,1:Nx*Ny);
p=r(:,Nx*Ny+1:2*Nx*Ny);

mn = min(min([a p]));
mx = max(max([a p]));
numplots = length(t)/showsize;
for i=1:numplots

ktime=round((i-1)*(tend/tstep)/numplots+1);
time=(ktime*tstep);

ai=reshape(a(ktime,:),Nx,Ny); 

aim = mean(ai,2);
pi=reshape(p(ktime,:),Nx,Ny);  
pim = mean(pi,2);
hold off
plot(0:(Nx-1)/2,pim(end/2+1:end),'c','LineWidth',2);
hold on
[ax h1 h2] = plotyy(0:(Nx-1)/2,aim(end/2+1:end),0:(Nx-1)/2,-heaviside(time-tvon)*(1-heaviside(time-tvoff))*mean(vxini(end/2+1:end,:),2));
set(h1,'LineWidth',2);
set(h1,'color','r');
set(h2,'color','k');
set(h2,'LineStyle','--');
set(ax(1),'XColor','k','YColor','k','YLim',[mn mx],'YTick',[])
set(ax(2),'XColor','k','YColor','k','YLim',[0 0.2],'YTick',[])

drawnow;
mov(:,i) = getframe;
% surf(xgr,ygr,ai,'EdgeColor','none');
% zlim([mn mx]);
% caxis([mn mx]);
% view(3)
% title(sprintf('mean = %1.4f max = %1.4f',mean(mean(q)),max(max(q))));

end
movie2avi(mov,'mymovie.avi');
