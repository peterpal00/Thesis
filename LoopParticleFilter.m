function [predictedState, estimatedState, predictedCovariance, estimatedCovariance] = LoopParticleFilter(pf, params, lastDayOfTherapy, numDays, everyDayInput, mouse, processNoise_Tumour, processNoise_Drug, measurementNoise)
    %% looping - NEW METHOD
    
    %fprintf('looping particle filter \n')
    
    % OK: correct es a measurement lepeseket csak a mouse.Days napokon elvegezni.
    
    predictedState = zeros(lastDayOfTherapy,4);
    predictedCovariance = cell(lastDayOfTherapy,1);

    estimatedState = zeros(numDays,4);
    estimatedCovariance = cell(numDays,4);
    measurement = zeros(length(mouse.Day));

    %noise = 0.1;
    
    ifThisFirstLoop = true;
    j = 1;
    for i = 1:lastDayOfTherapy % OK: itt is everyDayInput-ra csere
        % Predict next position. Resample particles if necessary.
        [predictedState(i,:),predictedCovariance{i}] = predict(pf, params, everyDayInput(i), i, processNoise_Tumour, processNoise_Drug); % OK: mouse.Dose helyett everyDayInput mert 0 ertek kell neki amikor nincs meres
        
        
        if(ismember(i, mouse.Day) | ifThisFirstLoop)
            % Generate dot measurement with random noise. This is
            % equivalent to the observation step.
            %measurement(j,:) = mouse.Tumour_Volume(j);% + noise*(rand([1 2])-noise/2); %%% OK: HIBA: OUTPUT helyett INPUT van!!!
            % Correct position based on the given measurement to get best estimation.
            % Actual dot position is not used. Store corrected position in data array.
            [estimatedState(j,:),estimatedCovariance{j}] = correct(pf, measurement(j), measurementNoise);
            j = j + 1;
            ifThisFirstLoop = false;
        end
        
%         pause(0.00001);
%         if length(txt) > 0
%             fprintf(repmat('\b',1,txt));
%         end
%         
%         if i == length(everyDayInput)
%             fprintf('loop: %d%%', 100);
%         else
%             txt = fprintf('loop: %d%%', round(i/length(everyDayInput) * 100));
%         end
        
    end

end