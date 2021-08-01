%%
%--------------------------------------------------------------------------
% Matlab code investigating the effects of quatization on the frequency 
% spectrum of signals
%--------------------------------------------------------------------------

%% SIGNAL DEFINITION
%all sinusoids have magnitude 1

%sampling rate
fs = 100000;
%sampling preiod
T = 1/fs;
%run time
t = (1:T:1.0025)-1;

%signal frequencies
LF_hz = 1000;
IF_hz = 10000;
HF_hz = 20000;

%signal generation
LF = cos(2*pi*LF_hz.*t);
IF = cos(2*pi*IF_hz.*t);
HF = cos(2*pi*HF_hz.*t);

%% PLOTTING TIME
%plotting generated functions
%convertin time to milli seconds
t_ms = t*1000;

figure

subplot(2,3,1)
plot(t_ms,LF)
xlabel("Time(ms)")
ylabel("Amplitude(V)")
title("TIME DOMAIN 1KHz SINUSOID")

subplot(2,3,2)
plot(t_ms,IF)
xlabel("Time(ms)")
ylabel("Amplitude(V)")
title("TIME DOMAIN 5KHz SINUSOID")

subplot(2,3,3)
plot(t_ms,HF)
xlabel("Time(ms)")
ylabel("Amplitude(V)")
title("TIME DOMAIN 10KHz SINUSOID")

%% FFT OF UN-ADC'ED SIGNAL

%zero padding to increase f_res
pad_factor = 5;
LF_p = [LF zeros(1,length(LF)*pad_factor)];
IF_p = [IF zeros(1,length(IF)*pad_factor)];
HF_p = [HF zeros(1,length(HF)*pad_factor)];

%taking fourier transform
LF_W = fftshift(fft(LF_p));
IF_W = fftshift(fft(IF_p));
HF_W = fftshift(fft(HF_p));

%frequency axis
f_res = 1/(length(LF_W)*T);
f = 0:f_res:(length(LF_W)-1)*f_res;
%shifting to center arround zero
f = f - f((length(f))/2);
%rescaling to KHz
f_khz = f/1000;

%% PLOTTING FREQUENCY
subplot(2,3,4)
plot(f_khz,abs(LF_W))
xlabel("frequency(Khz)")
ylabel("Amplitude(V)")
title("FFT OF 1KHz SINUSOID")

subplot(2,3,5)
plot(f_khz,abs(IF_W))
xlabel("frequency(Khz)")
ylabel("Amplitude(V)")
title("FFT OF 5KHz SINUSOID")

subplot(2,3,6)
plot(f_khz,abs(HF_W))
xlabel("frequency(Khz)")
ylabel("Amplitude(V)")
title("FFT OF 10KHz SINUSOID")

%% Question 1.1 - 1.2

pad_factor = 5;

%----------------------------------------------
%One signal using a *1* bit A/D converter: 5KHz
%----------------------------------------------
bits = 1;
amplitude = 1;
IF_1b = IF;

%time domain
IF_1b= adc_sample(bits,amplitude,IF_1b);
%frequency domain
IF_1b_p = [IF_1b zeros(1,length(IF_1b)*pad_factor)];
IF_1b_w = fftshift(fft(IF_1b_p));


%----------------------------------------------
%One signal using a *5* bit A/D converter: 5KHz
%----------------------------------------------
bits = 5;
amplitude = 1;
IF_5b = IF;

%time domain
IF_5b = adc_sample(bits,amplitude,IF_5b);
%frequency domain
IF_5b_p = [IF_5b zeros(1,length(IF_5b)*pad_factor)];
IF_5b_w = fftshift(fft(IF_5b_p));

%----------------------------------------------
%plotting
%----------------------------------------------

%frequency axos
f_res = 1/(length(IF_1b)*T);
f = 0:f_res:(length(IF_1b_w)-1)*f_res;
%shifting to center arround zero
f = f - f((length(f))/2);
%rescaling to KHz
f_khz = f/1000;

figure
subplot(2,2,1)
plot(t,IF_1b)
xlabel("Time(ms)")
ylabel("Amplitude(V)")
title("TIME DOMAIN 5KHz SINUSOID - 1 BIT ADC")

subplot(2,2,2)
plot(t,IF_5b)
xlabel("Time(ms)")
ylabel("Amplitude(V)")
title("TIME DOMAIN 5KHz SINUSOID - 5 BIT ADC")

subplot(2,2,3)
plot(f,abs(IF_1b_w))

subplot(2,2,4)
plot(f,abs(IF_5b_w))












