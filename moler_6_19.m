function moler_6_19

%Variabili modificabili dall'utente, il programma si ferma al primo blocco
%raggiunto

time_max=90; 
fix_max=realmax();

%Parte A -> Cerca gli estremi di integrazione annullando la funzione
%nella traccia

k=1;
c=[0 1];
new_sup=1;
x_k=ones();
z_cyc=1;
fit_fun = @(c,x) c(1)+(c(2)/x);

tic;

while 1

    old_sup=new_sup;
    while 1
        k=k+1;
        zero_fun=@(x) log(x)/x+pi*(k-1/2);

        try
            prk=fzero(zero_fun,c(1)+c(2)/k);
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

    if new_sup>old_sup && b < time_max && k < fix_max+1
        c=lsqcurvefit(fit_fun,c,(1:new_sup)',x_k,zeros(size(c)));
        z_cyc=z_cyc+1;
    else
        break; %<<<----- !Il ciclo finisce qui!
    end

end

fprintf('Trovati %d estremi tramite %d cicli in %d s\n',new_sup,z_cyc,b);

%Parte B -> Calcolo deli integrali una volta ottenuta la serie di zeri

g=@(t) cos(log(t)./t)./t ;
s=0;
s_d=0;

hold on
if mod(new_sup,2)~=0
    new_sup=new_sup-1;
end

s_dv=ones(new_sup/2,1);
s_pv=s_dv;

tic;

for n=2:new_sup
    if mod(n,2)~=0
        s_d=s+quad(g,x_k(n),x_k(n-1));
        s_dv((n+1)/2)=s_d;
    else
        s=s_d+quad(g,x_k(n),x_k(n-1));
        s_pv(n/2)=s;
    end
end

m=(s_dv+s_pv)./2;

b=toc;

fprintf('Calcolati %d integrali in %d s\n',new_sup,b);

disp('FINE PROGRAMMA');

disp('Inf');
disp(s_pv((new_sup/2)));

disp('Best');
disp(m((new_sup/2)));

disp('Sup');
disp(s_dv((new_sup/2)));

plot(1:2:new_sup,s_dv,'.k');
plot(2:2:new_sup,s_pv,'.r');
plot(1.5:2:new_sup+0.5,m,'.b');
