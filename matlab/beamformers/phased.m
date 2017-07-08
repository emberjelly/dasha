%% Simulate a narrowband beamformer on a wideband signal
c = 340;
ff = [2500 3000 3500 4000];
array = phased.ULA('NumElements',16, 'ElementSpacing', 0.0425);
steervec = phased.SteeringVector('SensorArray',array, 'PropagationSpeed', c);
sv = steervec(4000,[30; 0]);
plotResponse(array, ff, c,'RespCut','Az','Weights',sv)
xlim([-90 90])
title('Effect of steering on a narrowband beamformer')

%% Simulate a wideband beamformer on a wideband signal

c = 340;
freq = [2000 4500];
fc = 4000;
numels = 16;

array = phased.ULA('NumElements',numels,...
   'ElementSpacing',0.5*c/fc);

plotFreq = linspace(min(freq),max(freq),15);

%pattern(array,plotFreq,[-180:180],0,'CoordinateSystem','rectangular',...
%    'PlotStyle','waterfall','Type','powerdb','PropagationSpeed',c)

direction = [0;0];
numbands = 8;
beamformer = phased.SubbandPhaseShiftBeamformer('SensorArray',array,...
   'Direction',direction,...
   'OperatingFrequency',fc,'PropagationSpeed',c,...
   'SampleRate',4e3,...
   'WeightsOutputPort',true,'SubbandsOutputPort',true,...
   'NumSubbands',numbands);
rx = ones(numbands,numels);
[y,w,centerfreqs] = beamformer(rx);

%pattern(array,centerfreqs.',[-180:180],0,'Weights',w,'CoordinateSystem','rectangular',...
%    'PlotStyle','waterfall','Type','powerdb','PropagationSpeed',c)

centerfreqs = fftshift(centerfreqs);
w = fftshift(w,2);
idx = [2,3, 4,5];

subplot(2,2, 1)

pattern(array,centerfreqs(idx).',[-90:90],0,'Weights',w(:,idx),'CoordinateSystem','rectangular',...
    'PlotStyle','overlay','Type','powerdb','PropagationSpeed',c)
legend('Location','South')





c = 340;
freq = [2000 4500];
fc = 4000;
numels = 16;

array = phased.ULA('NumElements',numels,...
   'ElementSpacing',0.5*c/fc);

plotFreq = linspace(min(freq),max(freq),15);

%pattern(array,plotFreq,[-180:180],0,'CoordinateSystem','rectangular',...
%    'PlotStyle','waterfall','Type','powerdb','PropagationSpeed',c)

direction = [30;0];
numbands = 8;
beamformer = phased.SubbandPhaseShiftBeamformer('SensorArray',array,...
   'Direction',direction,...
   'OperatingFrequency',fc,'PropagationSpeed',c,...
   'SampleRate',4e3,...
   'WeightsOutputPort',true,'SubbandsOutputPort',true,...
   'NumSubbands',numbands);
rx = ones(numbands,numels);
[y,w,centerfreqs] = beamformer(rx);

%pattern(array,centerfreqs.',[-180:180],0,'Weights',w,'CoordinateSystem','rectangular',...
%    'PlotStyle','waterfall','Type','powerdb','PropagationSpeed',c)

centerfreqs = fftshift(centerfreqs);
w = fftshift(w,2);
idx = [2,3, 4,5];

subplot(2,2, 2)

pattern(array,centerfreqs(idx).',[-90:90],0,'Weights',w(:,idx),'CoordinateSystem','rectangular',...
    'PlotStyle','overlay','Type','powerdb','PropagationSpeed',c)
legend('Location','South')



c = 340;
freq = [2000 4500];
fc = 4000;
numels = 16;

array = phased.ULA('NumElements',numels,...
   'ElementSpacing',0.5*c/fc);

plotFreq = linspace(min(freq),max(freq),15);

%pattern(array,plotFreq,[-180:180],0,'CoordinateSystem','rectangular',...
%    'PlotStyle','waterfall','Type','powerdb','PropagationSpeed',c)

direction = [60;0];
numbands = 8;
beamformer = phased.SubbandPhaseShiftBeamformer('SensorArray',array,...
   'Direction',direction,...
   'OperatingFrequency',fc,'PropagationSpeed',c,...
   'SampleRate',4e3,...
   'WeightsOutputPort',true,'SubbandsOutputPort',true,...
   'NumSubbands',numbands);
rx = ones(numbands,numels);
[y,w,centerfreqs] = beamformer(rx);

%pattern(array,centerfreqs.',[-180:180],0,'Weights',w,'CoordinateSystem','rectangular',...
%    'PlotStyle','waterfall','Type','powerdb','PropagationSpeed',c)

centerfreqs = fftshift(centerfreqs);
w = fftshift(w,2);
idx = [2,3, 4,5];

subplot(2,2, 3)

pattern(array,centerfreqs(idx).',[-90:90],0,'Weights',w(:,idx),'CoordinateSystem','rectangular',...
    'PlotStyle','overlay','Type','powerdb','PropagationSpeed',c)
legend('Location','South')



c = 340;
freq = [2000 4500];
fc = 4000;
numels = 16;

array = phased.ULA('NumElements',numels,...
   'ElementSpacing',0.5*c/fc);

plotFreq = linspace(min(freq),max(freq),15);

%pattern(array,plotFreq,[-180:180],0,'CoordinateSystem','rectangular',...
%    'PlotStyle','waterfall','Type','powerdb','PropagationSpeed',c)

direction = [90;0];
numbands = 8;
beamformer = phased.SubbandPhaseShiftBeamformer('SensorArray',array,...
   'Direction',direction,...
   'OperatingFrequency',fc,'PropagationSpeed',c,...
   'SampleRate',4e3,...
   'WeightsOutputPort',true,'SubbandsOutputPort',true,...
   'NumSubbands',numbands);
rx = ones(numbands,numels);
[y,w,centerfreqs] = beamformer(rx);

%pattern(array,centerfreqs.',[-180:180],0,'Weights',w,'CoordinateSystem','rectangular',...
%    'PlotStyle','waterfall','Type','powerdb','PropagationSpeed',c)

centerfreqs = fftshift(centerfreqs);
w = fftshift(w,2);
idx = [2,3, 4,5];

subplot(2,2, 4)

pattern(array,centerfreqs(idx).',[-90:90],0,'Weights',w(:,idx),'CoordinateSystem','rectangular',...
    'PlotStyle','overlay','Type','powerdb','PropagationSpeed',c)
legend('Location','South')