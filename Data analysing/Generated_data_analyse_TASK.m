clear;
currentfile = pwd;
generatedDataFolder = 'Generated_data';
mouseFolders = getFolderContent(fullfile(pwd, generatedDataFolder));
date = datestr(now, 'dd-mm-yyyy_HH-MM');
foldername = 'AnalysedData';

for i = 1:length(mouseFolders)
    files = getFolderContent(mouseFolders(i));
    files_length = length(files);
    tic
    for j = 1:files_length %parfor
        [rmse_TumourVolume_PFvMEASUR, values] = AnalayseData(files(j));
        z.fitValues(j) = rmse_TumourVolume_PFvMEASUR;
        z.numParticles(j) = values.numParticles;
        z.processNoise_Drug(j) = values.processNoise_Drug;
        z.processNoise_Tumour(j) = values.processNoise_Tumour;
        z.measurementNoise(j) = values.measurementNoise;
        %fprintf("hello")
    end
    toc
    [best_results, best_values, zz] = BestXPercentResults(files, z.fitValues, 5, z);
    zz.best_results = best_results;
    zz.best_results = best_values;
    names ={'filename','Value','NumberOfParticles','ProcNoiseTum','ProcNoiseDrug','MeasurNoise'};
    bests = table(best_results, best_values', zz.numParticles', zz.processNoise_Tumour', zz.processNoise_Drug', zz.measurementNoise', 'VariableNames', names);
    mousefolder = sprintf('mouse_%d', i);
    savepath = fullfile(pwd, foldername, date, mousefolder);
    if ~exist(savepath, 'dir')
        mkdir(savepath);
    end

    save(fullfile(savepath, 'var.mat'), 'bests');
    MakeFreqTable(zz.numParticles, zz.processNoise_Tumour, zz.processNoise_Drug, zz.measurementNoise);
    exportgraphics(gcf, fullfile(savepath, 'graph.png'), 'Resolution', 500);

end
fprintf("TASK ENDED");
