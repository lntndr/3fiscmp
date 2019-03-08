function moler_5_12

%Il programma interpola un'orbita data con una curva di livello di una
%forma quadratica ottenuta tramite soluzione di un sistema lineare e
%restituisce un grafico con le posizioni date, 5 set di posizioni
%perturbate e le relative orbite calcolate.

%Variabili a 
xmin=-1.5;
deltax=0.01;
xmax=1.5;

ymin=-1.5;
deltay=0.01;
ymax=1.5;

x=[1.02 .95 .87 .77 .67 .56 .44 .30 .16 .01]';
y=[0.39 .32 .27 .22 .18 .15 .13 .12 .13 .15]';

%Decido di fissare f==1 e risolvere il sistema A*cf=(ones(10,1).*-1)

A=[(x.^2),(x.*y),(y.^2),x,y];
b=ones(10,1).*-1;

cf=A\b;

%Direttamente dalla traccia

[X,Y]=meshgrid(xmin:deltax:xmax,ymin:deltay:ymax);
Z=cf(1)*X.^2 +cf(2)*X.*Y + cf(3)*Y.^2 + cf(4)*X + cf(5)*Y + 1;

hold on

contour(X,Y,Z,[0 0],'b');

plot(x,y,'ob','MarkerFaceColor',[0.5 0.5 1]);

x_p=x;
y_p=y;

%Perturbazioni
%I vari tentativi associati alle posizioni sono marcati per colore
for t=1:5
    
    for n=1:size(x,1)
        x_p(n)=x(n)+(rand()*0.001-0.0005);
        y_p(n)=y(n)+(rand()*0.001-0.0005);
    end
    
    plot(x_p,y_p,'Color',colorpicker(t,5),'Marker','+','LineStyle','none');
    
    A=[((x_p).^2),((x_p).*(y_p)),((y_p).^2),y_p,x_p];
    cf=A\b;
    Z=cf(1)*X.^2 +cf(2)*X.*Y + cf(3)*Y.^2 + cf(4)*X + cf(5)*Y + 1;
    contour(X,Y,Z,[0 0],'Color',colorpicker(t,5));
end

function c = colorpicker(n,n_max)
    c(1)=1-(n/n_max);
    c(2)=(n/n_max);
    c(3)=0.1+0.2*(n/n_max);
return