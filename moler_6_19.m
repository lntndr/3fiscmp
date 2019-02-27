function moler_6_19
%Domanda a
%0 è punto di accumulazione degli zeri della funzione

k=1;
c=[0,1];
new_max=1;
fit_fun = @(c,x) c(1)+(c(2)/x);
x_k=ones();
time=10;

tic;
while 1
  %%% PARTE A
  old_max=new_max;
  while 1
      k=k+1;
      zero_fun=@(x) log(x)/x+pi*(k-1/2);
      
      try
        prk=fzero(zero_fun,c(1)+(c(2)/k));
      catch
          
        disp('Errore allo zero');
        disp(k);
        
        disp('Impossibile cercare zero a partire dal punto');
        disp(c(1)+(c(2)/k));
        
        disp('Risultato precedente');
        disp(prk);
        k=k-1;
        new_max=k;
        break;  
      end
      
      if isnan(prk)
          k=k-1;
          new_max=k;
          break;
      else
          x_k(k)=prk;
      end
  end
  
  b=toc
  
  %%% PARTE B
  if new_max>old_max && b< time
      c=lsqcurvefit(fit_fun,c,(1:new_max)',x_k,zeros(size(c)));
  else
      break; %<<<----- !Il ciclo finisce qui!
  end
  
end

%%% Calcolo deli integrali una volta ottenuta la serie di zeri

g=@(t) cos(log(t)./t)./t ;
s=0;
s_d=0;
hold on
if mod(new_max,2)~=0
    new_max=new_max-1;
end

s_dv=ones(new_max/2,1);
s_pv=s_dv;

for n=2:new_max
    if mod(n,2)~=0
        s_d=s+integral(g,x_k(n),x_k(n-1));
        s_dv((n+1)/2)=s_d;
    else
        s=s_d+integral(g,x_k(n),x_k(n-1));
        s_pv(n/2)=s;
    end
end

m=(s_dv+s_pv)./2;

disp('FINE PROGRAMMA');

disp('Inf');
disp(s_pv((new_max/2)));

disp('Best');
disp(m((new_max/2)));

disp('Sup');
disp(s_dv((new_max/2)));

plot(1:2:new_max,s_dv,'.k');
plot(2:2:new_max,s_pv,'.r');
plot(1.5:2:new_max+0.5,m,'.b');
