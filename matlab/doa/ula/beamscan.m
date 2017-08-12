fs = 8000;
t = (0:1/fs:1).';
x1 = cos(2*pi*t*300);
x2 = cos(2*pi*t*400);
array = phased.ULA('NumElements',10,'ElementSpacing',1);
array.Element.FrequencyRange = [100e6 300e6];
fc = 150e6;
x = collectPlaneWave(array,[x1 x2],[10 20;60 -5]');
noise = 0.1*(randn(size(x)) + 1i*randn(size(x)));


estimator = phased.BeamscanEstimator('SensorArray',array, ...
    'OperatingFrequency',fc,...
    'DOAOutputPort',true,'NumSignals',2);
[y,doas] = estimator(x + noise);
doas = broadside2az(sort(doas),[20 -5])


plotSpectrum(estimator);