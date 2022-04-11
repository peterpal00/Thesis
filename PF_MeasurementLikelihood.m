function likelihood = PF_MeasurementLikelihood(predictedParticles, measurement, config)

numberOfMeasurements = 1;

% Assume that measurements are subject to Gaussian distributed noise with
% variance 0.016
% Specify noise as covariance matrix
var = config.MeasurementNoise;
measurementNoise = var * eye(numberOfMeasurements);

% The measurement contains the first state variable. Get the first state of
% all particles
predictedMeasurement = predictedParticles(1,:) + predictedParticles(2,:);

% Calculate error between predicted and actual measurement
measurementError = bsxfun(@minus, predictedMeasurement(1, :), measurement);

% Use measurement noise and take inner product
measurementErrorProd = dot(measurementError, measurementNoise \ measurementError, 1);
%measurementErrorProd = sqrt(sum(measurementError.^2, 2));

likelihood = 1/sqrt((2*pi).^numberOfMeasurements * det(measurementNoise)) * exp(-0.5 * measurementErrorProd);
% a = exp(-0.5 * measurementErrorProd);
% b = numberOfMeasurements * det(measurementNoise);
% c = 1/sqrt((2*pi).^numberOfMeasurements * det(measurementNoise));
% e = exp(-0.5 * measurementErrorProd);
% d = c*e;
% likelihood = d;



end