% --------------------
% system's parameters:
% --------------------

M = 5 % massa
K = 5 % costante elastica
S = 5 % costante smorzatore

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

x0 = [5; % posizione iniziale
      2] % velocità iniziale

% --------------------
% certainty-equivalence state-feedback controller
% --------------------

G = place(A,B,eig_G) % costruisce matrice G dati gli autovalori desiderati




