function [best_results, lowest_x_percent, zz] = BestXPercentResults(original, values_from_original, percent, z)
    original_length = length(original);
    x_percent = round(original_length/100 * percent);
    lowest_x_percent = mink(values_from_original, x_percent);
    best_results_indx = zeros(length(lowest_x_percent), 1);
    for k = 1:length(lowest_x_percent)
        best_results_indx(k) = find(values_from_original == lowest_x_percent(k));
    end
    best_results = strings(length(best_results_indx), 1);
    for l = 1:length(best_results_indx)
        best_results(l) = original(best_results_indx(l));
        zz.numParticles(l) = z.numParticles(best_results_indx(l));
        zz.processNoise_Drug(l) = z.processNoise_Drug(best_results_indx(l));
        zz.processNoise_Tumour(l) = z.processNoise_Tumour(best_results_indx(l));
        zz.measurementNoise(l) = z.measurementNoise(best_results_indx(l));
    end
end