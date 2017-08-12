rng('shuffle')  % Seed RNG


b_channel = [0.4 0.22 0.37 0.17 0.03 0.0 0.01]; % A random filter

desired_response = rand(42000, 1) - 0.5; % This would ideally be the impulse resposne of the speakers?
% Or maybe just the measurements from the first mic?

noise = filter(b_channel, 1, desired_response);

plot(abs(fft(noise)))

b = mic_channel_eq(noise, desired_response, 20);

plot(abs(fft(filter(b, 1, [1 zeros(1, 9999)]))))
hold on
plot(1./(abs(fft(filter(b_channel, 1, [1 zeros(1, 9999)])))))
