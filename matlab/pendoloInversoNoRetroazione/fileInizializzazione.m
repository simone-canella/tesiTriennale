%--------------------
%SYSTEM'S PARAMETERS [parametri del sistema]:
%--------------------

M = 0.5         %cart mass [massa del carrello]
m = 0.1         %sphere mass [massa estremità del asta]
g = 9,80665     %gravity acceleration [accelerazione gravità]
L = 0.3         %rod length [lunghezza asta]

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
% x0 = [0 0 0 0]';      % [punto di equilibrio]

