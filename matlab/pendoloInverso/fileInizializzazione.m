%system's parameters:

M = 0.5
m = 0.1
g = 9,80665
L = 0.3

%desired eigenvalues
eig_H = 2*[-1 -2 -2.5 -1.5] %autovalori desiderati ossevatore
eig_K = 1*[-1 -2 -2.5 -1.5]

A = [ 0 1  0             0;
      0 0  -(m*g)/M      0;
      0 0  0             1;
      0 0  (M+m)*g/(L*M) 0] 
B = [ 0 ;
      1/M;
      0;
      -1/(L*M)] 
C = [1 0 0 0;
     0 0 1 0]



dimx = size(A,1)
dimu = size(B,2)
dimy = size(C,1)

C_x = eye(size(A))
D_x = zeros(size(C_x,1),size(B,2))


D = zeros(size(C,1),size(B,2))

x0 = [.5;
      .1;
      1*(pi/180);
      .1*(pi/180)]
% x0 = [0 0 0 0]'; %p.to di equilibrio

z0 = [-.5;
      -.31;
      -1.1*(pi/180);
      .11*(pi/180)]
 %z0 = x0  %partenza con stima ok


%approximate plant

delta_A = 0*A;
delta_B = 0*B;
delta_C = 0*C;
A_hat = A + delta_A;
B_hat = B + delta_B;
C_hat = C + delta_C;

%luenberger obs:
%z_dot = A z + B u + H (y - C z)

%gain
H=place(A',C',eig_H)'

A_lu = A_hat-H*C_hat

B_lu = [B_hat H]

C_lu = eye(size(A_hat))

D_lu = zeros(size(C_lu,1),size(B_lu,2))


%certainty-equivalence state-feedback controller

K=place(A,B,eig_K)