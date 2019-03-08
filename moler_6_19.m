function moler_6_19

%Il programma calcola l'integrale dato in due parti: prima ricava gli
%estremi di integrazione degli elementi della serie trovando gli zeri nella
%funzione data nella traccia, poi usa quad per valutare i singoli elementi 
%della traccia. Una volta ottentuta la serie paragona i risultati con la
%serie ottenuta tramite accelerazione di Aitken.

time_max=10;            %Variabili modificabili dall'utente,
fix_max=realmax();      %il programma si ferma alla prima condizione
                        %raggiunta durante la ricerca degli zeri.

int_switch=1; %Matlab R2018b sconsiglia l'uso di quad() a favore di
              %integral(). Il programma è identico nel funzionamento.
              %quad() è molto più veloce ma fallisce nel determinare
              %oltre la 6a cifra significativa, integral() arriva
              %fino alla 10a. 0 -> quad, 1 -> integral

core_6_19(time_max,fix_max,int_switch);

function core_6_19(time_max,fix_max,int_switch)

k=1;
c=[0 1];
new_sup=1;
x_k=ones();
z_cyc=1;
fit_fun = @(c,x) c(1)+(c(2)/x);
silent=optimset('Display','off');

tic;

%Parte A -> Cerca gli estremi di integrazione annullando la funzione
%della traccia

while 1

    %Parte A.1 il ciclo while usa fzero per trovare le radici fino a quando
    %riesce a trovarne o non viene raggiunta una condizione di blocco
    while 1
        
        k=k+1;
        zero_fun=@(x) log(x)/x+pi*(k-1/2);

        try
            prk=fzero(zero_fun,(c(1)+c(2)/k),silent);
        catch
            k=k-1;
            new_sup=k;
            break;  
        end

        b=toc;

        if isnan(prk) || k == fix_max+1 || b>=time_max
            k=k-1;
            new_sup=k;
            break;
        else
            x_k(k)=prk;
        end
    end
    
    %Parte A.2 se nessuno dei blocchi è scattato usa i punti calcolati
    %per migliorare il tentativo di ricerca degli zeri nel ciclo successivo
    if new_sup>old_sup && b < time_max && k < fix_max+1
        c=lsqcurvefit(fit_fun,c,(1:new_sup)',x_k,[0 0],[Inf Inf],silent);
        z_cyc=z_cyc+1;
    else
        break; %<<<----- !Il ciclo finisce qui!
    end
    
    old_sup=new_sup;

end

b=toc;

fprintf('Trovati %d estremi tramite %d cicli in %d s\n',new_sup,z_cyc,b);

%Parte B -> Calcolo deli integrali una volta ottenuta la serie di zeri

g=@(t) cos(log(t)./t)./t ;
p_sum_p=0;
p_sum_d=0;

hold on
if mod(new_sup,2)~=0
    new_sup=new_sup-1;
end

v_sum_d=ones(new_sup/2,1);
v_sum_p=v_sum_d;

if int_switch==0
    disp('Integrali valutati con quad()');
    int_typ= @quad;
else
    disp('Integrali valutati con integral()');
    int_typ= @integral;
end

for n=2:new_sup
    if mod(n,2)~=0
        p_sum_d=s+int_typ(g,x_k(n),x_k(n-1));
        v_sum_d((n+1)/2)=p_sum_d;
    else
        s=p_sum_d+int_typ(g,x_k(n),x_k(n-1));
        v_sum_p(n/2)=s;
    end
end

%Medie delle serie calcolate
m=(v_sum_d+v_sum_p)./2;

%Grafici delle serie calcolate

plot(1:2:new_sup,v_sum_d,'.k');
plot(2:2:new_sup,v_sum_p,'.r');
plot(1.5:2:new_sup+0.5,m,'.b');

%Accelerazione Aitken
%Recupero valori iniziali

x=[v_sum_d'; v_sum_p']; %Unisce somme pari e dispari
x=x(:)';

x_ait=zeros(1,size(x,2)-2);
for n=1:(size(x,2)-2)
    a=x(n+2);
    b=(x(n+2)-x(n+1));
    c=(x(n+2)-x(n+1))-(x(n+1)-x(n));
    x_ait(n)=a-(b^2/c);
end

plot(1:size(x_ait,2),x_ait,'.c');

ylim([0.32 0.325]); %Aiuta la chiarezza del grafico

hold off;

fprintf('Somma inferiore: %d \n',v_sum_p(end));
fprintf('Somma superiore: %d \n',v_sum_d(end));
fprintf('Media          : %d \n',m(end));
fprintf('Serie di Aitken: %d \n \n',x_ait(end));

g_value=0.3233674316;

fprintf('Dato il riferimento %d i risultati divergono di: \n',g_value);
fprintf('Serie superiore:          %d \n',abs(v_sum_d(end)-g_value));
fprintf('Serie inferiore:          %d \n',abs(v_sum_p(end)-g_value));
fprintf('Media tra membri alterni: %d \n',abs(m(end)-g_value));
fprintf('Aitken:                   %d \n',abs(x_ait(end)-g_value));

%Si osserva come la convergenza sia estremamente più veloce e la miglior
%stima sia tra la sommatoria parziale con k dispari e la media tra le due
%sommatorie parziali