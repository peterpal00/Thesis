function [pf] = MakeParticleFilter(x00, numParticles)
%% Creating particle filter - NEW METHOD

%fprintf('creating particle filter \n')

pf = particleFilter;

pf.StateEstimationMethod = 'mean';
pf.ResamplingMethod = 'stratified';

pf.StateTransitionFcn = @PF_StateFunction;
pf.MeasurementLikelihoodFcn = @PF_MeasurementLikelihood;

initialize(pf, numParticles, x00, eye(4));

end