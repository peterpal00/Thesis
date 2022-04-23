%% config main parameters

particle_Range = 1:1:3;
mouseID_Range = 1:5;
processNoise_Range = 0.1:0.1:0.3;

all_cases = length(particle_Range) * length(mouseID_Range) * length(processNoise_Range);
numPassedCases = 0;

%config.numParticles = 10;
ResamplingPolicy = 'interval';
%config.ProcessNoise = 0.8;
MeasurementNoise = 0.016;
%config.mouseID = 2;

%% get current folder
folder.currentFolder = pwd;
folder.date = datestr(now, 'dd-mm-yyyy_HH-MM');

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
    
    [everyDayInput, lastDayOfTherapy] = MakeEveryDayInput(mouse);
    
    %% simulation
    
    [tOut, xOut] = ODE_Simulation(params, x0, lastDayOfTherapy, everyDayInput);
    
    %% plot simu
    
    Plot_ODE(tOut, xOut, mouse);

    parfor particleNum_iter = 1:length(particle_Range)

        

        %% Creating particle filter - NEW METHOD

        numParticles = particle_Range(particleNum_iter);
        pf = MakeParticleFilter(x00, numParticles);
        pf.ResamplingPolicy.TriggerMethod = ResamplingPolicy;

        for processNoise_iter = 1:length(processNoise_Range)

        measurementNoise = MeasurementNoise;
        processNoise = processNoise_Range(processNoise_iter);

            %% looping - NEW METHOD

            [predictedState, estimatedState, predictedCovariance, estimatedCovariance] = LoopParticleFilter(pf, params, lastDayOfTherapy, everyDayInput, mouse, processNoise, measurementNoise);

            %% get save Path

            savePath = getSavePath(folder, mouseID, numParticles, processNoise, measurementNoise);

            %% plotting particled states
            %PlotParticleFilter(estimatedState, mouse, tOut, xOut, mouseID, numParticles, processNoise, measurementNoise, ResamplingPolicy, savePath);

            increment(pw);

            %% save environmental variables

            file = savePath + ".mat";
            parsave(file, mouseID, numParticles, processNoise, measurementNoise, ResamplingPolicy, tOut, xOut, pf, params, lastDayOfTherapy, everyDayInput, mouse, rawDays, rawDoses, rawTumourVolumes);


        end

    end
end
tEnd = toc(tStart);
tEnd













