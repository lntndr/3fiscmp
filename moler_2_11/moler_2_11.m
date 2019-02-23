function moler_2_11()

%Sunto dell'esercizio

showcase = {rand(3,5),...                  % matrice non quadrata casuale
            [0 0 0; 0 1 0; 0 2 0],...      %         singolare
            [2 -1 0; -1 2 -1; 0 -1 2],...  %         simmetrica, def. pos.
            [1  0 0; 3 5 0; 7 9 11],...    %         triangolare inferiore
            [2 4 6; 0 8 10; 0 0 12],...    %         triangolare superiore
            rand(5),...                    %         quadrata casuale
            magic(5),...                   %         magica 5*5
            golub(5)};                     %         tipo Golub             
        
[~,nex]=size(showcase);

for c=1:nex
    disp("============");
    disp("MATRICE N° "+c);
    disp("============");
    disp(showcase{c});
    
    disp("***** Funzione personale");
    my=myinv(showcase{c});
    disp(my);
    
    disp("***** Funzione integrata");
    try
        ml=inv(showcase{c});
    catch
        warning("La funzione non ha restituito un risultato");
        ml=NaN;
    end
    disp(ml);
    
    % Verifica fino a che decimale sono in accordo
    if ~isnan(my) % myinv è giunto a qualcosa
        decimal=1;
        while isequal(round(my,decimal),round(ml,decimal))
        decimal= decimal+1;
        end
        disp("I due risultati sono in accordo fino a 10^-" + decimal);
    end
    
end

% ------------------------------

function [X]=myinv(A)
%Controlli preliminari

[n,m] = size (A);

if n~=m 
    warning("La matrice deve essere quadrata");
    X=(NaN);
    return;
end

if rank(A)<n
    warning("rk(A)<dim(A), non invertibile");
    X=(NaN);
    return;
end 

%Se nulla è andato troppo storto alloco una matrice per contenere l'inversa
X=eye(n);

%Controllo se è triangolare o reale simmetrica

if isequal(triu(A,1),zeros(n,n))
   % è triangolare bassa
   for k=1:n
       x = forward(A,X(:,k));
       X(:,k) = x;
   end
   return;
   
elseif isequal(tril(A,-1),zeros(n,n))
   % è triangolare alta
   for k=1:n
       x = backsubs(A,X(:,k));
       X(:,k) = x;
   end
   return;
   
elseif isequal(A,A')
   % è reale simmetrica -> posso provare Chol invece di LU
   [R,fail] = chol(A);
   if ~fail     % 1 se è definitva positiva 0 altrimenti
      % è definita positiva
      for k=1:n
          y = forward(R',X(:,k));
          x = backsubs(R,y);
          X(:,k) = x;
      end
   end
   return
end

% Se fallisce il resto fattorizzazione LU
% Potrei, come sopra, sfruttare la X identità per parcheggiare i vettori
% invece di creare sia L^-1 che U^-1, ma il vantaggio in memoria a mio
% parere non compensa la perdita in leggibilità

Li=zeros(n);
Ui=zeros(n);
[L,U,p] = lutx(A);
    for k=1:n
        l = forward(L,X(:,k));
        u = backsubs(U,X(:,k));
        Li(:,k) = l;
        Ui(:,k) = u;
    end
    P=pvec2pmat(p);
    X=Ui*Li*P;

% ------------------------------

function x = forward(L,x)
% FORWARD. Forward elimination.
% For lower triangular L, x = forward(L,b) solves L*x = b.
[~,n] = size(L);
x(1) = x(1)/L(1,1);
for k = 2:n
   j = 1:k-1;
   x(k) = (x(k) - L(k,j)*x(j))/L(k,k);
end


% ------------------------------

function x = backsubs(U,x)
% BACKSUBS.  Back substitution.
% For upper triangular U, x = backsubs(U,b) solves U*x = b.
[~,n] = size(U);
x(n) = x(n)/U(n,n);
for k = n-1:-1:1
   j = k+1:n;
   x(k) = (x(k) - U(k,j)*x(j))/U(k,k);
end

% ------------------------------

function P = pvec2pmat(p)
% Traduce vettore di permutazione in matrice di permutazione
P=zeros(size(p));
for r=1:size(p)
    P(r,p(r))=1;        % Giovanni telegrafista
end


