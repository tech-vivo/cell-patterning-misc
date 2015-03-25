num = 500;
dt = 0.1;
rmax = 30;
num1 = 1000;
L = 4;
D = 1;
x = randn(num,1)*rmax/5;
y = randn(num,1)*rmax/5;
x1 = (rand(num1,1)-0.5)*rmax;
y1 = (rand(num1,1)-0.5)*rmax;
thet0 = rand(num1,1)*pi;
x2 = x1+L*cos(thet0);
y2 = y1+L*sin(thet0);
koff=0;
koff2=0;
nFrames = 50;
mov(1:nFrames) = struct('cdata',[], 'colormap',[]);
ind = 1;
q = [10 0 10 2];
for i = 1:nFrames
    [hx, edx] = histcounts(x,linspace(-rmax,rmax,100));
    edx = (edx(1:end-1)+edx(2:end))/2;
    [hy, edy] = histcounts(y,linspace(-rmax,rmax,100));
    edy = (edy(1:end-1)+edy(2:end))/2;
    tempdat = {edx', hx', 0, 0};
    fitdat = {tempdat};
    verx = [0; act_flu_fun(q, fitdat); 0];
    tempdat = {edy', hy', 0, 0};
    fitdat = {tempdat};
    very = [0; act_flu_fun(q, fitdat); 0];
    u = interp1(edx,verx,x);
    u1 = interp1(edx,verx,x1);
    u2 = interp1(edx,verx,x2);
    v = interp1(edy,very,y);
    v1 = interp1(edy,very,y1);
    v2 = interp1(edy,very,y2);
    u(isnan(u))=0;
    u1(isnan(u1))=0;
    u2(isnan(u2))=0;
    v(isnan(v))=0;
    v1(isnan(v1))=0;
    v2(isnan(v2))=0;
    x = x + (u+D*randn(num,1))*dt;
    x1 = x1 + u1*dt;
    x2 = x2 + u2*dt;
    y = y + (v+D*randn(num,1))*dt;
    y1 = y1 + v1*dt;
    y2 = y2 + v2*dt;
    dis = rand(num,1)<koff*dt;
    y(dis) = (rand(sum(dis),1)-0.5)*rmax;
    x(dis) = (rand(sum(dis),1)-0.5)*rmax;
    dis = rand(num1,1)<koff2*dt;
    x1(dis) = (rand(sum(dis),1)-0.5)*rmax;
    y1(dis) = (rand(sum(dis),1)-0.5)*rmax;
    thet0 = rand(sum(dis),1)*pi;
    x2(dis) = x1(dis)+L*cos(thet0);
    y2(dis) = y1(dis)+L*sin(thet0);
%     subplot(2,1,1);
    plot(x,y,'.','MarkerSize',10)
    hold on
    for j=1:length(x1)
        plot([x1(j) x2(j)],[y1(j),y2(j)],'Color',[0.8 0.8 0.8])
    end
    xlim([-15,15]);
    ylim([-15,15]);
%     subplot(2,1,2);
%     plotyy(edx,hx,edx,verx);
%     xlim([-15,15]);
    drawnow;
    mov(ind)=getframe(gcf);
    ind = ind+1;
    clf;
end