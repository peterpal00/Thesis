clear all;
%% config main parameters

config.numParticles = 10;
config.ResamplingPolicy = 'interval';
config.ProcessNoise = 0.8;
config.MeasurementNoise = 0.016;
config.mouseID = 2;

%% open measurements (2).mat file

[rawDays, rawDoses, rawTumourVolumes] = OpenRawData();

%% split the table by ID

mouseID = config.mouseID;
[mouse] = makeMouseTable(rawDays, rawDoses, rawTumourVolumes, mouseID);

%% get the tumour parameters

[params, x0, x00] = LoadParameters(mouseID);

%% make the timeline and input of the simulation

[everyDayInput, lastDayOfTherapy] = MakeEveryDayInput(mouse);

%% simulation

[tOut, xOut] = ODE_Simulation(params, x0, lastDayOfTherapy, everyDayInput);

%% plot simu

%Plot_ODE(tOut, xOut, mouse);

%% Creating particle filter - NEW METHOD

numParticles = config.numParticles;
pf = MakeParticleFilter(x00, numParticles);
pf.ResamplingPolicy.TriggerMethod = config.ResamplingPolicy;

%% looping - NEW METHOD

[predictedState, estimatedState, predictedCovariance, estimatedCovariance] = LoopParticleFilter(pf, params, lastDayOfTherapy, everyDayInput, mouse, config);

%% plotting particled states
PlotParticleFilter(estimatedState, mouse, tOut, xOut, config);


%HIBA: legelso adat nem szamolodik bele a modellezesdbe(day1) lehet hogy
%elcsuszott????
%- nezni kellene
% - a gyogyszer koncit kevesbe modositsa egy adott lepesnel, kisebb sulyt

%rootmeanquareerror
%nrnse
% a tobbi allapotvaltozot is nezni kellene
% merni00: - iranyvaltasi szam
% milyen gyakran mond hulyeseget
