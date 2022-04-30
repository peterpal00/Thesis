function particles = PF_StateFunction(prevParticles, parameters, input, day, ProcessNoise_Tumour, ProcessNoise_Drug)

a = parameters.a;
b = parameters.b;
c = parameters.c;
ED50 = parameters.ED50;
k1 = parameters.k1;
k2 = parameters.k2;
n = parameters.n;
w = parameters.w;
x10 = parameters.x10;
bk = parameters.bk;

[numberOfStates, numberOfParticles] = size(prevParticles);

particles = zeros([numberOfStates numberOfParticles]);

parfor kk=1:numberOfParticles
    [t,x] = ode45(@(t,x)Func_tum_V4(x,a,b,c,n,k1,k2,bk,ED50,w, input),[day day+1],[prevParticles(1,kk) prevParticles(2,kk) prevParticles(3, kk) prevParticles(4, kk)]);
    particle = x(end,:);
    particle = particle';

    %particle = Func_tum_V4(x,a,b,c,n,k1,k2,bk,ED50,w, measurement)
    particles(1, kk) = particle(1);
    particles(2, kk) = particle(2);
    particles(3, kk) = particle(3);
    particles(4, kk) = particle(4);

end


% Add Gaussian noise with variance 0.025 on each state variable
% processNoise = 0.025*eye(numberOfStates) ;
% particles = particles + processNoise * randn(size(particles));



% New noise method
% processNoise = ProcessNoise * eye(numberOfStates) ;
% particles = particles .* (ones(size(particles)) + processNoise * randn(size(particles)));
processNoise_Tumour = ProcessNoise_Tumour * eye(2) ;
processNoise_Drug = ProcessNoise_Drug * eye(2) ;
particles(1:2,:) = particles(1:2,:) .* (ones(size(particles(1:2,:)))) + processNoise_Tumour * randn(size(particles(1:2,:)));
particles(3:4,:) = particles(3:4,:) .* (ones(size(particles(3:4,:)))) + processNoise_Drug * randn(size(particles(3:4,:)));

for ii = 1:numberOfParticles
    if particles(1, ii) < 0
        particles(1, ii) = 0;
    end

    if particles(2, ii) < 0
        particles(2, ii) = 0;
    end

    if particles(3, ii) < 0
        particles(3, ii) = 0;
    end

    if particles(4, ii) < 0
        particles(4, ii) = 0;
    end

end