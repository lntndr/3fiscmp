function moler_6_19
%Domanda a
%0 è punto di accumulazione degli zeri della 
%Ciclo while sufficientemente complesso
%   A. Un while cerca zeri al crescere di k cercandoli al decrescere di
%           a+b/x
%   B. Se ha trovato più zeri della volta prima crea un vettore
%   C. Un ciclo for popola il vettore con i nuovi zeri
%   D. Un fit degli zeri ridefinisce a e b facendo ricomiciare il ciclo
% Il programma fitta solo una delle due sottosequenze, quella positiva
% Non escludo che ci siano scelte più raffinate
k=1;
c=[0,1];
new_max=1;
k=1;
fun = @(c,xdata) c(1)+(c(2)/xdata);
x_k=[];
while 1
  %%% PARTE A
  max=new_max;
  while 1
      k=k+1;
      f=@(x) log(x)/x+pi*(k-1/2);
      prk=fzero(f,c(1)+(c(2)/k));
      if isnan(prk)
          new_max=k-1;
          disp("Impossibile trovare zeri ulteriori");
          break;
      end
  end
  %%% PARTE B
  if new_max>max
      x_k=[x_k,k+1:new_max];
      %%% PARTE C
      for n=1:new_max;
        f=@(x) log(x)/x+pi*(n-1/2);
        x_k(n)=fzero(f,c(1)+(c(2)/n));
      end
      %%% PARTE D
      disp('DDD');
      c = lsqcurvefit(fun,1,1:new_max,x_k);
  else
      break; %<<<----- !Il ciclo finisce qui!
  end
end

g=@(t) cos(log(t)./t)./t ;
s=0;
s_d=0;
hold on
s_dv=zeros(k_max/2,1);
s_pv=s_dv;
for k=1:k_max
    if mod(k,2)~=0
        s_d=s+quad(g,x_k(k+1),x_k(k));
        s_dv((k+1)/2)=s_d;
    else
        s=s_d+quad(g,x_k(k+1),x_k(k));
        s_pv(k/2)=s;
    end
end
plot(1:2:k,s_dv,'.k');
plot(2:2:k,s_pv,'.r');
m=(s_dv+s_pv)./2;
plot(1.5:2:k+0.5,m,'.b');
