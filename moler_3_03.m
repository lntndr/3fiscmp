function moler_3_3

% Domanda A

% Carico dati della traccia
x=[-1 -0.96 -0.65 0.10 0.40 1]';
y=[-1 -0.1512 0.3860 0.4802 0.8838 1.]';

hold on

plot(x,y,'*k');

% Preparo interpolazioni

u=(-1:0.01:1)';

pcl = piecelin(x,y,u);
ply = polyinterp(x,y,u);
spl = splinetx(x,y,u);
pch = pchiptx(x,y,u);

plot(u,pcl,':k');
plot(u,ply,'-b');
plot(u,spl,'.-r');
plot(u,pch,'--g');

% Domanda B

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

%Ho messo 5 parametri per (#punti)-1

poly_c=polyfit(x,y,5);

disp('I coefficienti del polinomio sono:');

disp(round(poly_c)); % elimina qualche imprecisione floating point irril.













