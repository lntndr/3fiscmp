function moler_3_09
k=4;
hold on
set(gca, 'YScale', 'log')
bar_x=-1:0.25*10^-k:1;
bar_y=bar_x;
n_max=10000;
if mod(n_max,2)==0
    n_max=n_max-1;
end
for n=3:1000:n_max
    vgrey=[1-n/5003 1-n/5003 1-n/5003];
    poly_x = -1 + 2*(0:n-1)/(n-1);
    poly_y = rungerat(poly_x);
    poly_values = polyinterp(poly_x,poly_y,bar_x);
    for m=1:size(bar_x')
        bar_y(m)= abs(poly_values(m)-rungerat(bar_x(m)));
    end
    filter= bar_y < 10; %blocca il grafico di valori superiori a 10
    bar(bar_x,bar_y.*filter,1,'FaceColor',colorpicker(n,n_max));
end
hold off

function y = rungerat(x)
y = 1./(1+25*x.^2);

function v = polyinterp(x,y,u)
%POLYINTERP  Polynomial interpolation.
%   v = POLYINTERP(x,y,u) computes v(j) = P(u(j)) where P is the
%   polynomial of degree d = length(x)-1 with P(x(i)) = y(i).

%   Copyright 2014 Cleve Moler
%   Copyright 2014 The MathWorks, Inc.

% Use Lagrangian representation.
% Evaluate at all elements of u simultaneously.

n = length(x);
v = zeros(size(u));
for k = 1:n
   w = ones(size(u));
   for j = [1:k-1 k+1:n]
      w = (u-x(j))./(x(k)-x(j)).*w;
   end
   v = v + w*y(k);
end

function c=colorpicker(n,n_max)
    c(1)=1-(n/n_max);
    c(2)=1-(n/n_max);
    c(3)=0.9-0.6*(n/n_max);
return
