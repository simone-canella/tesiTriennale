% --------------------
% system's parameters:
% --------------------

M = 50 % massa
M_nominal = M
K = 0.02 % costante elastica
K_nominal = K
S = 0.02 % costante smorzatore
S_nominal = S

N = 5 % numero giunti intere molla
L = 10 % lunghezza giunti

% --------------------
% desired eigenvalues
% --------------------

eig_G = 1*[-1 -2 ]

% --------------------
% matrix and initial conditions
% --------------------

A = [   0     1    ;
      -K/M  -S/M   ]
      

B = [  0  ;
      1/M ] 


C = [ 1 0 ;
      0 1 ]

D = zeros(size(C,1),size(B,2))


dimx = size(A,1)  % quindi dimx = 2
dimu = size(B,2)  % quindi dimu = 1
dimy = size(C,1)  % quindi dimy = 2

x0 = [20; % posizione iniziale
      100] % velocità iniziale

% --------------------
% certainty-equivalence state-feedback controller
% --------------------

G = place(A,B,eig_G) % costruisce matrice G dati gli autovalori desiderati




