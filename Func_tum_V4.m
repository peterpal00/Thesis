function dxdt = Func_tum_V4(x,a,b,c,n,k1,k2,bk,ED50,w, u_actual)

dxdt = zeros(4,1);


dxdt(1) = (a - n) * x(1) - b*((x(1) * x(3))/(ED50 + x(3)));                 % time func. of tumour vol.
dxdt(2) = n * x(1) + b*((x(1) * x(3))/(ED50 + x(3))) - w * x(2);             % time func. of the dead part of the tumour volume
dxdt(3) = -(c + k1) * x(3) + k2 * x(4) - bk * ((x(1)*x(2)))/(ED50 + x(3)) + u_actual;                % time func. of the drug level
dxdt(4) = k1 * x(3) - k2 * x(4);

end
