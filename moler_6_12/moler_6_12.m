function moler_6_12

syms x;

f=log(1+x)*log(1-x);

%Domanda a
fplot(f,[-1 1]);

%Domanda b
def_i=int(f,[-1 1])

%Domanda c
eval(def_i)

%Domanda d
%Il loop infinito è scongiurato eliminando punti a tg verticale 
quadtx(@(x)log(1+x)*log(1-x),-1+eps,1-eps)

%Domanda e
m





