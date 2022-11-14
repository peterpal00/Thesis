currentfile = pwd;
date = datestr(now, 'dd-mm-yyyy_HH-MM');

generatedDataFolder = 'combinationsForFixed';
files = getFolderContent(fullfile(pwd, generatedDataFolder));

t1 = tiledlayout(4, 2);

for i = 1:length(files)
    load(files(i));
    
    mouse = sprintf('Mouse %d', i);
    %mouse = 'Mouse 1'
    
    
    
    nexttile;
    sorted_numParticles = sortrows(fixed_numParticles, 'pfNum');
    best_numParticles = fixed_numParticles.pfNum(1);
    stairs(sorted_numParticles.pfNum, sorted_numParticles.rmsE);
    title(mouse);
    
    ylabel('RMSE gain');
    xlabel('pfNum parameter');

    tosave = 'rmseGain';
    mousename = sprintf('Mouse %d', i);
    title(mousename);
    savepath = fullfile(pwd, tosave);
    if ~exist(savepath, 'dir')
        mkdir(savepath);
    end
    
end
exportgraphics(t1, fullfile(savepath, 'rmseGain.png'), 'Resolution', 500);

