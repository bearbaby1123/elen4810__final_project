
function y2=overdrive(x)
x = x';

N=length(x);
y=zeros(1,N);

th=1/3;
y_1 = 2*x.*(x<th);
y_2 = ((3-(2-abs(x)*3).^2)/3).*(x>=th).*(x<=2*th);
y_3 = (x>2*th);

y2=(y_1+y_2+y_3)';
end