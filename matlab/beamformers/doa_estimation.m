
figure
%% Estimate Directions of Arrival of Two Signals
% Estimate the DOA's of two signals received by a
% 10-element ULA with element spacing of 1 meter. The antenna
% operating frequency is 150 MHz. The actual direction of the
% first signal is 10&deg; in azimuth and 20&deg; in
% elevation. The direction of the second signal is 60&deg; in
% azimuth and -5&deg; in elevation.
%%
% Create the signals and array.
fs = 8000;
t = (0:1/fs:1).';
x1 = cos(2*pi*t*2000);
x2 = cos(2*pi*t*4000);
array = phased.ULA('NumElements',16,'ElementSpacing',0.0425);
%array.Element.FrequencyRange = [200 8000];
fc = 4000;
x = collectPlaneWave(array,[x1 x2],[0 0;80 0]',fc, 340);
noise = 0.1*(randn(size(x)) + 1i*randn(size(x)));

%'Direction',incidentAngle

pattern(array, 2000.',[-90:90],0,'CoordinateSystem','rectangular',...
    'PlotStyle','overlay','Type','powerdb','PropagationSpeed',340)


%%
% Solve for the DOAs.
estimator = phased.BeamscanEstimator('SensorArray',array, ...
    'OperatingFrequency',fc,...
    'DOAOutputPort',true,'NumSignals',1, 'PropagationSpeed', 340);
[y,doas] = estimator(x + noise);
%doas = broadside2az(sort(doas),[20 -5])

%% Plot the beamscan spectrum
%


subplot(2, 2, 1)

plotSpectrum(estimator);







fs = 8000;
t = (0:1/fs:1).';
x1 = cos(2*pi*t*2000);
x2 = cos(2*pi*t*4000);
array = phased.ULA('NumElements',16,'ElementSpacing',0.0425);
%array.Element.FrequencyRange = [200 8000];
fc = 4000;
x = collectPlaneWave(array,[x1 x2],[15 0;65 0]',fc, 340);
noise = 0.1*(randn(size(x)) + 1i*randn(size(x)));

%'Direction',incidentAngle

%pattern(array, 2000.',[-90:90],0,'CoordinateSystem','rectangular',...
%    'PlotStyle','overlay','Type','powerdb','PropagationSpeed',340)


%%
% Solve for the DOAs.
estimator = phased.BeamscanEstimator('SensorArray',array, ...
    'OperatingFrequency',fc,...
    'DOAOutputPort',true,'NumSignals',1, 'PropagationSpeed', 340);
[y,doas] = estimator(x + noise);
%doas = broadside2az(sort(doas),[20 -5])

%% Plot the beamscan spectrum
%


subplot(2, 2, 2)

plotSpectrum(estimator);










fs = 8000;
t = (0:1/fs:1).';
x1 = cos(2*pi*t*2000);
x2 = cos(2*pi*t*4000);
array = phased.ULA('NumElements',16,'ElementSpacing',0.0425);
%array.Element.FrequencyRange = [200 8000];
fc = 4000;
x = collectPlaneWave(array,[x1 x2],[30 0;40 0]',fc, 340);
noise = 0.1*(randn(size(x)) + 1i*randn(size(x)));

%'Direction',incidentAngle

%pattern(array, 2000.',[-90:90],0,'CoordinateSystem','rectangular',...
%    'PlotStyle','overlay','Type','powerdb','PropagationSpeed',340)


%%
% Solve for the DOAs.
estimator = phased.BeamscanEstimator('SensorArray',array, ...
    'OperatingFrequency',fc,...
    'DOAOutputPort',true,'NumSignals',1, 'PropagationSpeed', 340);
[y,doas] = estimator(x + noise);
doas
%doas = broadside2az(sort(doas),[20 -5])

%% Plot the beamscan spectrum
%


subplot(2, 2, 3)

plotSpectrum(estimator);







fs = 8000;
t = (0:1/fs:1).';
x1 = cos(2*pi*t*2000);
x2 = cos(2*pi*t*4000);
array = phased.ULA('NumElements',16,'ElementSpacing',0.0425);
%array.Element.FrequencyRange = [200 8000];
fc = 4000;
x = collectPlaneWave(array,[x1 x2],[-10 0;10 0]',fc, 340);
noise = 0.1*(randn(size(x)) + 1i*randn(size(x)));

%'Direction',incidentAngle

%pattern(array, 2000.',[-90:90],0,'CoordinateSystem','rectangular',...
%    'PlotStyle','overlay','Type','powerdb','PropagationSpeed',340)


%%
% Solve for the DOAs.
estimator = phased.BeamscanEstimator('SensorArray',array, ...
    'OperatingFrequency',fc,...
    'DOAOutputPort',true,'NumSignals',1, 'PropagationSpeed', 340);
[y,doas] = estimator(x + noise);
doas
%doas = broadside2az(sort(doas),[20 -5])

%% Plot the beamscan spectrum
%


subplot(2, 2, 4)

plotSpectrum(estimator);

