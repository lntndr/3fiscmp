function moler_2_15

% Variabili modificabili a piacere                    
max_order=4;            % Ogni tentativo viene eseguito con su
                        % una matrice n*n con n=m*10^(order), m definito
                        % da un ciclo for. Il programma dovrebbe gestire 
                        % eccezioni dovute al sopraggiungere del limite di
                        % memoria allocabile per un array, ma potrebbe cau-
                        % sare rallentamenti                       
% --------------------------------

smt_wrong=0;
order=0;

hold on
                        
while (smt_wrong==0) && (order <= max_order)
    tries=get_tries(order);
    for m=0:2:8
        x=zeros(tries,1);   % 3 tentativi (3,6,9) per ordine da 0 a salire
        y=x;
        try
            for n=1:tries 
                x(n)=m*10^(order);
                y(n)=condest(golub(m*10^(order)));
            end
        catch
            smt_wrong=1;
            break;
        end
        scatter(x,y,2,'filled');
    end
    order=order+1;
end

set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')

function x=get_tries(order)
if  10^(3-order)>10
    x=10^(3-order);
else
    x=5;
end