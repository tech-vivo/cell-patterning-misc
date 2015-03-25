function dv = reac_dif_fun(t,v,N,Da,Dp,Dr,kon_a,koff_a,kon_p,koff_p,kon_r,koff_r,kon_ap,kon_rp,kon_pa,koff_pr,a0,p0,r0)
t
%%% variables

a=v(1:N*N);
p=v(N*N+1:2*N*N);
r=v(2*N*N+1:end);

a=reshape(a,N,N);   % tranform the vector into N*N matria
p=reshape(p,N,N);   % tranform the vector into N*N matria
r=reshape(r,N,N);   % tranform the vector into N*N matria

at = a0 - mean(mean(a));
pt = p0 - mean(mean(p));
rt = r0 - mean(mean(r));

for i=0:(N-1)
  for j=0:(N-1)
    da(i+1,j+1)=-4*Da*a(i+1,j+1)+Da*a(mod(i-1,N)+1,j+1)+Da*a(mod(i+1,N)+1,j+1)+Da*a(i+1,mod(j-1,N)+1)+Da*a(i+1,mod(j+1,N)+1)    + at*(kon_a+kon_ap*p(i+1,j+1)) - koff_a*a(i+1,j+1);
    dp(i+1,j+1)=-4*Dp*p(i+1,j+1)+Dp*p(mod(i-1,N)+1,j+1)+Dp*p(mod(i+1,N)+1,j+1)+Dp*p(i+1,mod(j-1,N)+1)+Dp*p(i+1,mod(j+1,N)+1)    + pt*(kon_p+kon_pa*a(i+1,j+1)) - (koff_p+koff_pr*r(i+1,j+1))*p(i+1,j+1);
    dr(i+1,j+1)=-4*Dr*r(i+1,j+1)+Dr*p(mod(i-1,N)+1,j+1)+Dr*r(mod(i+1,N)+1,j+1)+Dr*r(i+1,mod(j-1,N)+1)+Dr*r(i+1,mod(j+1,N)+1)    + rt*(kon_r+kon_rp*p(i+1,j+1)) - koff_r*r(i+1,j+1);
  end
end


da=reshape(da,N*N,1); 
dp=reshape(dp,N*N,1); 
dr=reshape(dr,N*N,1); 

dv=[da; dp; dr];




