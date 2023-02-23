%% 非线性调频
f0 = 2.09e9;
B1 = 0.6e9; %带宽

fs1= 12e9;  %采样频率 
Ts=1/fs1; %采样间隔

T = 0.0001;   %调制时间100us

num = round(T / Ts); %周期采样点数

k = B1 / T;  %斜率
t1 = (0:num-1) / fs1; %时间序列


lfm_1 = exp(1j *2 * pi * (f0 * t1 + 10*cos(2*pi*t1*1e4*1000)));
hf = lfm_1;
figure()
plot(abs(fft((lfm_1))))