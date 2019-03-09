function moler_3_09

%Il programma valuta l'interpretazione di Lagrange in serie di punti
%prima equidistanziati e poi secondo i nodi di Chebyshev con polinomi di
%grado crescente (3,53,103,153,203,253). La differenza tra il valore del
%polinomio e della funzione viene riprodotta tramite grafico bar()
%identificando i vari ordini con colori diversi.

k=4; 
n=50;
n_max=253;

core_3_09(k,n,n_max);

function core_3_09(k,n,n_max)
% k => passo di valutazione del polinomio = 10^-k
% n => passo di salita di grado del polinomio
% n_max => massimo grado di valutazione del polinomio

bar_x=-1:10^-k:1;
bar_y=bar_x;

if mod(n_max,2)==0
    n_max=n_max-1;
end

for t=1:2
    if t==1
        pt_dis = @eqdn;
        f_eqd = figure;
        y_eps = 200*eps;
    elseif t==2
        pt_dis = @chby;
        f_chb = figure;
        y_eps = 3*eps;
    end
    hold on
    set(gca, 'YScale', 'log')
    for s=3:n:n_max
        poly_x = pt_dis(s);
        poly_y = rungerat(poly_x);
        poly_values = polyinterp(poly_x,poly_y,bar_x);
        for m=1:size(bar_x')
            bar_y(m)= abs(poly_values(m)-rungerat(bar_x(m)));
        end
        bar(bar_x,bar_y,1,'FaceColor',colorpicker(s,n_max));
    end
    line([-1, 1], [eps, eps], 'Color', 'r', 'LineWidth', 2);
    text(0.5,y_eps,'eps','Color','red','FontSize',12)
    hold off
end

%domanda a
%   L'intervallo in cui il polinomio converge ad f(x) al crescere del grado 
%   del polinomio rimanendo comunque confinato nell'intervallo -1 e 1.
%   Osservo in particolare come avvicinandosi a -1 e 1 il polinomio diverga
%   infinto e l'intervallo di convergenza rimanga sempre contenuto in (-1,1) 


%domanda b
%   per permettere al polinomio di convergere a f(x) in tutto l'intervallo
%   [-1,1] abbiamo cambiato la distribuzione dei punti di interpolazione
%   usando i nodi di Chebyshev invece che mantenerli ugualmente
%   distanziati. Nel secondo grafico si evidenzia come al crescere del
%   grado le differenze tendano a ridursi e non superino mai il valore 1.

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

function c = colorpicker(n,n_max)
    c(1)=1-(n/n_max);
    c(2)=1-(n/n_max);
    c(3)=1/6+1/3*(n/n_max);
return

function x = eqdn(n)
x=-1 + 2*(0:n-1)/(n-1);

function x = chby(n)
x=cos(pi*((2*(1:n-1))/(2*n)));