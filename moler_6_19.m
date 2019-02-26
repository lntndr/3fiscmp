function moler_6_19
%Domanda a
%0 è punto di accumulazione degli zeri della 

k_max=1000;              %Valori maggiori richiedono modelli più sofisticati
x_k=(1:k_max);

for k=1:k_max-1;
f=@(x) log(x)/x+pi*(k-1/2);
x_k(k+1)=fzero(f,1/k); %1/k serie decrescente più facile che mi è venuta in                       %mente, niente di più raffinato
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
