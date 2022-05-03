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
    z;
    five_percent = round(files_length * 0.05);
    lowest_5_percent = mink(z, five_percent);
    best_results_indx = zeros(length(lowest_5_percent), 1);
    for k = 1:length(lowest_5_percent)
        best_results_indx(k) = find(z == lowest_5_percent(k));
    end
    best_results = strings(length(best_results_indx), 1);
    for l = 1:length(best_results_indx)
        best_results(l) = files(best_results_indx(l));
    end
    best_results
end
