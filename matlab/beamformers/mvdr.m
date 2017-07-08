sULA = phased.ULA('NumElements',16,'ElementSpacing',0.0425);
fs = 2e3;
carrierFreq = 4000;
t = (0:1/fs:2)';
sig = chirp(t,0,2,fs/2);
c = 340;
sCol = phased.WidebandCollector('Sensor',sULA,'PropagationSpeed',c,...
    'SampleRate',fs,'ModulatedInput',true,...
    'CarrierFrequency',carrierFreq);
incidentAngle = [10;0];
sig1 = step(sCol,sig,incidentAngle);
noise = 0.3*(randn(size(sig1)) + 1j*randn(size(sig1)));
rx = sig1 + noise;

sMVDR = phased.SubbandMVDRBeamformer('SensorArray',sULA,...
    'Direction',incidentAngle,'OperatingFrequency',carrierFreq,...
    'PropagationSpeed',c,'SampleRate',fs,'TrainingInputPort',true, ...
    'SubbandsOutputPort',true,'WeightsOutputPort',true);
[y,w,subbandfreq] = step(sMVDR, rx, noise);

clean = real(rx(1:300,6) - real(noise(1:300, 6)));
outputnoise = (real(rx(1:300,6) - real(y(1:300))));
inputnoise = real(noise(1:300, 6));

plot(outputnoise);
hold on
plot(inputnoise);
figure

plot(t(1:300),real(rx(1:300,6)),'r:',t(1:300),real(y(1:300))/5, t(1:300), clean);
xlabel('Time')
ylabel('Amplitude')
legend('Original','Beamformed');


figure
pattern(sULA,subbandfreq(1:5).',-180:180,0,...
    'PropagationSpeed',c,'Weights',w(:,1:5));