n_elements = 16;

array = phased.ULA('NumElements',n_elements,'ElementSpacing',0.0425);
array.Element.FrequencyRange = [20 20000];
fs = 8e3;
t = 0:1/fs:1;
x = chirp(t,0,1,2000);
c = 340;
collector = phased.WidebandCollector('Sensor',array,...
    'PropagationSpeed',c,'SampleRate',fs,...
    'ModulatedInput',false,'NumSubbands',8192);
incidentAngle = [20;0];
x = collector(x.',incidentAngle);
noise = 0.8*randn(size(x));
rx = x + noise;

beamformer = phased.FrostBeamformer('SensorArray',array,...
    'PropagationSpeed',c,'SampleRate',fs,...
    'Direction',incidentAngle,'FilterLength',10, 'WeightsOutputPort', true);
[y, w] = beamformer(rx);

sum(x(:,n_elements/2).^2)/(sum((rx(:,n_elements/2) - x(:,n_elements/2)).^2))
sum(x(:,n_elements/2).^2)/(sum((y - x(:,n_elements/2)).^2))

r = 1000:1200;
plot(t(r),rx(r,n_elements/2),'r--',t(r),y(r),  t(r), x(r, n_elements/2), 'go')
xlabel('Time')
ylabel('Amplitude')
xlim([0.125 0.15])
legend('Original','Beamformed', 'Clean')

w = reshape(w, 10, 10);
pattern(array,centerfreqs(idx).',[-90:90],0,'Weights',w(:,idx),'CoordinateSystem','rectangular',...
    'PlotStyle','overlay','Type','powerdb','PropagationSpeed',c)
legend('Location','South')