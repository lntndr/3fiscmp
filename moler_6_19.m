function moler_6_19
%Domanda a
%0 è punto di accumulazione degli zeri della funzione

k=1;
c=[0,1];
new_max=1;
fit_fun = @(c,x) c(1)+(c(2)/x);
x_k=ones();
tic;
while 1
  %%% PARTE A
  old_max=new_max;
  while 1
      k=k+1;
      zero_fun=@(x) log(x)/x+pi*(k-1/2);
      prk=fzero(zero_fun,c(1)+(c(2)/k));
      if isnan(prk)
          new_max=k-1;
          disp("Impossibile trovare zeri ulteriori");
          break;
      else
          if k==755
              disp("UÈ NANI!");
          end
          x_k(k)=prk;
      end
  end
  b=toc;
  %%% PARTE B
  if new_max>old_max && b < 1
      c=lsqcurvefit(fit_fun,c,(1:new_max)',x_k);
  else
      break; %<<<----- !Il ciclo finisce qui!
  end
  
end

g=@(t) cos(log(t)./t)./t ;
s=0;
s_d=0;
hold on
if mod(new_max,2)==0
    s_dv=zeros(new_max/2,1);
    s_pv=s_dv;
else
    s_dv=zeros(floor(new_max/2),1);
    s_dv=zeros(ceil(new_max/2),1);
end
for n=1:new_max
    if mod(n,2)~=0
        s_d=s+integral(g,x_k(n+1),x_k(n));
        s_dv((n+1)/2)=s_d;
    else
        s=s_d+integral(g,x_k(n+1),x_k(n));
        s_pv(n/2)=s;
    end
end
plot(1:2:k,s_dv,'.k');
plot(2:2:k,s_pv,'.r');
m=(s_dv+s_pv)./2;
plot(1.5:2:k+0.5,m,'.b');
