function [savePath] = getSavePathResult(baseFolder, folder, mouseID, numParticles, processNoise_Tumour, processNoise_Drug, measurementNoise)
    filename = sprintf('m%dnpf%dpnT%.3gpnD%.3gmn%.3g', mouseID, numParticles,processNoise_Tumour, processNoise_Drug, measurementNoise);
    resultFolder = baseFolder;
    idFolder = sprintf('mouse_%d', mouseID);
    newFolder = fullfile(folder.currentFolder, resultFolder, folder.date, idFolder);
    if ~exist(newFolder, 'dir')
        mkdir(newFolder);
    end
    
    savePath = fullfile(newFolder, filename);
end