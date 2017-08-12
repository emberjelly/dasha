N = csvread('speech_45.csv');
N = (N - mean(N));
N = N./max(N);
sound(N(:, 7), 48000)

section = N(300000:301000,:);
for s = N
    figure
    plot(s)
end
 
plot(section)


figure
plot(sum(abs(fft2(section, 100, 500)).^2))




plot(output)

% mesh, contour

if 0

figure
pnum = 1;
for channel=N
   subplot(16, 1, pnum)
   plot(channel(200000:200040))
   pnum = pnum+1;
   
   [peaks, locs] = findpeaks(channel(200000:200040));
   
   hold on
   stem(locs, peaks)
   hold off
   
end
end





start_index = 200000;
end_index = 210000;

actual = N(:, 7);
n = 1:length(actual(start_index:end_index));
w = 2*pi*2000/48000;
dft_bin = sum(actual(start_index:end_index).*exp(-1i*w*n)');
actual_phase = angle(dft_bin);
upsample_factor = 1;

corrected_data = zeros(size(N));


count = 1;
for c = N

    %if count == 7
    %    corrected_data(:, count) = actual;
    %    count = count + 1;
    %    continue
    %end

    
    n = 1:length(c(start_index:end_index));
    w = 2*pi*2000/48000;
    dft_bin = sum(c(start_index:end_index).*exp(-1i*w*n)')
    phase = angle(dft_bin)
    
    time_diff = (phase - actual_phase)/(2*pi*2000);
    sample_delay = time_diff*48000;
   
    
    b = sinc((-1000:1000) + sample_delay);
    corrected = filter(b, 1, c);

    corrected_ = resample(corrected, upsample_factor, 1);
    actual_ = resample(actual, upsample_factor, 1);


    figure
    plot(actual_(upsample_factor*200000:upsample_factor*200040)/max(actual_(upsample_factor*200000:upsample_factor*200040)))
    hold on
    plot(corrected_(upsample_factor*200000:upsample_factor*200040)/max(corrected_(upsample_factor*200000:upsample_factor*200040)))
    legend('actual', 'corrected')
    
    corrected_data(:, count) = corrected;
    count = count + 1;
end



figure
pnum = 1;
for channel=corrected_data
   subplot(16, 1, pnum)
   plot(channel(200000:200040))
   pnum = pnum+1;
   
   [peaks, locs] = findpeaks(channel(200000:200040));
   
   hold on
   stem(locs, peaks)
   hold off
   
end


figure
for c = corrected_data
    c_ = c(200040:200080)/max(c(200040:200080));
    plot(c_)
    hold on
end

n = 1:480000;

x = sin(2*pi*n*2000/48000);

sound(x, 48000)
