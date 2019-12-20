function y = shelving_first(x, G, fc, fs, type)
K = tan((pi * fc)/fs);
V0 = 10 ^ (G / 20);

%Invert gain if a cut
if(V0 < 1)
    V0 = 1/V0;
end

H0 = V0 - 1;
a_b = K - 1 / (K + 1);
a_c = K - V0 / (K + V0);
y1 = zeros(size(x));
y = zeros(size(x));

if strcmp(type,'Base_Shelf')
    sign = 1;
elseif strcmp(type, 'Treble_Shelf')
    sign = -1;
end

if G > 0
    a = a_b;
elseif G < 0
    a = a_c;
end

for n = 1:length(x)
    if n == 1
        y1(n) = a * x(n);
    else
        y1(n) = a * x(n) + x(n - 1) - a * y1(n - 1);
    end
    y(n) = H0 / 2 * (x(n) + sign * y1(n)) + x(n);
end
end
