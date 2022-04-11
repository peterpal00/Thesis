function [tOut, xOut] = ODE_Simulation(parameters, x0, lastDayOfTherapy, everyDayInput)

    %% simulation
    
    fprintf('ode45 simulation \n')
    
    a = parameters.a;
    b = parameters.b;
    c = parameters.c;
    ED50 = parameters.ED50;
    k1 = parameters.k1;
    k2 = parameters.k2;
    n = parameters.n;
    w = parameters.w;
    x10 = parameters.x10;
    bk = parameters.bk;
    
    tOut = 0;
    xOut = zeros(1, 4);
    
    for day=1:1:lastDayOfTherapy
        u_actual = everyDayInput(day);
        %day_actual = day;
    [t,x] = ode45(@(t,x)Func_tum_V4(x,a,b,c,n,k1,k2,bk,ED50,w, u_actual),[day day+1],[x0(1) x0(2) x0(3) x0(4)]);
    
    x0 = x(end,:); % set x0 of next iteration as current x iteration end point
    
    tOut = cat(1, tOut, t); % saving out t values from this iteration
    xOut = cat(1,xOut, x); % saving out x values from this iteration
    
    end

end