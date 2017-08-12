function [ ph ] = correct_phase( input_args )

    start_index = 200000;
    end_index = 210000;
    actual = N(:, 7);
    actual =[0;0;0;0;0;0;actual(1:end-6)];
    w = 2*pi*2000/48000;
    dft_bin = sum(actual(start_index:end_index).*exp(-1i*w*n)');
    actual_phase = angle(dft_bin);


    corrected_data = zeros(size(N));


    count = 1;
    for c = N

        if count == 7
            corrected_data(:, count) = actual;
            count = count + 1;
            continue
        end


        n = 1:length(c(start_index:end_index));
        w = 2*pi*2000/48000;
        dft_bin = sum(c(start_index:end_index).*exp(-1i*w*n)')
        phase = angle(dft_bin)

        time_diff = (phase - actual_phase)/(2*pi*2000);
        sample_delay = time_diff*48000;


        b = sinc((0:1000) + sample_delay);
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

end

