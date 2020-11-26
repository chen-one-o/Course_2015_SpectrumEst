%% �����ź��׹��� �ǲ���������
clc,clear,close all;

%% ��ȡ�����ź�
ReadAudio = audioread('Test.m4a');
InputSignal = ReadAudio;
SignalLength = length(InputSignal);
InputSignal = InputSignal - mean(InputSignal);% ���ֵ����

%% ����ͼ��
WindowCoeff1 = hamming(SignalLength);
PSD_Per = periodogramse(InputSignal,WindowCoeff1,SignalLength);

%% �Ľ�����ͼ����Bartlett��
PSD_Bart = bartlettse(InputSignal,1024,1024);

%% ƽ����������ͼ����Welch��
WindowCoeff2 = hamming(1024);
PSD_Wel = welchse(InputSignal,WindowCoeff2,512,1024);

%% ��ͼ
t14 = linspace(0,1,SignalLength);
t23 = linspace(0,1,1024); %��һ��Ƶ��

figure(1)
plot(t14,10*log10(PSD_Per));
axis tight;grid on
xlabel('��һ��Ƶ��'),ylabel('�������ܶ�(dB)');
title('����ͼ����Periodogram��');

figure(2)
plot(t23,10*log10(PSD_Bart));
axis tight;grid on
xlabel('��һ��Ƶ��'),ylabel('�������ܶ�(dB)');
title('�Ľ�����ͼ����Bartlett��');

figure(3)
plot(t23,10*log10(PSD_Wel));
axis tight;grid on
xlabel('��һ��Ƶ��'),ylabel('�������ܶ�(dB)');
title('ƽ����������ͼ����Welch��');
