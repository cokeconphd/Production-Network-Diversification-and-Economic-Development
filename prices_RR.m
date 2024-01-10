function y = prices_RR(x,z,omega,epsQ,epsM,varrhoQ,varrhoM,a)

[row,col]=size(omega);
pp  =x;

%% Esto viene de la ecuación anterior a la (11)

pm = ( (omega.^(varrhoM.*epsM))'* pp.^(1-epsM) ).^(1./(1-epsM));

PPP = (1-epsQ).*log(pp) - (epsQ-1).*log(z) - log(a.^(varrhoQ.*epsQ) + ...
 (1-a).^(varrhoQ.*epsQ).*pm.^(1-epsQ)); 

y = PPP + 10000000000000*imag(pp);


end
