% first test with a 2k sin tone at 0 degrees
N = csvread('2k_sin_0.csv');
N = (N - mean(N));
N = N./max(N);
section = N(300001:308000,:);
fs = 16000;

section = resample(section, 1, 3);

% test 1000 samples of data at 180 steering angles from -90 to 90 degrees.
energy = [];
for i = -90:90
    bf = DelayAndSum(0.0425, 2000, 16, fs, i, 340, 1024);
    output = bf.process(section);
    % Save the energy of the output
    energy = [energy sum(output.^2)];
end

figure
plot(-90:90, 20*log10((energy/max(energy))))
xlabel('steered angle')
ylabel('energy')
title('2 Khz sin tone at ~45 degrees')
[maxval, idx] = max(energy);
hold on
%scatter(idx - 91, maxval)
lab = string(idx - 91);
text(idx - 87, maxval, char(lab) , 'Color', 'black');

%Now plot the 2D fft to compare
figure
half_lambda_scale = 16*(340/2000)/2;
image(half_lambda_scale*[-90, 90], [-fs/2, fs/2], fftshift((abs(fft2(section, 1000, 1000)))))


%% 
% Repeat with a sin wave propagating from 45 degrees
N = csvread('2k_sin_45.csv');
N = (N - mean(N));
N = N./max(N);
section = N(300001:308000,:);
section = resample(section, 1, 3);
% test 1000 samples of data at 180 steering angles from -90 to 90 degrees.
energy = [];

beamformers = {};
for i = 1:181
    beamformers{i} = DelayAndSum(0.0425, 2000, 16, fs, i - 91, 340, 1024);
end

tic
for i = -90:90
    output = beamformers{i + 91}.process(section);
    % Save the energy of the output
    energy(i + 91) = sum(output.^2);
end
toc

figure
plot(-90:90, (energy))
xlabel('steered angle')
ylabel('energy')
title('2 Khz sin tone at ~45 degrees')
[maxval, idx] = max(energy);
hold on
scatter(idx - 91, maxval)
lab = string(idx - 91);
text(idx - 87, maxval, char(lab) , 'Color', 'black');

%Now plot the 2D fft to compare
figure
half_lambda_scale = 16*(340/2000)/2;


% Divide frequency by speed


image(fftshift((abs(fft2(section, 1000, 1000)))))

%figure
%mesh(fftshift((abs(fft2(section, 1000, 1000)))))


% VC707 vertex 7. ADC cards



%% Test with speech
% Repeat with a sin wave propagating from 45 degrees
N = csvread('speech_45.csv');
N = (N - mean(N));
N = N./max(N);
section = N(254000:264000,:);
section = resample(section, 1, 3);
% test 1000 samples of data at 180 steering angles from -90 to 90 degrees.
energy = [];

sound(N(:, 1), 48000);

beamformers = {};
for i = 1:181
    beamformers{i} = DelayAndSum(0.0425, 2000, 16, fs, i - 91, 340, 1024);
end

tic
for i = -90:90
    output = beamformers{i + 91}.process(section);
    % Save the energy of the output
    energy(i + 91) = sum(output.^2);
end
toc

figure
plot(-90:90, (energy))
xlabel('steered angle')
ylabel('energy')
title('2 Khz sin tone at ~45 degrees')
[maxval, idx] = max(energy);
hold on
scatter(idx - 91, maxval)
lab = string(idx - 91);
text(idx - 87, maxval, char(lab) , 'Color', 'black');
figure
image(fftshift((abs(fft2(section, 10000, 10000)))))

%% Test with chirp
% Repeat with a sin wave propagating from 45 degrees
N = csvread('chirp_1_3_45.csv');
N = (N - mean(N));
N = N./max(N);
plot(N(:, 1));
section = N(110000:200000,:);
fs = 16000;

section = resample(section, 1, 3);
plot(section)
% test 1000 samples of data at 180 steering angles from -90 to 90 degrees.
energy = [];

beamformers = {};
for i = 1:181
    beamformers{i} = DelayAndSum(0.0425, 2000, 8, fs, i - 91, 340, 10000);
end

tic
for i = -90:90
    output = beamformers{i + 91}.process(section(:, 5:12));
    % Save the energy of the output
    energy(i + 91) = sum(output.^2);
end
toc

figure
plot(-90:90, (energy))
xlabel('steered angle')
ylabel('energy')
title('2 Khz sin tone at ~45 degrees')
[maxval, idx] = max(energy);
hold on
scatter(idx - 91, maxval)
lab = string(idx - 91);
text(idx - 87, maxval, char(lab) , 'Color', 'black');

figure
image(fftshift((abs(fft2(section, 100000, 1000)))))

%%
%% Test with chirp
% Repeat with a sin wave propagating from 45 degrees
N = csvread('chirp_1_3_45.csv');
N = (N - mean(N));
N = N./max(N);
plot(N(:, 1));
section = N(110000:200000,:);
fs = 16000;

section = resample(section, 1, 3);
plot(section)
% test 1000 samples of data at 180 steering angles from -90 to 90 degrees.
energy = [];

beamformers = {};
for i = 1:181
    beamformers{i} = DelayAndSum(0.0425, 2000, 8, fs, i - 91, 340, 10000);
end

tic
for i = -90:90
    output = beamformers{i + 91}.process(section(:, 5:12));
    % Save the energy of the output
    energy(i + 91) = sum(output.^2);
end
toc

figure
plot(-90:90, (energy))
xlabel('steered angle')
ylabel('energy')
title('2 Khz sin tone at ~45 degrees')
[maxval, idx] = max(energy);
hold on
scatter(idx - 91, maxval)
lab = string(idx - 91);
text(idx - 87, maxval, char(lab) , 'Color', 'black');

figure
image(fftshift((abs(fft2(section, 100000, 1000)))))