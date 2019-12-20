%% Initialization
clear;
clc;

%% Load signal
[x,fs] = audioread('Knock1.m4a'); % Read the file and 
fn=fs/2;
l=length(x);
x_cut=x(120000:length(x)-120000); %Cut front part and end part

%% Noise Cancelling

%Set up parameter for cheby filter and butterworth filter
Wp1=350/fn;  %pass band 1
Wp2=1200/fn;  %pass band 2
Ws1=320/fn;  %stop band 1
Ws2=1220/fn;  %stop band 2
Rp=1;   %Ripple in pass band
Rs=2;   %Ripple in stop band 
Rp2=1;   % Ripple of stop band especially for cheby2 filter
Rs2=20;  % Ripple of stop band especially for cheby2 filter

%butterworth filter design
[nb,Wscb] = buttord([Wp1,Wp2],[Ws1,Ws2],Rp,Rs); 
%Get the order and passband corner frequency needed for building filter
[zb,pb,kb]=butter(nb,Wscb);
%calculate zeros, poles and gain of the filter
[sosb,gb]=zp2sos(zb,pb,kb);
%Convert zero-pole-gain filter parameters to second-order sections form
sosbp = zp2sos(zb,pb,kb);
fvtool(sosbp,'Analysis','freq')
%draw the picture of mag vs frequency 
x_butt1 = filtfilt(sosb,gb,x_cut);

%% Wah-wah
% x_wah = wah(x_butt1,fs);

%% Overdrive
x_od = overdrive(x_wah);

%% Equalizer
G = 2; fc = 700; type = 'Base_Shelf';
x_eq = shelving_first(x_od, G, fc, fs, type);

y = x_eq;














