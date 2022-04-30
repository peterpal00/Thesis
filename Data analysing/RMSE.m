function [rmse] = RMSE(actual, predicted)
    if iscolumn(actual)
        actual = actual';
    end

    if iscolumn(predicted)
        predicted = predicted';
    end

    rmse = sqrt(mean((predicted - actual).^2));
end