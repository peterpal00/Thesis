function [savePath] = getSavePath(folder, mouseID, numParticles, ProcessNoise, MeasurementNoise)
    filename = sprintf('m%dnpf%dpn%.3gmn%.3g', mouseID, numParticles,ProcessNoise, MeasurementNoise);
    resultFolder = 'Results';
    newFolder = fullfile(folder.currentFolder, resultFolder, folder.date);
    if ~exist(newFolder, 'dir')
        mkdir(newFolder);
    end
    
    savePath = fullfile(newFolder, filename);
end