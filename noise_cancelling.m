clear;
clc;

[x,fs] = audioread('Knock1.m4a'); % Read the file and 
fn=fs/2;
l=length(x);
x_cut=x(120000:length(x)-120000); %Cut front part and end part

x_bp=bandpass(x_cut,[370 1100],fs);
%Use bandpass filter directly
%The selected frequency are based the frequency of the key we played

%Set up parameter for cheby filter and butterworth filter
Wp1=350/fn;  %pass band 1
Wp2=1200/fn;  %pass band 2
Ws1=320/fn;  %stop band 1
Ws2=1220/fn;  %stop band 2
Rp=1;   %Ripple in pass band
Rs=2;   %Ripple in stop band 
Rp2=1;   % Ripple of stop band especially for cheby2 filter
Rs2=20;  % Ripple of stop band especially for cheby2 filter

%Cheby1 filter design
[n1,Wsc1] = cheb1ord([Wp1,Wp2],[Ws1,Ws2],Rp,Rs);  
%Get the order and passband corner frequency needed for building filter
[z1,p1,k1]=cheby1(n1,Rs,Wsc1);
%calculate zeros, poles and gain of the filter
[sos1,g1]=zp2sos(z1,p1,k1);
%Convert zero-pole-gain filter parameters to second-order sections form
sos1p = zp2sos(z1,p1,k1);
%fvtool(sos1p,'Analysis','freq');
%draw the picture of mag vs frequency 
x_chev1 = filtfilt(sos1,g1,x_cut);
%use filter to process data

%Cheby2 filter design
[n2,Wsc2] = cheb2ord([Wp1,Wp2],[Ws1,Ws2],Rp2,Rs2); 
%Get the order and passband corner frequency needed for building filter
[z2,p2,k2]=cheby2(n2,Rs2,Wsc2);
%calculate zeros, poles and gain of the filter
[sos2,g2]=zp2sos(z2,p2,k2);
sos2p = zp2sos(z2,p2,k2);
%fvtool(sos2p,'Analysis','freq');
%Convert zero-pole-gain filter parameters to second-order sections form
x_chev2 = filtfilt(sos2,g2,x_cut);
%use filter to process data

%butterworth filter design
[nb,Wscb] = buttord([Wp1,Wp2],[Ws1,Ws2],Rp,Rs); 
%Get the order and passband corner frequency needed for building filter
[zb,pb,kb]=butter(nb,Wscb);
%calculate zeros, poles and gain of the filter
[sosb,gb]=zp2sos(zb,pb,kb);
%Convert zero-pole-gain filter parameters to second-order sections form
sosbp = zp2sos(zb,pb,kb);
%fvtool(sosbp,'Analysis','freq')
%draw the picture of mag vs frequency 
x_butt1 = filtfilt(sosb,gb,x_cut);
%use filter to process data
%y = fuzz(x_butt1,fs)
%sound(y,fs)

% subplot(3,2,1);
spectrogram(x_bp,'yaxis')
ylim([0 0.2])
%xlim([0 0.2])%plot STFT result of cutted data
% subplot(3,2,2);
%plot(x_cut)
% subplot(3,2,3);
%plot(x_bp)

% spectrogram(x_chev1);  %plot STFT result of data filtered by chev1
% %sound(x_chev1,fs);
% subplot(3,2,4);
% spectrogram(x_chev2);  %plot STFT result of data filtered by chev2
% subplot(3,2,5);
%spectrogram(x_bp);
%xlim([0 0.2])
% %fvtool(sos2p,'Analysis','freq')
% subplot(3,2,6);
% spectrogram(x_butt1);  %plot STFT result of data filtered by chev2
% sound(x_bp,fs);









