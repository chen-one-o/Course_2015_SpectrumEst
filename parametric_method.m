%% 语音信号谱估计 参数化方法
clc,clear,close all;

%% 读取语音信号
ReadAudio = audioread('Test.m4a');
InputSignal = ReadAudio;
SignalLength = length(InputSignal);
InputSignal = InputSignal - mean(InputSignal);% 零均值处理

%% Yule-Walker方程求AR模型系数向量
[a1,~] = yulewalker(InputSignal,20);
PSD_YWAR = argamse(1,a1,1024);

%% 最小二乘法求AR模型系数向量
[a2,~] = lsar(InputSignal,20);
PSD_LSAR = argamse(1,a2,1024);

%% Capon谱估计方法（这是非参数法谱估计方法！！）
PSD_Capon = capon(InputSignal,20,SignalLength);

%% 绘图
t3 = linspace(0,1,SignalLength);
t12 = linspace(0,1,1024); %归一化频率

figure(1)
plot(t12,10*log10(PSD_YWAR));
axis tight;grid on
xlabel('归一化频率'),ylabel('功率谱密度(dB)');
title('Yule-Walker方程求AR模型系数向量');

figure(2)
plot(t12,10*log10(PSD_LSAR));
axis tight;grid on
xlabel('归一化频率'),ylabel('功率谱密度(dB)');
title('最小二乘法求AR模型系数向量');

figure(3)
plot(t3,10*log10(PSD_Capon));
axis tight;grid on
xlabel('归一化频率'),ylabel('功率谱密度(dB)');
title('Capon谱估计方法');
