currentfile = pwd;
generatedDataFolder = 'Generated_data';
mouseFolders = getFolderContent(fullfile(pwd, generatedDataFolder));
date = datestr(now, 'dd-mm-yyyy_HH-MM');

generatedDataFolder = 'best5percent';
bestfiles = getFolderContent(fullfile(pwd, generatedDataFolder));

for i = 1:length(bestfiles)
    tic
        load(bestfiles(i));
        rmse_BEST = bests{1,2}; % rmse
        iter(1) = bests{1,3}; % numParticles
        iter(2)  = bests{1,4}; % processNoise_Tumour
        iter(3) = bests{1,5}; % processNoise_Drug
        iter(4) = bests{1, 6}; % measurementNoise
    
        files = getFolderContent(mouseFolders(i));
        files_length = length(files);
        tic
        
        rmsE = [];
        pfNum = [];
        pnT = [];
        pnD = [];
        mn = [];
        fixed_numParticles = table(rmse_BEST, iter(1), iter(2), iter(3), iter(4));
        fixed_numParticles.Properties.VariableNames = {'rmsE' 'pfNum' 'pnT' 'pnD' 'mn'};
        fixed_processNoise_Tumour = table(rmse_BEST, iter(1), iter(2), iter(3), iter(4));
        fixed_processNoise_Tumour.Properties.VariableNames = {'rmsE' 'pfNum' 'pnT' 'pnD' 'mn'};
        fixed_processNoise_Drug = table(rmse_BEST, iter(1), iter(2), iter(3), iter(4));
        fixed_processNoise_Drug.Properties.VariableNames = {'rmsE' 'pfNum' 'pnT' 'pnD' 'mn'};
        fixed_measurementNoise = table(rmse_BEST, iter(1), iter(2), iter(3), iter(4));
        fixed_measurementNoise.Properties.VariableNames = {'rmsE' 'pfNum' 'pnT' 'pnD' 'mn'};
        fix_pfNumCOUNTER = 1;
        fix_pnTCounter = 1;
        fix_pndCOUNTER = 1;
        fix_mnCOUNTER = 1;

            for k = 1:files_length 
                load(files(k))
                rmse_TumourVolume_PFvMEASUR = ExecuteFuncOnActualAndLongerVector(@RMSE, mouse.Tumour_Volume, mouse.Day, estimatedState(:,1) + estimatedState(:,2), mouse.Day);
    
                if iter(1) ~= numParticles && iter(2) == processNoise_Tumour && iter(3) == processNoise_Drug && iter(4) == measurementNoise
                    fix_pfNumCOUNTER = fix_pfNumCOUNTER + 1;

                    fixed_numParticles.rmsE(fix_pfNumCOUNTER) = rmse_TumourVolume_PFvMEASUR;
                    fixed_numParticles.pfNum(fix_pfNumCOUNTER) = numParticles;
                    fixed_numParticles.pnT(fix_pfNumCOUNTER) = processNoise_Tumour;
                    fixed_numParticles.pnD(fix_pfNumCOUNTER) = processNoise_Drug;
                    fixed_numParticles.mn(fix_pfNumCOUNTER) = measurementNoise;
                end
                if iter(1) == numParticles && iter(2) ~= processNoise_Tumour && iter(3) == processNoise_Drug && iter(4) == measurementNoise
                    fix_pnTCounter = fix_pnTCounter + 1;

                    fixed_processNoise_Tumour.rmsE(fix_pnTCounter) = rmse_TumourVolume_PFvMEASUR;
                    fixed_processNoise_Tumour.pfNum(fix_pnTCounter) = numParticles;
                    fixed_processNoise_Tumour.pnT(fix_pnTCounter) = processNoise_Tumour;
                    fixed_processNoise_Tumour.pnD(fix_pnTCounter) = processNoise_Drug;
                    fixed_processNoise_Tumour.mn(fix_pnTCounter) = measurementNoise;
                end
                if iter(1) == numParticles && iter(2) == processNoise_Tumour && iter(3) ~= processNoise_Drug && iter(4) == measurementNoise
                    fix_pndCOUNTER = fix_pndCOUNTER + 1;

                    fixed_processNoise_Drug.rmsE(fix_pndCOUNTER) = rmse_TumourVolume_PFvMEASUR;
                    fixed_processNoise_Drug.pfNum(fix_pndCOUNTER) = numParticles;
                    fixed_processNoise_Drug.pnT(fix_pndCOUNTER) = processNoise_Tumour;
                    fixed_processNoise_Drug.pnD(fix_pndCOUNTER) = processNoise_Drug;
                    fixed_processNoise_Drug.mn(fix_pndCOUNTER) = measurementNoise;
                end
                if iter(1) == numParticles && iter(2) == processNoise_Tumour && iter(3) == processNoise_Drug && iter(4) ~= measurementNoise
                    fix_mnCOUNTER = fix_mnCOUNTER + 1;

                    fixed_measurementNoise.rmsE(fix_mnCOUNTER) = rmse_TumourVolume_PFvMEASUR;
                    fixed_measurementNoise.pfNum(fix_mnCOUNTER) = numParticles;
                    fixed_measurementNoise.pnT(fix_mnCOUNTER) = processNoise_Tumour;
                    fixed_measurementNoise.pnD(fix_mnCOUNTER) = processNoise_Drug;
                    fixed_measurementNoise.mn(fix_mnCOUNTER) = measurementNoise;
                end
            end
            toc
    
    foldername = 'combinationsForFixed';
    mousename = sprintf('mouse_%d.mat', i);
    savepath = fullfile(pwd, foldername, date);
    if ~exist(savepath, 'dir')
        mkdir(savepath);
    end
    save(fullfile(savepath, mousename), 'fixed_numParticles', 'fixed_processNoise_Tumour', 'fixed_processNoise_Drug', "fixed_measurementNoise");
    
end