function [everyDayInput, lastDayOfTherapy] = MakeEveryDayInput(mouse)

fprintf('fill the missing experiment days \n')

% Makes a vector(everyDayInput) filled with every daily dose(all the days also where was no
% measurement)
lastDayOfTherapy = max(mouse.Day);
everyDayInput = zeros(lastDayOfTherapy, 1);

for i = 1:size(everyDayInput,1)
    place = find(mouse.Day == i);
    if ~isempty(place)
        everyDayInput(i) = mouse.Dose(place);
    end
end

end