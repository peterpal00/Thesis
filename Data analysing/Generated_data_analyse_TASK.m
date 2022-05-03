currentfile = pwd;
generatedDataFolder = 'Generated_data_TEST';
mouseFolders = getFolderContent(fullfile(pwd, generatedDataFolder));

for i = 1:length(mouseFolders)
    files = getFolderContent(mouseFolders(i));
    files_length = length(files);
    
    parfor j = 1:files_length %parfor
        [rmse_TumourVolume_MODELvMEASUR(j), rmse_TumourVolume_PFvMODEL(j), rmse_TumourVolume_PFvMEASUR(j), rmse_TumourVolumeAilve_PFvMODEL(j), rmse_DrugConcTumour_PFvMODEL(j), rmse_DrugConcPeriferal_PFvMODEL(j)] = AnalayseData(files(j));
        z(j) = mean([rmse_TumourVolume_PFvMODEL(j) rmse_DrugConcTumour_PFvMODEL(j), rmse_DrugConcPeriferal_PFvMODEL(j)]);
    end
    [best_results, best_values] = BestXPercentResults(files, z, 5);
end
