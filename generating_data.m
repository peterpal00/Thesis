%% config main parameters

particle_Range1 = 50:50:200;
particle_Range2 = 300:500:2000;
particle_Range = [20, particle_Range1, particle_Range2];

mouseID_Range = 1:7;

processNoise_Tumour_Range1 = 1:2:9;
processNoise_Tumour_Range2 = 10:20:100;
processNoise_Tumour_Range3 = 100:30:200;
processNoise_Tumour_Range = [processNoise_Tumour_Range1, processNoise_Tumour_Range2, processNoise_Tumour_Range3];

processNoise_Drug_Range1 = 0.01:0.03:0.15;
processNoise_Drug_Range2 = 1.5:0.5:3;
processNoise_Drug_Range = [processNoise_Drug_Range1, processNoise_Drug_Range2];

measurementNoise_Range = 0.002:0.005:0.032; %0.016;
% particle_Range = 500;
% mouseID_Range = 2;
% processNoise_Tumour_Range = 100;
% processNoise_Drug_Range = 1.5;
% measurementNoise_Range = 0.016;

all_cases = length(particle_Range) * length(mouseID_Range) * length(processNoise_Tumour_Range) * length(processNoise_Drug_Range) * length(measurementNoise_Range);
numPassedCases = 0;


%% get current folder
folder.currentFolder = pwd;
folder.date = datestr(now, 'dd-mm-yyyy_HH-MM');
resultFolder = 'Results';

%% open measurements (2).mat file

[rawDays, rawDoses, rawTumourVolumes] = OpenRawData();

%% create waitbar

pw = PoolWaitbar(all_cases, 'Hello');
%% split the table by ID
tStart = tic;
for mouseID_iter = 1:length(mouseID_Range)

   

    mouseID = mouseID_Range(mouseID_iter);
    [mouse] = makeMouseTable(rawDays, rawDoses, rawTumourVolumes, mouseID);

    
    %% get the tumour parameters
    
    [params, x0, x00] = LoadParameters(mouseID);
    
    %% make the timeline and input of the simulation
    
    [everyDayInput, lastDayOfTherapy, numDays] = MakeEveryDayInput(mouse);
    
    %% simulation
    
    [tOut, xOut] = ODE_Simulation(params, x0, lastDayOfTherapy, everyDayInput);
    
    %% plot simu
    
    %Plot_ODE(tOut, xOut, mouse);

    parfor particleNum_iter = 1:length(particle_Range)

        

        %% Creating particle filter - NEW METHOD

        numParticles = particle_Range(particleNum_iter);
        pf = MakeParticleFilter(x00, numParticles);
        pf.ResamplingPolicy.TriggerMethod = 'interval';

        for processNoise_Tumour_iter = 1:length(processNoise_Tumour_Range)
            
            processNoise_Tumour = processNoise_Tumour_Range(processNoise_Tumour_iter);

            for processNoise_Drug_iter = 1:length(processNoise_Drug_Range)
                
                processNoise_Drug = processNoise_Drug_Range(processNoise_Drug_iter);

                for measurementNoise_iter = 1:length(measurementNoise_Range)

                    measurementNoise = measurementNoise_Range(measurementNoise_iter);
                    %fprintf('LOOP ERROR: m%dnpf%dpnT%.3gpnD%.3gmn%.3g', mouseID, numParticles,processNoise_Tumour, processNoise_Drug, measurementNoise')
                    %% looping - NEW METHOD

%                     [predictedState, estimatedState, predictedCovariance, estimatedCovariance] = LoopParticleFilter(pf, params, lastDayOfTherapy, numDays, everyDayInput, mouse, processNoise_Tumour, processNoise_Drug, measurementNoise);
                    try
                        [predictedState, estimatedState, predictedCovariance, estimatedCovariance] = LoopParticleFilter(pf, params, lastDayOfTherapy, numDays, everyDayInput, mouse, processNoise_Tumour, processNoise_Drug, measurementNoise);
                    catch
                        fprintf('LOOP ERROR: m%dnpf%dpnT%.3gpnD%.3gmn%.3g', mouseID, numParticles,processNoise_Tumour, processNoise_Drug, measurementNoise')
                    end
        
                    %% get save Path
                    
                    savePath = getSavePathResult(resultFolder, folder, mouseID, numParticles, processNoise_Tumour, processNoise_Drug, measurementNoise);
        
                    %% plotting particled states
                    %PlotParticleFilter(estimatedState, mouse, tOut, xOut, mouseID, numParticles, processNoise_Tumour, processNoise_Drug, measurementNoise, savePath);
        
                    increment(pw);
        
                    %% save environmental variables
        
                    file = savePath + ".mat";
                    try
                        parsave(file, mouseID, numParticles, processNoise_Tumour, processNoise_Drug, measurementNoise, tOut, xOut, pf, params, lastDayOfTherapy, everyDayInput, mouse, rawDays, rawDoses, rawTumourVolumes, predictedState, estimatedState, predictedCovariance, estimatedCovariance);
                    catch
                        fprintf(fprintf('PARSAVE ERROR: m%dnpf%dpnT%.3gpnD%.3gmn%.3g', mouseID, numParticles,processNoise_Tumour, processNoise_Drug, measurementNoise'))
                    end

                end

            end

        end

    end
    %% sign that mouse is over
    overfilepath = fullfile(folder.currentFolder, resultFolder, folder.date);
    overf = sprintf('%d_over.mat', mouseID);
    overfilename = fullfile(overfilepath, overf);
    if ~exist(overfilepath, 'dir')
        mkdir(overfilepath);
    end
    save(overfilename, 'overf');
end
rangefilename = 'ranges.mat';
rangefile = fullfile(resultFolder,folder.date, rangefilename);
tEnd = toc(tStart);
parsave(rangefile, particle_Range, tEnd, mouseID_Range, processNoise_Tumour_Range, processNoise_Drug_Range, measurementNoise_Range);
tEnd













