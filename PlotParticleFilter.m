function PlotParticleFilter(estimatedState, mouse, tOut, xOut, mouseID, numParticles, processNoise_Tumour, processNoise_Drug, MeasurementNoise, ResamplingPolicy, folder)
    %% plotting particled states
    
fprintf('\n plotting PF \n')

figure();

txt1 = sprintf('Mouse ID: %d', mouseID);
txt2 = sprintf('Number of Particles: %d', numParticles);
txt3 = sprintf('Process noise_Tumour: %.3g', processNoise_Tumour);
txt4 = sprintf('Process noise_Drug: %.3g', processNoise_Drug);
txt5 = sprintf('Measurement noise: %.3g', MeasurementNoise);
%txt6 = sprintf('Mouse ID: %f', config.mouseID);
txt = {txt1, txt2, txt3, txt4, txt5};


dim = [0.15 0.6 0.3 0.3];
str = {'Straight Line Plot','from 1 to 10'};
annotation('textbox',dim,'String',txt,'FitBoxToText','on', 'FontSize', 7);



% pf = plot(mouse.Day(2:end), estimatedState(:,1) + estimatedState(:,2)); % miert a masodiktol plottol?
pf = plot(mouse.Day, estimatedState(:,1) + estimatedState(:,2));
hold on
sum = plot(tOut,xOut(:,1) +  xOut(:,2));
oriSum = scatter(mouse.Day, mouse.Tumour_Volume);
%chem = plot(tOut, )
legend([pf, sum, oriSum], 'ParticeFilter', 'Sum tumour', 'Actual Tumour Vol.');
figur = gcf;


% filename = sprintf('m%dnpf%dpn%.3gmn%.3g.png', mouseID, numParticles,ProcessNoise, MeasurementNoise);
% resultFolder = 'Analysed_datas';
% newFolder = fullfile(folder.currentFolder, resultFolder, folder.date);
% if ~exist(newFolder, 'dir')
%     mkdir(newFolder);
% end
% 
% savePath = fullfile(newFolder, filename);
% exportgraphics(figur, savePath, 'Resolution', 300);

hold off

end

