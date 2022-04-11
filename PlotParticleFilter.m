function PlotParticleFilter(estimatedState, mouse, tOut, xOut, config)
    %% plotting particled states
    
fprintf('\n plotting PF \n')
%     
%     figure();
%     % pf_States = plot(mouse.Day, estimatedState(:,1) + estimatedState(:,2));
%     plot(mouse.Day(2:end), estimatedState(:,2))
%     hold on
%     
%     hold off

figure();

txt1 = sprintf('Mouse ID: %d', config.mouseID);
txt2 = sprintf('Number of Particles: %d', config.numParticles);
txt3 = sprintf('Process noise: %.3g', config.ProcessNoise);
txt4 = sprintf('Measurement noise: %.3g', config.MeasurementNoise);
txt5 = sprintf('Resampling policy: %s', config.ResamplingPolicy);
%txt6 = sprintf('Mouse ID: %f', config.mouseID);
txt = {txt1, txt2, txt3, txt4, txt5};


dim = [0.15 0.6 0.3 0.3];
str = {'Straight Line Plot','from 1 to 10'};
annotation('textbox',dim,'String',txt,'FitBoxToText','on', 'FontSize', 7);



pf = plot(mouse.Day(2:end), estimatedState(:,1) + estimatedState(:,2)); % miert a masodiktol plottol?
hold on
sum = plot(tOut,xOut(:,1) +  xOut(:,2));
oriSum = scatter(mouse.Day, mouse.Tumour_Volume);
chem = plot(tOut, )
legend([pf, sum, oriSum], 'ParticeFilter', 'Sum tumour', 'Actual Tumour Vol.');



hold off

end

