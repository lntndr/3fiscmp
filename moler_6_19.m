function moler_6_19
%Domanda a
%0 è punto di accumulazione degli zeri della 

k_max=20;
x_k=(zeros(k_max+1,1));

for k=1:k_max;
f=@(x) log(x)/x+pi*(k-1/2)
x_k(k+1)=fzero(f,1/k) %1/k serie decrescente più facile che mi è venuta in
                    %mente, niente di più raffinato
end

f=@(x) x^-1*cos(x^(-1)*log(x));

for k=1:k
    
    

end