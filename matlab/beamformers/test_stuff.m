%% ULA summation
omega = 0:pi/1000:4*pi;

M = 8;
theta = pi/2;
tau = 1; ((0.16)/340)*sin(theta);
H = exp(j*(0.5*(M - 1)*omega*tau)).*sin(0.5*M*omega*tau)./(M*sin(omega*tau/2));

figure
subplot(1, 2, 1)
plot(omega, abs(H))
xlabel('omega')
ylabel('magnitude')
xlim([0 4*pi])
title('ULA response for M = 8')

M = 16;
theta = pi/2;
tau = 1; ((0.16)/340)*sin(theta);
H = exp(j*(0.5*(M - 1)*omega*tau)).*sin(0.5*M*omega*tau)./(M*sin(omega*tau/2));


subplot(1, 2, 2)
plot(omega, abs(H))
xlabel('omega')
ylabel('magnitude')
xlim([0 4*pi])
title('ULA response for M = 16')

%% ULA Delay and Sum

omega = -pi:2*pi/10000:pi;

M = 8;
N = 1:M;
d = 0.17;
result = zeros(1, 10000)
for i = 1:10001
    result(i) = sum(exp(2*2000*N*1i*d*omega(i)/340))/M;
end



M = 16;
N = 1:M;
d = 0.17;
result2 = zeros(1, 10000)
for i = 1:10001
    result2(i) = sum(exp(2*2000*N*1i*d*omega(i)/340))/M;
end

figure
subplot(1, 2, 1)
plot(omega, abs(result))
xlabel('omega')
ylabel('magnitude')
xlim([-pi pi])
title('ULA response for M = 8')
subplot(1, 2, 2)
plot(omega, abs(result2))
xlabel('omega')
ylabel('magnitude')
xlim([-pi pi])
title('ULA response for M = 16')


%% ULA delay and sum shift

N = 16;
theta_t = pi/2;
theta = pi/2:pi/10000:2*pi + pi/2;

lamda = 340/3000;
d = lamda/2;
B = (1/N)*(sin(pi*N*d/lamda*(cos(theta) - cos(theta_t))))./sin(pi*d/lamda*(cos(theta) - cos(theta_t)));
min(log((abs(B))))

log_data = 10*log((abs(B)));
log_data(log_data<-50) = -50;

figure(1)
subplot(2,2,1)
polarplot(theta + pi/2,log_data)
rlim([min(log_data) 0])
title('ULA with no steering')


N = 16;
theta_t = pi/3;
theta = pi/2:pi/10000:2*pi + pi/2;

lamda = 340/3000;
d = lamda/2;
B = (1/N)*(sin(pi*N*d/lamda*(cos(theta) - cos(theta_t))))./sin(pi*d/lamda*(cos(theta) - cos(theta_t)));
min(log((abs(B))))

log_data = 10*log((abs(B)));
log_data(log_data<-50) = -50;

figure(1)
subplot(2,2,2)
polarplot(theta + pi/2,log_data)
rlim([min(log_data) 0])
title('ULA Steered to 30^{\circ}')


N = 16;
theta_t = pi/6;
theta = pi/2:pi/10000:2*pi + pi/2;

lamda = 340/3000;
d = lamda/2;
B = (1/N)*(sin(pi*N*d/lamda*(cos(theta) - cos(theta_t))))./sin(pi*d/lamda*(cos(theta) - cos(theta_t)));
min(log((abs(B))))

log_data = 10*log((abs(B)));
log_data(log_data<-50) = -50;

subplot(2,2,3)
polarplot(theta + pi/2,log_data)
rlim([min(log_data) 0])
title('ULA Steered to 60^{\circ}')

N = 16;
theta_t = 0;
theta = pi/2:pi/10000:2*pi + pi/2;

lamda = 340/3000;
d = lamda/2;
B = (1/N)*(sin(pi*N*d/lamda*(cos(theta) - cos(theta_t))))./sin(pi*d/lamda*(cos(theta) - cos(theta_t)));
min(log((abs(B))))

log_data = 10*log((abs(B)));
log_data(log_data<-50) = -50;

subplot(2,2,4)
polarplot(theta + pi/2,log_data)
rlim([min(log_data) 0])
title('ULA Steered to 90^{\circ}')
