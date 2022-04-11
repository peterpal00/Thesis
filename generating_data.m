%% config main parameters

particle_Range = [10:10:50];
mouseID_Range = [1:5];
processNoise_Range = [0.4:0.1:1];

        %config.numParticles = 10;
        config.ResamplingPolicy = 'interval';
        %config.ProcessNoise = 0.8;
        config.MeasurementNoise = 0.016;
        %config.mouseID = 2;

%% open measurements (2).mat file

[rawDays, rawDoses, rawTumourVolumes] = OpenRawData();


%% split the table by ID
for mouseID_iter = mouseID_Range

    config.mouseID = mouseID_iter;

    mouseID = config.mouseID;
    [mouse] = makeMouseTable(rawDays, rawDoses, rawTumourVolumes, mouseID);
    
    %% get the tumour parameters
    
    [params, x0, x00] = LoadParameters(mouseID);
    
    %% make the timeline and input of the simulation
    
    [everyDayInput, lastDayOfTherapy] = MakeEveryDayInput(mouse);
    
    %% simulation
    
    [tOut, xOut] = ODE_Simulation(params, x0, lastDayOfTherapy, everyDayInput);
    
    %% plot simu
    
    Plot_ODE(tOut, xOut, mouse);

    parfor particleNum_iter = particle_Range

        config.numParticles = particleNum_iter;

        %% Creating particle filter - NEW METHOD

        numParticles = config.numParticles;
        pf = MakeParticleFilter(x00, numParticles);
        pf.ResamplingPolicy.TriggerMethod = config.ResamplingPolicy;

        for processNoise_iter = processNoise_Range



            %% looping - NEW METHOD

            [predictedState, estimatedState, predictedCovariance, estimatedCovariance] = LoopParticleFilter(pf, params, lastDayOfTherapy, everyDayInput, mouse, config);

            %% plotting particled states
            PlotParticleFilter(estimatedState, mouse, tOut, xOut, config);

        end

    end
end













