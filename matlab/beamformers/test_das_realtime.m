% Repeat with a sin wave propagating from 45 degrees
N = csvread('speech_45.csv');
N = (N - mean(N));
N = N./max(N);
N = resample(N, 1, 3);
fs = 16000;
block_size = 1024;


formed = [];

for i = 1:181
    beamformers{i} = DelayAndSum(0.0425, 2000, 16, fs, 45, 340, block_size);
    
end
energy = zeros(1, 181);

max_energies = [];
angles = [];

tic
for i = 0:floor(length(N(:, 1))/block_size) - 1
    current_block = N(i*block_size + 1: (i + 1)*(block_size), :);
    j = 45;
    %for j = -90:90
        output = beamformers{1}.process(current_block);
        % Save the energy of the output
        energy(j + 91) = sum(output.^2);
        formed = [formed;output];
    %end
    
    plot(-90:90, (energy))
    xlabel('steered angle')
    ylabel('energy')
    title('2 Khz sin tone at ~45 degrees')
    [maxval, idx] = max(energy);
    hold on
    scatter(idx - 91, maxval)
    lab = string(idx - 91);
    text(idx - 87, maxval, char(lab) , 'Color', 'black');
    idx - 91
    ylim([0 70000])
    hold off
    drawnow limitrate;
    angles = [angles idx - 91];
    max_energies = [max_energies maxval];
end
toc

plot(50*max_energies/max(max_energies));
hold on
plot(angles);

