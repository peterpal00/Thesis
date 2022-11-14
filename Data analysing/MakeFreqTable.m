function MakeFreqTable(numParticles, processNoise_Tumour, processNoise_Drug, measurementNoise)
    numpTab0 = tabulate(numParticles);
    pntTab0 = tabulate(processNoise_Tumour);
    pndTab0 = tabulate(processNoise_Drug);
    mnTab0 = tabulate(measurementNoise);

    numpTab = NonZero(numpTab0);
    pntTab = NonZero(pntTab0);
    pndTab = NonZero(pndTab0);
    mnTab = NonZero(mnTab0);

    tl = tiledlayout(2,2);
    nexttile;
    xx = categorical(numpTab(:, 1));
    bar(xx ,numpTab(:, 3));
    title('Particle number frequency');
    xlabel('Parameter values')
    ylabel('Value frequency [%]')
    nexttile;

    xx = categorical(pntTab(:, 1));
    bar(xx,pntTab(:, 3));
    title('Process noise Tumour frequency');
    xlabel('Parameter values')
    ylabel('Value frequency [%]')
    nexttile;

    xx = categorical(pndTab(:, 1));
    bar(xx,pndTab(:, 3));
    title('Process noise Drug frequency');
    xlabel('Parameter values')
    ylabel('Value frequency [%]')
    nexttile;

    xx = categorical(mnTab(:, 1));
    bar(xx,mnTab(:, 3));
    title('Measurement noise frequency');
    xlabel('Parameter values')
    ylabel('Value frequency [%]')

    
end