currentfile = pwd;
generatedDataFolder = 'best5percent';
files = getFolderContent(fullfile(pwd, generatedDataFolder));

date = datestr(now, 'dd-mm-yyyy_HH-MM');
foldername = 'barplots';
savepath = fullfile(pwd, foldername, date);
if ~exist(savepath, 'dir')
    mkdir(savepath);
end

t1 = tiledlayout(4,2);
% 
% 
% t4 = tiledlayout(4,2);

for i = 1:length(files)
    load(files(i));

    numpTab0 = tabulate(bests.NumberOfParticles);
    pntTab0 = tabulate(bests.ProcNoiseTum);
    pndTab0 = tabulate(bests.ProcNoiseDrug);
    mnTab0 = tabulate(bests.MeasurNoise);

    numpTab = NonZero(numpTab0);
    pntTab = NonZero(pntTab0);
    pndTab = NonZero(pndTab0);
    mnTab = NonZero(mnTab0);


    nexttile;
    xx = categorical(numpTab(:, 1));
    bar(xx ,numpTab(:, 3));
    tit = sprintf('%d: Particle numbers frequency', i);
    title(tit);
    xlabel('Parameter values')
    ylabel({'Value';'frequency [%]'})

end
    exportgraphics(t1, fullfile(savepath, 'numParticle.png'), 'Resolution', 500);


t2 = tiledlayout(4,2);
for i = 1:length(files)
    load(files(i));

    numpTab0 = tabulate(bests.NumberOfParticles);
    pntTab0 = tabulate(bests.ProcNoiseTum);
    pndTab0 = tabulate(bests.ProcNoiseDrug);
    mnTab0 = tabulate(bests.MeasurNoise);

    numpTab = NonZero(numpTab0);
    pntTab = NonZero(pntTab0);
    pndTab = NonZero(pndTab0);
    mnTab = NonZero(mnTab0);

    nexttile;
    xx = categorical(pntTab(:, 1));
    bar(xx,pntTab(:, 3));
    tit = sprintf('%d: Process noise Tumour frequency', i);
    title(tit);
    xlabel('Parameter values')
    ylabel({'Value';'frequency [%]'})


end
    exportgraphics(t2, fullfile(savepath, 'procNoiseT.png'), 'Resolution', 500);

t3 = tiledlayout(4,2);
for i = 1:length(files)
    load(files(i));

    numpTab0 = tabulate(bests.NumberOfParticles);
    pntTab0 = tabulate(bests.ProcNoiseTum);
    pndTab0 = tabulate(bests.ProcNoiseDrug);
    mnTab0 = tabulate(bests.MeasurNoise);

    numpTab = NonZero(numpTab0);
    pntTab = NonZero(pntTab0);
    pndTab = NonZero(pndTab0);
    mnTab = NonZero(mnTab0);

    nexttile;
    xx = categorical(pndTab(:, 1));
    bar(xx,pndTab(:, 3));
    tit = sprintf('%d: Process noise Drug frequency', i);
    title(tit);
    xlabel('Parameter values')
    ylabel({'Value';'frequency [%]'})


end
    exportgraphics(t3, fullfile(savepath, 'procNoiseD.png'), 'Resolution', 500);


t4 = tiledlayout(4,2);
t4.TileSpacing 
for i = 1:length(files)
    load(files(i));

    numpTab0 = tabulate(bests.NumberOfParticles);
    pntTab0 = tabulate(bests.ProcNoiseTum);
    pndTab0 = tabulate(bests.ProcNoiseDrug);
    mnTab0 = tabulate(bests.MeasurNoise);

    numpTab = NonZero(numpTab0);
    pntTab = NonZero(pntTab0);
    pndTab = NonZero(pndTab0);
    mnTab = NonZero(mnTab0);


    nexttile;
    xx = categorical(mnTab(:, 1));
    bar(xx,mnTab(:, 3));
    tit = sprintf('%d: Measure noise frequency', i);
    title(tit);
    xlabel('Parameter values')
    ylabel({'Value';'frequency [%]'})


end
    exportgraphics(t4, fullfile(savepath, 'measurNoise.png'), 'Resolution', 500);
 