function [] = AnalayseData(filename, folder)
    


    %% Load given file

    load(filename);

    %%  RMSE: Tumour Volume | modelled data vs. measurements

%     modelledTumourVolume_partial = MakeShortenedVector(mouse.Day, xOut(:,1) + xOut(:,2), tOut);
%     rmse_TumourVolume_MODELLED = RMSE(mouse.Tumour_Volume, modelledTumourVolume_partial);
    rmse_TumourVolume_MODELvMEASUR = ExecuteFuncOnActualAndLongerVector(@RMSE, mouse.Tumour_Volume, mouse.Day, xOut(:,1) + xOut(:,2), tOut);

    %% RMSE: Tumour Volume | pf vs. modell
    
    PF_timeline = 1:lastDayOfTherapy;
    rmse_TumourVolume_PFvMODEL = ExecuteFuncOnActualAndLongerVector(@RMSE,  estimatedState(:,1) + estimatedState(:,2), mouse.Day, xOut(:,1) + xOut(:,2), tOut);

    %% RMSE: Tumour Volume | pf vs. measurements

    rmse_TumourVolume_PFvMEASUR = ExecuteFuncOnActualAndLongerVector(@RMSE, mouse.Tumour_Volume, mouse.Day, estimatedState(:,1) + estimatedState(:,2), mouse.Day);
    
    %% RMSE: Tumour Volume alive | pf vs. modell

    rmse_TumourVolumeAilve_PFvMODEL = ExecuteFuncOnActualAndLongerVector(@RMSE,  estimatedState(:,1), mouse.Day, xOut(:,1), tOut);

    %% RMSE: Drug Conc in tumour | pf vs. modell 
    %NEM BIZTOS HOGY A BELSO KONCI

    rmse_DrugConcTumour_PFvMODEL = ExecuteFuncOnActualAndLongerVector(@RMSE, estimatedState(:,3), mouse.Day, xOut(:,3), tOut);


    %% RMSE: Drug Conc perfiferal | pf vs. modell
    %NEM BIZTOS HOGY A KULSO KONCI

    rmse_DrugConcPeriferal_PFvMODEL = ExecuteFuncOnActualAndLongerVector(@RMSE, estimatedState(:,4), mouse.Day, xOut(:,4), tOut);
    


    %% Plot

    %PlotParticleFilter(estimatedState, mouse, tOut, xOut, mouseID, numParticles, processNoise, measurementNoise, ResamplingPolicy, folder);
    
    fprintf("hello");

    
end