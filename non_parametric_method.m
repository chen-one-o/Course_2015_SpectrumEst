%% 语音信号谱估计 非参数化方法
clc,clear,close all;

%% 读取语音信号
ReadAudio = audioread('Test.m4a');
InputSignal = ReadAudio;
SignalLength = length(InputSignal);
InputSignal = InputSignal - mean(InputSignal);% 零均值处理

%% 周期图法
WindowCoeff1 = hamming(SignalLength);
PSD_Per = periodogramse(InputSignal,WindowCoeff1,SignalLength);

%% 改进周期图法（Bartlett）
PSD_Bart = bartlettse(InputSignal,1024,1024);

%% 平均修正周期图法（Welch）
WindowCoeff2 = hamming(1024);
PSD_Wel = welchse(InputSignal,WindowCoeff2,512,1024);

%% 绘图
t14 = linspace(0,1,SignalLength);
t23 = linspace(0,1,1024); %归一化频率

figure(1)
plot(t14,10*log10(PSD_Per));
axis tight;grid on
xlabel('归一化频率'),ylabel('功率谱密度(dB)');
title('周期图法（Periodogram）');

figure(2)
plot(t23,10*log10(PSD_Bart));
axis tight;grid on
xlabel('归一化频率'),ylabel('功率谱密度(dB)');
title('改进周期图法（Bartlett）');

figure(3)
plot(t23,10*log10(PSD_Wel));
axis tight;grid on
xlabel('归一化频率'),ylabel('功率谱密度(dB)');
title('平均修正周期图法（Welch）');
