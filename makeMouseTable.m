function [mouse] = makeMouseTable(rawDays, rawDoses, rawTumourVolumes, mouseID)

%% split the table by ID

fprintf('making a mouse data frame \n')

vPLDidx = [2,3,4,5,6,9,10];

varNames = {'Day', 'Tumour_Volume', 'Dose'};
mouse = table(rawDays{vPLDidx(mouseID)}, rawTumourVolumes{vPLDidx(mouseID)}, rawDoses{vPLDidx(mouseID)});
mouse.Properties.VariableNames = varNames;

end