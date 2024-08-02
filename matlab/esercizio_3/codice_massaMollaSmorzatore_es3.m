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
eig_H = 2*[-1 -2 ]
eig_G = 1*[-1 -2 ]

% --------------------
% matrix and initial conditions
% --------------------
A = [   0     1    ;
      -K/M  -S/M   ]
      

B = [  0  ;
      1/M ] 


C = [0 1]

D = zeros(size(C,1),size(B,2))


dimx = size(A,1)  % quindi dimx = 2
dimu = size(B,2)  % quindi dimu = 1
dimy = size(C,1)  % quindi dimy = 1

x0 = [15; % posizione iniziale
      20] % velocità iniziale
% x0 = [0 0 0 0]'; %p.to di equilibrio

% --------------------
% certainty-equivalence state-feedback controller
% --------------------
G=place(A,B,eig_G) % costruisce matrice G dati gli autovalori desiderati
  
% --------------------
% Luenberger observer 
% --------------------

%luenberger obs:
%  z_dot = Az + Bu + H(y-Cz) = (A-HC)z +[B H] [u y]

% initial conditions
z0 = [-.5; % posizione iniziale stimata
      -.31] % velocità iniziale stimata

%z0 = x0  %partenza con stima ok

H=place(A',C',eig_H)' % costruisce matrice H dati gli autovalori desiderati

A_lu = A-H*C

B_lu = [B H]

C_lu = eye(size(A))

D_lu = zeros(size(C_lu,1),size(B_lu,2))



