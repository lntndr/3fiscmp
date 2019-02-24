function moler_4_3

p=[816 -3835 +6000 -3125];

%Domanda a
r=roots(p)
hold on

%Domanda b
fplot(poly2sym(p),[1.43,1.71]);
plot(r,r.*0,'*k');
f=@(x) polyval(p,x);

%Domanda c
nwtn_res=newton(p,1.5)

%Domanda d
scnt_res=secant(f,1,2)

%Domanda e
bsct_res=bisection(f,1,2)

%Domanda f
fztx_res=fzerotx(f,[1 2])

%Commenti arguti sui risultati di fztz_res

function x=newton(p,eg)

f=@(x) polyval(p,x);
fprime=@(x) polyval(polyder(p),x);

x=eg;
xprev=x+2*eps*abs(x);

while abs(x-xprev)>eps*abs(x)
    xprev=x;
    x=x-(feval(f,x)/feval(fprime,x));
end

function c=secant(f,a,b)

while abs(b-a)>eps*abs(b)
    c=a;
    a=b;
    b=b+(b-c)/(feval(f,c)/feval(f,b)-1);
end

function x=bisection(f,a,b)

while abs(b-a)>eps*abs(b)
    x=(a+b)/2;
    if sign(feval(f,x)) == sign(feval(f,b))
        b=x;
    else
        a=x;
    end
end
