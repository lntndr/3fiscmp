function moler_5_12

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

contour(X,Y,Z,[0 0],'k');

plot(x,y,'ob','MarkerFaceColor',[0.5 0.5 1]);

% Domanda B

%Perturbazioni "omogenee" (identico p per ogni parametro)

p=rand()*0.001-0.0005;

A_p=[((x+p).^2),((x+p).*(y+p)),((y+p).^2),x+p,y+p];

cf=A_p\(b+p);

Z=cf(1)*X.^2 +cf(2)*X.*Y + cf(3)*Y.^2 + cf(4)*X + cf(5)*Y + 1+p;

contour(X,Y,Z,[0 0],'g');

%Perturbazioni "caotiche" (p varia per ogni parametro)

p=rand(7,1)'.*0.001-0.0005;

A_pc=[((x+p(1)).^2),((x+p(2)).*(y+p(3))),((y+p(4)).^2),x+p(5),y+p(6)];

cf=A_pc\(b+p(7));

Z=cf(1)*X.^2 +cf(2)*X.*Y + cf(3)*Y.^2 + cf(4)*X + cf(5)*Y + 1+p(7);

contour(X,Y,Z,[0 0],'r');






