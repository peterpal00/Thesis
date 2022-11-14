currentfile = pwd;
date = datestr(now, 'dd-mm-yyyy_HH-MM');

generatedDataFolder = 'combinationsForFixed';
files = getFolderContent(fullfile(pwd, generatedDataFolder));



for i = 1:length(files)
    load(files(i));
    t1 = tiledlayout(2, 2);
    mouse = sprintf('Mouse %d', i);
    %mouse = 'Mouse 1'
    title(t1, mouse);
    
    nexttile;
    sorted_measurementNoise = sortrows(fixed_measurementNoise, 'mn');
    best_measurementNoise = fixed_measurementNoise.mn(1);
    s = scatter(sorted_measurementNoise.mn, sorted_measurementNoise.rmsE);
    title('mn vs. RMSE');
    ylabel('RMSE');
    xlabel('mn parameter');
    s.Marker = 'x';
    s.LineWidth = 1;
    
    nexttile;
    sorted_numParticles = sortrows(fixed_numParticles, 'pfNum');
    best_numParticles = fixed_numParticles.pfNum(1);
    s = scatter(sorted_numParticles.pfNum, sorted_numParticles.rmsE);
    title('pfNum vs. RMSE');
    ylabel('RMSE');
    xlabel('pfNum parameter');
    s.Marker = 'x';
    s.LineWidth = 1;
    
    nexttile;
    sorted_processNoise_Tumour = sortrows(fixed_processNoise_Tumour, 'pnT');
    best_processNoise_Tumour = fixed_processNoise_Tumour.pnT(1);
    s = scatter(sorted_processNoise_Tumour.pnT, sorted_processNoise_Tumour.rmsE);
    title('pnT vs. RMSE');
    ylabel('RMSE');
    xlabel('pnT parameter');
    s.Marker = 'x';
    s.LineWidth = 1;
    
    nexttile;
    sorted_processNoise_Drug = sortrows(fixed_processNoise_Drug, 'pnD');
    best_processNoise_Drug = fixed_processNoise_Drug.pnD(1);
    s = scatter(sorted_processNoise_Drug.pnD, sorted_processNoise_Drug.rmsE);
    title('pnD vs. RMSE');
    ylabel('RMSE');
    xlabel('pnD parameter');
    s.Marker = 'x';
    s.LineWidth = 1;

    tosave = 'combinationsForFixed';
    mousename = sprintf('mouseG_%d.png', i);
    savepath = fullfile(pwd, tosave);
    if ~exist(savepath, 'dir')
        mkdir(savepath);
    end
    exportgraphics(t1, fullfile(savepath, mousename), 'Resolution', 500);
end


