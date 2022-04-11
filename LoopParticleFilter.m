function [predictedState, estimatedState, predictedCovariance, estimatedCovariance] = LoopParticleFilter(pf, params, lastDayOfTherapy, everyDayInput, mouse, config)
    %% looping - NEW METHOD
    
    fprintf('looping particle filter \n')
    
    % OK: correct es a measurement lepeseket csak a mouse.Days napokon elvegezni.
    
    predictedState = zeros(length(lastDayOfTherapy),4);
    estimatedState = zeros(length(lastDayOfTherapy),4);
    noise = 0.1;
    
txt = fprintf('');

    j = 1;
    for i = 1:length(everyDayInput) % OK: itt is everyDayInput-ra csere
        % Predict next position. Resample particles if necessary.
        [predictedState(i,:),predictedCovariance] = predict(pf, params, everyDayInput(i), i, config); % OK: mouse.Dose helyett everyDayInput mert 0 ertek kell neki amikor nincs meres
        
        
        if(ismember(i, mouse.Day))
            % Generate dot measurement with random noise. This is
            % equivalent to the observation step.
            measurement(j,:) = mouse.Tumour_Volume(j);% + noise*(rand([1 2])-noise/2); %%% OK: HIBA: OUTPUT helyett INPUT van!!!
            % Correct position based on the given measurement to get best estimation.
            % Actual dot position is not used. Store corrected position in data array.
            [estimatedState(j,:),estimatedCovariance] = correct(pf, measurement(j), config);
            j = j + 1;
        end
        
        pause(0.001);
        if length(txt) > 0
            fprintf(repmat('\b',1,txt));
        end
        
        if i == length(everyDayInput)
            fprintf('loop: %d%%', 100);
        else
            txt = fprintf('loop: %d%%', round(i/length(everyDayInput) * 100));
        end
        
    end

end