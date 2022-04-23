function [rawDays,rawDoses, rawTumourVolumes] = OpenRawData()
%% open measurements (2).mat file

%fprintf('load experiment data \n')

filename = 'measurements (2).mat';
measurements = load(filename);
xd = measurements(1).measurement(1);
xd2 = xd{1};
%rawTumourVolumes = xd2.vVolumePhysCon;
rawTumourVolumes = xd2.vVolumeTTK;
rawDoses = xd2.vDose;
rawDays = xd2.tMeasurement;

end