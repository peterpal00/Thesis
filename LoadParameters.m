function [params, x0, x00] = LoadParameters(mouseID)

%% get the tumour parameters

fprintf('load the parameters \n')

[params.a,params.b,params.c,params.ED50,params.k1,params.k2,params.n,params.w,params.x10] = getParamsMTA2(mouseID);

params.bk = 0;
% a         tumour growth rate
% b         drug effect rate
% c         drug washout rate
% n         tumour necrosis rate
% Kb        Michaelis - Menten const. of drug
% ED50      ED50 of the drug
% w         death cells washout rate
% x10

x0 = [0,       % living tumour vol.
    0,               % dead tuomur vol
    0,              % drug concentration
    0];
x0(1) = params.x10;
x00 = x0;

end