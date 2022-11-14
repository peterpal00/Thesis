currentfile = pwd;
generatedDataFolder = 'best5percent';
files = getFolderContent(fullfile(pwd, generatedDataFolder));

date = datestr(now, 'dd-mm-yyyy_HH-MM');
foldername = 'BestResults';
savepath = fullfile(pwd, foldername, date);
if ~exist(savepath, 'dir')
    mkdir(savepath);
end

t1 = tiledlayout(4, 2);

for i = 1:length(files)

    load(files(i));
    hey = bests{1,1};
    load(hey)

    txt2 = sprintf('pfNum: %d', numParticles);
    txt3 = sprintf('pnT: %.3g', processNoise_Tumour);
    txt4 = sprintf('pnD: %.3g', processNoise_Drug);
    txt5 = sprintf('mn: %.3g', measurementNoise);
    txt6 = sprintf('RMSE: %.3g', bests{1,2});


    nexttile
    pf = plot(mouse.Day, estimatedState(:,1) + estimatedState(:,2));
    tit = sprintf('Mouse: %d', i);
    title(tit)
    xlabel('Experiment days') 
    ylabel('Tumour volume')
    hold on
    sum = plot(tOut,xOut(:,1) +  xOut(:,2));
    oriSum = scatter(mouse.Day, mouse.Tumour_Volume);
%     yyaxis right
%     ylabel({txt2, txt3, txt4, txt5, txt6},'Rotation',0);
%     set(gca, 'YTick', []);
   


    
    

end

leg = legend([pf, sum, oriSum], 'Partice Filter', 'ODE45 model', 'Actual Tumour Volume');
leg.Layout.Tile = 'North';

exportgraphics(t1, fullfile(savepath, 'graph.png'), 'Resolution', 500);