% --------------------
% system's parameters:
% --------------------

M = 50 % massa
K = 0.02 % costante elastica
S = 0.02 % costante smorzatore

N = 5 % numero giunti intere molla
L = 10 % lunghezza giunti

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
