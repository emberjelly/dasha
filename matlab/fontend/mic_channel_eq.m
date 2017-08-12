function [b] = mic_channel_eq(impulse_response, avg_impulse_response, ord)

    x = avg_impulse_response;
    y = impulse_response;
    ryy = xcorr(y);
    rxy = xcorr(x, y);
    ryy = ryy((length(ryy) - 1)/2 + 1:(length(ryy) - 1)/2 + ord);
    rxy = rxy((length(rxy) - 1)/2 + 1:(length(rxy) - 1)/2 + ord);
    ryy = toeplitz(ryy);
    b = inv(ryy)*rxy;

end