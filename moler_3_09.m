function moler_3_09
k=4;
hold on
set(gca, 'YScale', 'log')
bar_x=-1:10^-k:1;
bar_y=bar_x;
for n=3:1000:5003
    vgrey=[1-n/5003 1-n/5003 1-n/5003];
    poly_x = -1 + 2*(0:n-1)/(n-1);
    poly_y = rungerat(poly_x);
    poly_values = polyinterp(poly_x,poly_y,bar_x);
    for m=1:size(bar_x')
        bar_y(m)= abs(poly_values(m)-rungerat(bar_x(m)));
    end
    bar(bar_x,bar_y,'FaceColor',vgrey);
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
