function dv = reac_dif_fun(t,r,Nx,Ny,Da,Dp,kon_a,koff_a,kon_p,koff_p,koff_ap,koff_pa,alpha,beta,a0,p0,v0,tvon,tvoff)
%%% variables
t
a=r(1:Nx*Ny);
p=r(Nx*Ny+1:2*Nx*Ny);
vx = heaviside(t-tvon)*(1-heaviside(t-tvoff))*v0(1:Nx*Ny);
vy = heaviside(t-tvon)*(1-heaviside(t-tvoff))*v0(Nx*Ny+1:2*Nx*Ny);

a=reshape(a,Nx,Ny);   % tranform the vector into N*N matrix
p=reshape(p,Nx,Ny);   % tranform the vector into N*N matrix
vx=reshape(vx,Nx,Ny);
vy=reshape(vy,Nx,Ny);

at = a0 - mean(mean(a));
pt = p0 - mean(mean(p));

for i=0:(Nx-1)
  for j=0:(Ny-1)
    da(i+1,j+1)=-4*Da*a(i+1,j+1)+Da*a(mod(i-1,Nx)+1,j+1)+Da*a(mod(i+1,Nx)+1,j+1)+Da*a(i+1,mod(j-1,Ny)+1)+Da*a(i+1,mod(j+1,Ny)+1) ...
        + a(i+1,j+1)*(vx(mod(i-1,Nx)+1,j+1)-vx(mod(i+1,Nx)+1,j+1) + vy(i+1,mod(j-1,Ny)+1)-vy(i+1,mod(j+1,Ny)+1))  ...
        + vx(i+1,j+1)*(a(mod(i-1,Nx)+1,j+1)-a(mod(i+1,Nx)+1,j+1)) + vy(i+1,j+1)*(a(i+1,mod(j-1,Ny)+1)-a(i+1,mod(j+1,Ny)+1)) ...
        + at*kon_a - (koff_a+koff_ap*p(i+1,j+1)^alpha)*a(i+1,j+1);
    dp(i+1,j+1)=-4*Dp*p(i+1,j+1)+Dp*p(mod(i-1,Nx)+1,j+1)+Dp*p(mod(i+1,Nx)+1,j+1)+Dp*p(i+1,mod(j-1,Ny)+1)+Dp*p(i+1,mod(j+1,Ny)+1) ...
        + p(i+1,j+1)*(vx(mod(i-1,Nx)+1,j+1)-vx(mod(i+1,Nx)+1,j+1) + vy(i+1,mod(j-1,Ny)+1)-vy(i+1,mod(j+1,Ny)+1))  ...
        + vx(i+1,j+1)*(p(mod(i-1,Nx)+1,j+1)-p(mod(i+1,Nx)+1,j+1)) + vy(i+1,j+1)*(p(i+1,mod(j-1,Ny)+1)-p(i+1,mod(j+1,Ny)+1)) ...
        + pt*kon_p - (koff_p+koff_pa*a(i+1,j+1)^beta)*p(i+1,j+1);
  end
end

da=reshape(da,Nx*Ny,1); 
dp=reshape(dp,Nx*Ny,1); 

dv=[da; dp];