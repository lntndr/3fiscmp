function moler_3_03
%Il programma, dai dati della traccia, li interpola in vario modo per
%commentarne i risultati e infine ricava a posteriori il polinomio che ha
%generato i dati della traccia

% Dati della traccia
x=[-1 -0.96 -0.65 0.10 0.40 1]';
y=[-1 -0.1512 0.3860 0.4802 0.8838 1.]';

core_3_3(x,y);

function core_3_3(x,y)

% Domanda A

hold on

plot(x,y,'*k');

% Preparo interpolazioni

u=(-1:0.01:1)';

% Tutte funzioni implementate nel moler

pcl = piecelin(x,y,u);
ply = polyinterp(x,y,u);
spl = splinetx(x,y,u);
pch = pchiptx(x,y,u);

plot(u,pcl,':k');
plot(u,ply,'-b');
plot(u,spl,'.-r');
plot(u,pch,'--g');

% Domanda B

%Globalmente pchip sembra restituire i risultati migliori, tuttavia il
%valore più credibile per 0.3, dando per ipotesi che la misura non
%influenzi il valore dei dati in maniera significativa, è spline.

eval_point=0.3;

if eval_point+1>0
    u_eval=((eval_point+1)/0.01)+1;

else
    u_eval=((eval_point+1)/0.01);

end

disp(pcl(u_eval));
disp(ply(u_eval));
disp(spl(u_eval));
disp(pch(u_eval));

disp('Commenti arguti per rispondere alla domanda b');

% Domanda C

%Ho messo 5 parametri per (#punti)-1 per ricavare il polinomio con polyfit

poly_c=polyfit(x,y,5);

disp('I coefficienti del polinomio sono:');
disp(poly_c);
disp('Al netto degli errori di precisione floating point');
disp(round(poly_c)); % elimina qualche imprecisione floating point irril.
