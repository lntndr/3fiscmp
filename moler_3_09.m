function moler_3_09(arg)
%moler3_9  Runge's polynomial interpolation example.
%   F(x) = 1/(1+25*x^2)
%   interpolazione tramite polinomi di grado crescente nell'intervallo tra
%   -1 e 1 , osservo come l'interpolazione converga per n che tende ad
%   infinito solo nell'intervallo chiuso prima citato.
%   questo programma è stato ricavato modificando la distribuzione dei punti,
%   i punti qui si distribuiscono come i nodi di Chebyshev 

if nargin == 0

   % Inizializzazione grafico e uicontrols

   shg
   clf reset
   set(gcf,'numbertitle','off','menu','none', ...
       'name','Runge''s interpolation example')
   n = 1;
   u = -1.1:.01:1.1;
   z = rungerat(u);
   h.plot = plot(u,z,'-', 0,1,'o', u,z,'-');
   set(h.plot(1),'color',[.6 .6 .6]);
   set(h.plot(2),'color','blue');
   set(h.plot(3),'color',[0 2/3 0]);
   axis([-1.1 1.1 -0.1 1.1])
   title('1/(1+25*x^2)','interpreter','none')

   h.minus = uicontrol('units','norm','pos',[.38 .01 .06 .05], ...
          'fontsize',12,'string','<','callback','moler_3_09(''n--'')');
   h.n = uicontrol('units','norm','pos',[.46 .01 .12 .05], ...
          'fontsize',12,'userdata',n,'callback','moler_3_09(''n=1'')');
   h.plus = uicontrol('units','norm','pos',[.60 .01 .06 .05], ...
          'fontsize',12,'string','>','callback','moler_3_09(''n++'')');
   h.close = uicontrol('units','norm','pos',[.80 .01 .10 .05], ...
          'fontsize',12,'string','close','callback','close');

   set(gcf,'userdata',h)
   arg = 'n=1';
end

% Update grafico.

h = get(gcf,'userdata');

% Numero di punti di interpolazione di Chebyshev.

n = get(h.n,'userdata');
switch arg
   case 'n--', n = n-2;
   case 'n++', n = n+2;
   case 'n=1', n = 1;
end
set(h.n,'string',['n = ' num2str(n)],'userdata',n);
if n==1
   set(h.minus,'enable','off');
else
   set(h.minus,'enable','on');
end

if n == 1;
   x = 0;
else
   x = cos(pi*(2*(1:n)-1)/(2*(n-1)));
end
y = rungerat(x);
u = get(h.plot(1),'xdata');
v = polyinterp(x,y,u);
set(h.plot(2),'xdata',x,'ydata',y);
set(h.plot(3),'xdata',u,'ydata',v);

% ------------------------

function y = rungerat(x);
y = 1./(1+25*x.^2);