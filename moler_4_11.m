function moler_4_11

%Domanda a
k=0;
x=0;
s_x=0;
%Sintassi vagamente cervellotica per sostituire do-while
while 1
    k=k+1;
    x=factorial(k);
    s_x=gamma(k+1);
    if (s_x~=x)
        k=k-1;
        break;
    end
end
disp('Il più grande numero per cui gamma coincide con il fattoriale esattamente in double');
disp(k);

%Domanda b
k=0;
x=0;
while 1
    k=k+1;
    if (factorial(k))>=inf
        k=k-1;
        break;
    end
end
disp('Il più grande numero che ammette fattoriale senza owerflow');
disp(k);

k=0;
x=0;
while 1
    k=k+1;
    if (gamma(k+1))>=inf
        k=k-1;
        break;
    end
end
disp('Il più grande numero che ammette gamma senza owerflow');
disp(k);
end
