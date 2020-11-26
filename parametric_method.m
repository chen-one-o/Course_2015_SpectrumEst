%% �����ź��׹��� ����������
clc,clear,close all;

%% ��ȡ�����ź�
ReadAudio = audioread('Test.m4a');
InputSignal = ReadAudio;
SignalLength = length(InputSignal);
InputSignal = InputSignal - mean(InputSignal);% ���ֵ����

%% Yule-Walker������ARģ��ϵ������
[a1,~] = yulewalker(InputSignal,20);
PSD_YWAR = argamse(1,a1,1024);

%% ��С���˷���ARģ��ϵ������
[a2,~] = lsar(InputSignal,20);
PSD_LSAR = argamse(1,a2,1024);

%% Capon�׹��Ʒ��������Ƿǲ������׹��Ʒ���������
PSD_Capon = capon(InputSignal,20,SignalLength);

%% ��ͼ
t3 = linspace(0,1,SignalLength);
t12 = linspace(0,1,1024); %��һ��Ƶ��

figure(1)
plot(t12,10*log10(PSD_YWAR));
axis tight;grid on
xlabel('��һ��Ƶ��'),ylabel('�������ܶ�(dB)');
title('Yule-Walker������ARģ��ϵ������');

figure(2)
plot(t12,10*log10(PSD_LSAR));
axis tight;grid on
xlabel('��һ��Ƶ��'),ylabel('�������ܶ�(dB)');
title('��С���˷���ARģ��ϵ������');

figure(3)
plot(t3,10*log10(PSD_Capon));
axis tight;grid on
xlabel('��һ��Ƶ��'),ylabel('�������ܶ�(dB)');
title('Capon�׹��Ʒ���');
