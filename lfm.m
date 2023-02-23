
clc;
close all;
clear;

f0 = 9.6e9;
B = 0.8e9; 

fs= 40e9;  %采样频率 
Ts = 1 / fs; %采样间隔
n = 10;
m = 20;
num = n * m;
% t = (0 : num - 1) * Ts; %时间序列
T = Ts * 400 * m;%脉宽
t1 = linspace(0,T - Ts,400 * m);
t2 = linspace(0,(T - Ts)/2,200 * m);
c=3e8;
ra=300;
rb=600;
ta=2*ra/c;
tb=2*rb/c;
k = B / T;  %斜率
lfm_1 = exp(1j * 2 * pi * (f0 * t1 + 0.5 * k * t1 .^ 2));
lfm_2= exp(1j * 2 * pi * (f0 * t1 + 8e8*t1 - 0.5 * k * t1 .^ 2));
lfm_3= exp(1j * 2 * pi * (f0 * (t1-ta) + 0.5 * k * (t1-ta) .^ 2)) +exp(1j * 2 * pi * (f0 * (t1-tb) + 0.5 * k * (t1-tb) .^ 2))        ;

% lfm_3= exp(1j * 2 * pi * (f0 * t1 + 2 * k * t1 .^ 2));
% lfm_4= exp(1j * 2 * pi * (f0 * t1 + 8 * k * t1 .^ 2));
lfm_7= [exp(1j * 2 * pi * (f0 * t2 + 1 * k * t2 .^ 2)),exp(1j * 2 * pi * (f0 * t2 + 1 * k * t2 .^ 2)) ];
lfm_8= exp(1j * 2 * pi * (f0 * t1 + 0.5 * k * t1 .^ 2)+1j*pi);

lfm11=[lfm_1 lfm_1 lfm_1 lfm_1 lfm_1 lfm_1 lfm_1 lfm_1];
lfm22=[lfm_2 lfm_1];
lfm12=[lfm_1 lfm_8 lfm_1 lfm_8 lfm_1 lfm_8 lfm_1 lfm_8];
lfm21=[lfm_1 lfm_2];
lfm13=[lfm_1 lfm_1 lfm_8 lfm_8 lfm_1 lfm_1 lfm_8 lfm_8];
a1=fft((lfm11));
a2=fft(lfm12);
% a=((a1));
% b=(fft(a2));
Q=(a1.*conj(a2));
figure;
plot(abs(a1));
figure;
plot(abs(a2));
figure;
plot(20*log10(abs((ifft(Q)))));
% figure;
% plot(abs(fftshift(ifft(a.*a))));
window = 1024;
overLap = 512;
nfft = 5000;

 figure("name",'STFT_lfm_r2','NumberTitle','off');
 spectrogram(lfm12,window,overLap,nfft,fs);  