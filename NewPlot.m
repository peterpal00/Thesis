function NewPlot(mouse, estimatedState, tOut, xOut, mouseID, numParticles, processNoise_Tumour, processNoise_Drug, measurementNoise)
    
    titletxt1 = sprintf('mouseID: %d, particle num.: %d, proc. noise. tum.: %.3g', mouseID, numParticles, processNoise_Tumour);
    titletxt2 = sprintf('proc. noise. drug.: %.3g, measur. noise: %.3g', processNoise_Drug, measurementNoise);

    pf = plot(mouse.Day, estimatedState(:,1) + estimatedState(:,2));
    title(titletxt1, titletxt2);
    xlabel('Experiment days') 
    ylabel('Tumour volume') 
    hold on
    sum = plot(tOut,xOut(:,1) +  xOut(:,2));
    oriSum = scatter(mouse.Day, mouse.Tumour_Volume);
    %legend([pf, sum, oriSum], 'ParticeFilter', 'ODE45 model', 'Actual Tumour Vol.');
    hold off

%     pf_conc = scatter(mouse.Day, estimatedState(:,4));
%     pf_conc.Marker = 'x';
%     title(titletxt1, titletxt2);
%     xlabel('Experiment days') 
%     ylabel('Drug conc. in peripheral compartment') 
%     hold on
%     ode45_conc = plot(tOut,xOut(:,4));
%     %legend([pf, sum, oriSum], 'ParticeFilter', 'ODE45 model', 'Actual Tumour Vol.');
%     hold off

end