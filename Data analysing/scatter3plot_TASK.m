currentfile = pwd;
generatedDataFolder = 'best5percent';
files = getFolderContent(fullfile(pwd, generatedDataFolder));

date = datestr(now, 'dd-mm-yyyy_HH-MM');
foldername = 'scatter3plots';
savepath = fullfile(pwd, foldername, date);
if ~exist(savepath, 'dir')
    mkdir(savepath);
end    

t1 = tiledlayout(4,2);

    el = -11;
    le = 5.4;
for i = 1:length(files)
    load(files(i));
    names ={'Num. Of Particles','Proc. noise Tum.','RMSE'};
    nexttile;
    tb = table(bests.NumberOfParticles, bests.ProcNoiseTum, bests.Value, 'VariableNames', names);

    sc = scatter3(tb, 'Num. Of Particles','Proc. noise Tum.','RMSE', 'filled', 'ColorVariable', 'RMSE');
    tit = sprintf('Mouse: %d', i);
    title(tit)
    colorbar
    view(el, le)
    
    filename = sprintf('mouse_%d.png', i);
    
end
exportgraphics(gcf, fullfile(savepath, filename), 'Resolution', 500);

