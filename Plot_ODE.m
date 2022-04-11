function [] = Plot_ODE(tOut, xOut, mouse)
%% plot simu

fprintf('plotting ode45 data \n')

figure();
l = plot(tOut,xOut(:,1));
hold on
d = plot(tOut,xOut(:,2));
dr = plot(tOut,xOut(:,3));
sp = plot(tOut,xOut(:,4));
sum = plot(tOut,xOut(:,1) +  xOut(:,2));
%oriSum = plot(mouse.Day, mouse.Tumour_Volume)
oriSum = scatter(mouse.Day, mouse.Tumour_Volume);
%xlim([0 112])
legend([l,d,dr,sp, sum, oriSum], 'Living tumour', 'Dead tumour', 'Drug conc.','Drug spreading', 'Sum tumour', 'Actual Tumour Vol.');

hold off

end