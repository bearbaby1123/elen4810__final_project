function yb=wah(x,fs)
x=x';
damp=0.05;
minf=500;
maxf=3000;
Fw=2000;
delta=Fw/fs;
Fc=minf:delta:maxf;
while(length(Fc) < length(x))
    Fc=[Fc (maxf:-delta:minf) ];
    Fc=[Fc (maxf:-delta:minf) ];
end
Fc=Fc(1:length(x));
F1=2*sin((pi*Fc(1))/fs);
Q1=2*damp;
yh=zeros(size(x));
yb=zeros(size(x));
yl=zeros(size(x));
yh(1)=x(1);
yb(1)=F1*yh(1);
yl(1)=F1*yb(1);
for n=2:length(x)
    yh(n)=x(n)-yl(n-1)-Q1*yb(n-1);
    yb(n)=F1*yh(n)+yb(n-1);
    yl(n)=F1*yb(n)+yl(n-1);
    F1=2*sin((pi*Fc(n))/fs);
end
maxyb=max(abs(yb));
yb=yh/maxyb;
yb=yb';
end