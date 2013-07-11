function[K1,K2] = Parameter(x,y,m,n,Konst)
% Die Funktion bestimmt die Parameter der DWL und ZSD Kurve bei einer linearen Regression.
% Form: y=m*x+n --> Uebergabe der logarithmierten Gleichung
%Bsp. DWL: y=log10(epsilon_a_elast);x=log10(N_a);m=b;n=log10(sigma_f/E)+b*log10(2)

%Konst ist Vektor mit zwei Eintraegen. 1. Eintrag entspricht dem
%Parameter in der Potenz. Der zweite dem Vorfaktor Bsp. ZSD:
%Konst(1)=n; Konst(2)=K

%K1,K2 sind die zu bestimmenden Paramter.

p=polyfit(x,y,1);
K1=solve(m-p(1),Konst(1));
n=subs(n,Konst(1),K1);
K2=solve(p(2)-n,Konst(2));

