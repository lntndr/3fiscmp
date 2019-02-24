function moler_2_15

% Variabili modificabili a piacere                    
max_order=2;            % Ogni tentativo viene eseguito con su
                        % una matrice n*n con n=m*10^(order), m definito
                        % da un ciclo for. Il programma dovrebbe gestire 
                        % eccezioni dovute al sopraggiungere del limite di
                        % memoria allocabile per un array, ma potrebbe cau-
                        % sare rallentamenti                       
% --------------------------------

smt_wrong=0;
order=0;

hold on

m_x=zeros(5*(max_order+1),1);
m_y=m_x;
                        
while (smt_wrong==0) && (order <= max_order)
    tries=get_tries(order);
    for m=2:2:10
        x=zeros(tries,1);   
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
        scatter(x,y,2,[0.8, 0.8, 0.8],'filled');
        m_x(5*order+m/2)=m*10^(order);
        m_y(5*order+m/2)=sum(y)/tries;
    end
    order=order+1;
end

plot(m_x,m_y,'*k');

set(gca, 'YScale', 'log')
set(gca, 'XScale', 'log')

function x=get_tries(order)
if  10^(3-order)>=10
    x=10^(3-order);
else
    x=5;
end

