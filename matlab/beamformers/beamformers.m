%% Apply Frost Beamforming to ULA
% Apply Frost beamforming to an 11-element acoustic ULA array. The incident angle of the
% incoming signal is -50 degrees in azimuth and 30 degrees in elevation.
% The speed of sound in air is assumed to be 340 m/sec. The signal has
% added gaussian white noise.
%%
% Simulate the signal.
array = phased.ULA('NumElements',16,'ElementSpacing',42.5/1000);
array.Element.FrequencyRange = [20 4000];
fs = 8e3;
t = 0:1/fs:0.3;
x = chirp(t,0,1,500);
c = 340;
collector = phased.WidebandCollector('Sensor',array,...
    'PropagationSpeed',c,'SampleRate',fs,...
    'ModulatedInput',false,'NumSubbands',8192);
incidentAngle = [0;50];
x = collector(x.',incidentAngle);
noise = 0.2*randn(size(x));
rx = x + noise;
%%
% Beamform the signal.
beamformer = phased.FrostBeamformer('SensorArray',array,...
    'PropagationSpeed',c,'SampleRate',fs,...
    'Direction',incidentAngle,'FilterLength',5, 'WeightsOutputPort',true);

en = []
for i = -90:90
    sig = sin(2*pi*1000*(1:1000)/fs);
    
    collector = phased.WidebandCollector('Sensor',array,...
    'PropagationSpeed',c,'SampleRate',fs,...
    'ModulatedInput',false,'NumSubbands',8192);
    incidentAngle = [0;i];
    
    x = collector(sig.',incidentAngle);
    y = beamformer(x);
    en = [en sum(y.^2)];
end
%%
% Plot the beamformed output.
plot(t,rx(:,6),'r:',t,y)
xlabel('Time')
ylabel('Amplitude')
legend('Original','Beamformed')

figure
pattern(beamformer.SensorArray, 1000, [-180:180],0, 'Type','directivity',...
    'PropagationSpeed',340);

%% Generalized Sidelobe Cancellation on Uniform Linear Array
% Create a GSC beamformer for a 11-element acoustic array in air. A chirp
% signal is incident on the array at &ndash;50&deg; in azimuth and 0&deg; in
% elevation. Compare the GSC beamformed signal to a Frost
% beamformed signal. The signal propagation speed is 340 m/s. The
% sample rate is 8 kHz.
%%
% Create the microphone and array System objects. The array element spacing
% is one-half wavelength. Set the signal frequency to the one-half the
% Nyquist frequency.
c = 340.0;
fs = 8.0e3;
fc = fs/2;
lam = c/fc;
transducer = phased.OmnidirectionalMicrophoneElement('FrequencyRange',[20 20000]);
array = phased.ULA('Element',transducer,'NumElements',11,'ElementSpacing',lam/2);
%%
% Simulate a chirp signal with a 500 Hz bandwidth.
t = 0:1/fs:.4;
signal = chirp(t,0,1,500);
%%
% Create an incident wavefield hitting the array.
collector = phased.WidebandCollector('Sensor',array,'PropagationSpeed',c, ...
    'SampleRate',fs,'ModulatedInput',false,'NumSubbands',512);
incidentAngle = [-50;0];
signal = collector(signal.',incidentAngle);
noise = 0.1*randn(size(signal));
recsignal = signal + noise;

%%
% Perform Frost beamforming at the actual incident angle.
frostbeamformer = phased.FrostBeamformer('SensorArray',array,'PropagationSpeed', ...
    c,'SampleRate',fs,'Direction',incidentAngle,'FilterLength',10);
yfrost = frostbeamformer(recsignal);

%%
% Perform GSC beamforming and plot the beamformer output against the Frost
% beamformer output. Also plot the nonbeamformed signal arriving at the
% middle element of the array.
gscbeamformer = phased.GSCBeamformer('SensorArray',array, ...
    'PropagationSpeed',c,'SampleRate',fs,'Direction',incidentAngle, ...
    'FilterLength',5);
ygsc = gscbeamformer(recsignal);
plot(t,recsignal(:,6),t,yfrost,t,ygsc)
xlabel('Time')
ylabel('Amplitude')

%%
% Zoom in on a small portion of the output.
idx = 1000:1300;
plot(t(idx),recsignal(idx,6),t(idx),yfrost(idx),t(idx),ygsc(idx))
xlabel('Time')
legend('Received signal','Frost beamformed signal','GSC beamformed signal')

%% MVDR Beamforming
% Apply an MVDR beamformer to a 5-element ULA. The incident angle of the
% signal is 45 degrees in azimuth and 0 degree in elevation. The signal
% frequency is .01 hertz. The carrier frequency is 300 MHz.
t = [0:.1:200]';
fr = .01;
xm = sin(2*pi*fr*t);
c = physconst('LightSpeed');
fc = 300e6;
rng('default');
incidentAngle = [45;0];
array = phased.ULA('NumElements',5,'ElementSpacing',0.5);
x = collectPlaneWave(array,xm,incidentAngle,fc,c);
noise = 0.1*(randn(size(x)) + 1j*randn(size(x)));
rx = x + noise;

%%
% Compute the beamforming weights
beamformer = phased.MVDRBeamformer('SensorArray',array,...
    'PropagationSpeed',c,'OperatingFrequency',fc,...
    'Direction',incidentAngle,'WeightsOutputPort',true);
[y,w] = beamformer(rx);

%%
% Plot the signals
plot(t,real(rx(:,3)),'r:',t,real(y))
xlabel('Time')
ylabel('Amplitude')
legend('Original','Beamformed')
%%
% Plot the array response pattern using the MVDR weights
pattern(array,fc,[-180:180],0,'PropagationSpeed',c,...
    'Weights',w,'CoordinateSystem','rectangular',...
    'Type','powerdb');



%% Apply Frost Beamforming to ULA
% Apply Frost beamforming to an 11-element acoustic ULA array. The incident angle of the
% incoming signal is -50 degrees in azimuth and 30 degrees in elevation.
% The speed of sound in air is assumed to be 340 m/sec. The signal has
% added gaussian white noise.
%%
% Simulate the signal.
array = phased.ULA('NumElements',11,'ElementSpacing',0.04);
array.Element.FrequencyRange = [20 20000];
fs = 8e3;
t = 0:1/fs:0.3;
x = chirp(t,0,1,500);
c = 340;
collector = phased.WidebandCollector('Sensor',array,...
    'PropagationSpeed',c,'SampleRate',fs,...
    'ModulatedInput',false,'NumSubbands',8192);
incidentAngle = [-50;30];
x = collector(x.',incidentAngle);
noise = 0.2*randn(size(x));
rx = x + noise;
%%
% Beamform the signal.
beamformer = phased.FrostBeamformer('SensorArray',array,...
    'PropagationSpeed',c,'SampleRate',fs,...
    'Direction',incidentAngle,'FilterLength',5);
y = beamformer(rx);
%%
% Plot the beamformed output.
plot(t,rx(:,6),'r:',t,y)
xlabel('Time')
ylabel('Amplitude')
legend('Original','Beamformed')


%% Subband Phase-Shift Beamformer for Underwater ULA
% Apply subband phase-shift beamforming to an 11-element underwater ULA. The incident
% angle of a wideband signal is 10&deg; in azimuth and 30&deg; in
% elevation. The carrier frequency is 2 kHz.

%%
% Create the ULA.
antenna = phased.ULA('NumElements',11,'ElementSpacing',0.3);
antenna.Element.FrequencyRange = [20 20000];
%%
% Create a chirp signal with noise.
fs = 1e3;
carrierFreq = 2e3;
t = (0:1/fs:2)';
x = chirp(t,0,2,fs);
c = 1500;
collector = phased.WidebandCollector('Sensor',antenna, ...
    'PropagationSpeed',c,'SampleRate',fs,...
    'ModulatedInput',true,'CarrierFrequency',carrierFreq);
incidentAngle = [10;30];
x = collector(x,incidentAngle);
noise = 0.3*(randn(size(x)) + 1j*randn(size(x)));
rx = x + noise;
%%
% Beamform in the direction of the incident angle.
beamformer = phased.SubbandPhaseShiftBeamformer('SensorArray',antenna, ...
    'Direction',incidentAngle,'OperatingFrequency',carrierFreq, ...
    'PropagationSpeed',c,'SampleRate',fs,'SubbandsOutputPort',true, ...
    'WeightsOutputPort',true);
[y,w,subbandfreq] = beamformer(rx);
%%
% Plot the real part of the original and beamformed signals.
plot(t(1:300),real(rx(1:300,6)),'r:',t(1:300),real(y(1:300)))
xlabel('Time')
ylabel('Amplitude')
legend('Original','Beamformed')
%%
% Plot the response pattern for five frequency bands.
pattern(antenna,subbandfreq(1:5).',[-180:180],0,'PropagationSpeed',c, ...
    'CoordinateSystem','rectangular','Weights',w(:,1:5))
legend('location','SouthEast')














