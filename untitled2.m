pf = plot(mouse.Day, estimatedState(:,1) + estimatedState(:,2));
hold on
sum = plot(tOut,xOut(:,1) +  xOut(:,2));
oriSum = scatter(mouse.Day, mouse.Tumour_Volume);