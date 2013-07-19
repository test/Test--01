clear all
close all

Rm=437; 			% MPa
K_t=2.7;
E=210000;			% MPa
psi=1;
sigm_f=1.5*Rm;
b=-0.087;
e_f_s=0.59*psi;
c=-0.58*Rm;
sigma_0=0.45;
N_D=5e5;
K_s=1.65*Rm;
n_s=0.15;

%% Anpassen von sigma_f_strich
sigm_f=K_s*e_f_s^n_s;
sigma_e=[250 100 350]'*K_t;

sigma_neu=zeros(3,1)';
for i=1:3
II=@(sigma) sigma^2+(sigma/K_s)^(1/n_s)*E*sigma-sigma_e(i)^2;
sigma_neu(i)=fsolve(II ,[sigma_e(i)])
end

II=@(sigma) sigma^2+2*sigma*E*(sigma/(2*K_s))^(1/n_s)-sigma_e(3)^2;
sigma_neu(3)=fsolve(II ,[sigma_e(i)])

Umkehrpunkt1=-sigma_neu(1)+sigma_neu(3)