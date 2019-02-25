function moler_5_12
%Variabili a discrezione
xmin=-2;
deltax=0.01;
xmax=2;

ymin=-2;
deltay=0.01;
ymax=2;

a=randn()/10;
b=randn()/10;
c=randn()/10;
d=randn()/10;
e=randn()/10;
f=randn()/10;

hold on

%Direttamente dalla traccia

[X,Y]=meshgrid(xmin:deltax:xmax,ymin:deltay:ymax);
Z=a*X.^2 +b*X.*Y + c*Y.^2 + d*X + e*Y + f;
%contour(X,Y,Z,[0 0]);

x=[1.02 .95 .87 .77 .67 .56 .44 .30 .16 .01]';
y=[0.39 .32 .27 .22 .18 .15 .13 .12 .13 .15]';

plot(x,y,'ob','MarkerFaceColor',[0.5 0.5 1]);
