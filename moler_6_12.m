function moler_6_12

%Il programma lavora con la funzione log(1+x)*log(1-x) e ne valuta
%l'integrale in modi diversi, aggirando i problemi agli estremi e 
%comparando i diversi metodi.

syms x;

f=log(1+x)*log(1-x);

%Domanda a
fa=figure;
fplot(f,[-1 1]);

%Domanda b
def_i=int(f,[-1 1])

%Domanda c
e_def_i=eval(def_i)

%Domanda d
%La richiesta dell'esercizio causa un loop infinito

%Domanda e
%Il loop infinito è scongiurato eliminando punti a tg verticale 
quadtx(@(x)log(1+x)*log(1-x),-1+eps,1-eps)

ord=10;

x=10.^(-1:-1:-ord)';
y=(zeros(ord,1));

for k=1:ord
    tol=10^(-k);
    y(k)=abs(e_def_i-quadtx(@(x)log(1+x)*log(1-x),-1+eps,1-eps,tol));
    % Differenza tra l'integrale valutato dal calcolo simbolico e quello
    % numerico a tolleranza variabile
end

fb=figure;
hold on
plot(x,y,'*k');

% L'errore cresce linearmente rispetto alla tolleranza
fplot(@(x) x,[x(ord) x(1)],'b');

set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')





