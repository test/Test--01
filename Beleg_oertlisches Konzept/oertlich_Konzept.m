close all
clear all
%% Beleg Betriebsfestigkeit
%Aufgabe 3: oertliches Konzept

%Variablendeklaration
%Kennwerte der ZSD - Kurve und DWL
syms sigma_f b epsilon_f c K_s n_s

%Laufvariable d. ZSD u. DWL
syms sigma N
%Daten aus Aufgabenstellung
epsilon_a=[0.0081;0.008;0.005;0.0035;0.003;0.0028;0.0024;0.0021;0.002;0.0019;0.0018;0.0016];%in mm/mm
F_a=10^3*[41.55;41.63;34.71;32.99;30.49;28.47;26.81;24.35;26;25.1;24.27;21.43];%in N
N_a=[1240;1950;12260;25650;37580;100000;250000;254000;275500;1000000;1600000;3240000];

%Durchmesser der Rundprobe
d_rund=10;%mm
A_rund=d_rund^2/4*pi;%mm^2

%E - Modul
E=2.08E5;%MPa

%Bestimmung der Spannung
sigma_a=F_a/A_rund;

%% 1. Aufgabe
%Bestimmung Dehnungsanteile --> plastisch, elastisch
epsilon_a_plast= epsilon_a - sigma_a./E;
epsilon_a_elast = sigma_a./E;

%Parameter der ZSD
%y=log10(epsilon_a_plast);x=log10(sigma_a);m=1/n_s;n=-log10(K_s)
[n_s,K_s] = Parameter(log10(sigma_a),log10(epsilon_a_plast),1/n_s,-1/n_s*log10(K_s),[n_s,K_s]);

%Parameter der DWL
%Bildung lineare Regressionsgerade y=m*x+m
epsilon_a_plast = eval((sigma_a./K_s).^(1/n_s));
%DWL_elast -->
%y=log10(epsilon_a_elast);x=log10(N_a);m=b;n=log10(sigma_f/E)+b*log10(2)
[b,sigma_f] = Parameter(log10(N_a),log10(epsilon_a_elast),b,log10(sigma_f/E*2^b),[b,sigma_f]);

%DWL_plast -->
%y=log10(epsilon_a_plast);x=log10(N_a);m=c;n=log10(epsilon_f)+c*log10(2)
[c,epsilon_f] = Parameter(log10(N_a),log10(epsilon_a_plast),c,log10(epsilon_f*2^c),[c,epsilon_f]);


%Diagramme
%Funktion der DWL --> Laufvariable N
e_DWL_elast=sigma_f/E*(2*N)^b;
e_DWL_plast=epsilon_f*(2*N)^c;
e_DWL=e_DWL_elast+e_DWL_plast;

%Wertebereich N
Nw=[1E2:100000:1E10];
%Versuchsergebnisse
loglog(N_a,epsilon_a,'gr*');
hold on
%regressive Kennlinie Gesamtdehnung
loglog(Nw,subs(e_DWL,N,Nw));
%regressive Kennlinie elastische Dehnung
loglog(Nw,subs(e_DWL_elast,N,Nw),'r');
%regressive Kennlinie plastische Dehnung
loglog(Nw,subs(e_DWL_plast,N,Nw),'y');
legend('Versuchsergebnisse','regressive Kennlinie Gesamtdehnung',...
    'regressive Kennlinie elastische Dehnung','regressive Kennlinie plastische Dehnung','Location','Best');
hold off;
xlabel('Anrisswechselzahl N_a');
ylabel('Dehnung \epsilon');
%Funktion der ZSD --> Laufvariable sigma
e_ZSD_elast=sigma/E;
e_ZSD_plast=(sigma/K_s)^(1/n_s);
e_ZSD = e_ZSD_elast + e_ZSD_plast;

%Wertebereich sigma
figure;
sigmaw=[0:550];
%Versuchsergebnisse
plot(epsilon_a,sigma_a,'gr*');
hold on
%regressive Kennlinie Gesamtdehnung
plot(subs(e_ZSD,sigma,sigmaw),sigmaw);
%regressive Kennlinie elastische Dehnung
plot(subs(e_ZSD_elast,sigma,sigmaw),sigmaw,'r');
%regressive Kennlinie plastische Dehnung
plot(subs(e_ZSD_plast,sigma,sigmaw),sigmaw,'y');
legend('Versuchsergebnisse','regressive Kennlinie Gesamtdehnung',...
    'regressive Kennlinie elastische Dehnung','regressive Kennlinie plastische Dehnung','Location','Best');
hold off;
xlabel('Dehnung \epsilon');
ylabel('Spannung \sigma_a')






