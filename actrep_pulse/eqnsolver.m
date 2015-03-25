syms x y x0 y0 kx ky

eq1 = sym('x*(1+y)-x0*(kx+y)');
eq2 = sym('y*(1+x)-y0*(ky+x)');

sol1 = solve(eq1,eq2,x,y);

syms x1 y1 x2 y2


eq3 = sym('y1*(1+x1)*(1+x2)-y1*(ky+x1)*(ky+x2)-y0*(ky+x1)*(1+ky)');
eq4 = sym('y2*(1+x1)*(1+x2)-y2*(ky+x1)*(ky+x2)-y0*(ky+x2)*(1+ky)');
eq5 = sym('x1*(1+y1)*(1+y2)-x1*(kx+y1)*(kx+y2)-x0*(kx+y1)*(1+kx)');
eq6 = sym('x2*(1+y1)*(1+y2)-x2*(kx+y1)*(kx+y2)-x0*(kx+y2)*(1+kx)');

sol2 = solve(eq3,eq4,eq5,eq6,x1,x2,y1,y2);


syms z z0 kz n

eq7 = sym('x*(1+n*y)-x0*(kx+n*y)');
eq8 = sym('y*(1+x+z)-y0*(ky+x)');
eq9 = sym('z*(1+y)-z0*(kz+y)');

sol3 = solve(eq7,eq8,eq9,x,y,z);

