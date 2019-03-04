function moler_3_09
k=5;
hold on
bar_x=-1:10^-3:1;
bar_y=bar_x;
for n=50:50:500
    poly_x = cos(pi*(2*(1:n)-1)/(2*(n-1)));
    poly_y = rungerat(x);
    for m=-1:10^-3:1
    end
end
hold off

function y = rungerat(x)
y = 1./(1+25*x.^2);