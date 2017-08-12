%% Narrowband signal 2kHz
fs = 48000;
t = 0:1/fs:5;
y = sin(2*pi*t*2000);
sound(y, fs);

%% Narrowband signal 3kHz
fs = 48000;
t = 0:1/fs:5;
y = sin(2*pi*t*3000);
sound(y, fs);



%% Stepping from 1-3 kHz
fs = 48000;
t = 0:1/fs:0.1;
y = [sin(2*pi*t*1000) sin(2*pi*t*2000) sin(2*pi*t*3000)];
sound(y, fs);


%% combined 1,2,3 kHz
fs = 48000;
t = 0:1/fs:5;
y = sin(2*pi*t*1000) + sin(2*pi*t*2000) + sin(2*pi*t*3000);
sound(y, fs);



%% Chirp signal over 2 seconds from 1kHz to 3kHz
fs = 48000;
t = 0:1/fs:2;
y = chirp(t,1000, 2, 3000);

win_len = 16000;
hwin = hanning(win_len);
wind = [hwin(1:win_len/2);ones(length(y) - win_len, 1);hwin(win_len/2 + 1:end)];
sound(wind'.*y, 48000);
plot(abs(fft(wind'.*y)))

