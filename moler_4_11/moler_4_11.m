function moler_4_11

%Domanda a
k=0;
x=0;
s_x=sym(0);
%Sintassi vagamente cervellotica per sostituire do-while
while 1
    k=k+1;
    x=factorial(k);
    s_x=factorial(sym(k));
    if (s_x~=x)
        k=k-1;
        break;
    end
end
disp('Il più grande numero che ammette fattoriale esattamente in double');
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
    