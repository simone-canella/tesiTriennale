%--------------------
%SYSTEM'S PARAMETERS [parametri del sistema]:
%--------------------

M = 0.5         %cart mass [massa del carrello]
M_nominal = M
m = 0.1         %sphere mass [massa estremità del asta]
m_nominal = m
g = 9,80665     %gravity acceleration [accelerazione gravità]
L = 0.3         %rod length [lunghezza asta]
L_nominal = L

%--------------------
%STATE EQUATIONS [matrici di stato]:
%--------------------
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

D = zeros(size(C,1),size(B,2)) % [sistema strettamente proprio]

dimx = size(A,1) % A dimention [dimensione matrice quadrata "A"]
dimu = size(B,2) % B column [numero colonne matrice "B"]
dimy = size(C,1) % C row [numero righe matrice "C"]

%--------------------
%INITIAL CONDITIONS SYSTEM(state) AND OBSERVER(estimated state) [condizioni iniziali sistema e osservatore]
%--------------------

x0 = [.5;               %initial cart position (meter) [posizione iniziale del carrello]
      .1;               %initial cart speed (meter/s) [velocità iniziale del carrello]
      20*(pi/180);       %initial rod angle ("degree" *pi/180 = radiants) [angolo iniziale dell'asta]
      .1*(pi/180)]      %initial rod angular speed ("degree/seconds" *pi/180 = radiants/seconds) [velocità angolare asta]

z0 = [-.5;              %initial estimated cart position (meter) [posizione iniziale del carrello]
      -.31;             %initial estimated cart speed (meter/s) [velocità iniziale del carrello]
      10*(pi/180);    %initial estimated rod angle ("degree" *pi/180 = radiants) [angolo iniziale dell'asta]
      .11*(pi/180)]     %initial estimatedrod angular speed ("degree/seconds" *pi/180 = radiants/seconds) [velocità angolare asta]
 
% x0 = [0 0 0 0]';      % [punto di equilibrio]
%z0 = x0                % [stato stimato iniziale uguale stato del sistema]

%--------------------
%DESIRED EIGENVALUES [autovalori desiderati]
%--------------------

eig_H = 2*[-1 -2 -2.5 -1.5] % [autovalori desiderati ossevatore]
eig_K = 1*[-1 -2 -2.5 -1.5] % [autovalori desiderati controllore]

%--------------------
%GAIN OBSERVER AND CONTROLLER [guadagno osservatore e controllore]
%--------------------

H=place(A',C',eig_H)'

K=place(A,B,eig_K)

%--------------------
%LUENBERGER OBSERVATOR [osservatore di Luenberger]
%--------------------

%z_dot = A z + B u + H (y - C z)

%approximate plant

delta_A = 0*A; % measurement error [errore di misura]
delta_B = 0*B; % measurement error [errore di misura]
delta_C = 0*C; % measurement error [errore di misura]
A_hat = A + delta_A; 
B_hat = B + delta_B;
C_hat = C + delta_C;

A_lu = A_hat-H*C_hat 

B_lu = [B_hat H]

C_lu = eye(size(A_hat))

D_lu = zeros(size(C_lu,1),size(B_lu,2))

%--------------------
%TO REVIEW [da controllare]
%--------------------
C_x = eye(size(A))
D_x = zeros(size(C_x,1),size(B,2))