function [gt,gteq]=constraint(Jsolcons)
global gt gteq
%%The program constraint taking into account the constraints.
c(1) = 0.2 - Lstep;
c(2) = -R(1);
c(3) = -R(2);
c(4) = 0.7 - R(1)/R(2);
c(5) = 0.7 - Ix/Iy;
c(6) = 3 - q1d;
c(7) = 50 - Gamma(1);
c(8) = 50 - Gamma(2);
gt=[c(1);c(2);c(3);c(4);c(5);c(6);c(7);c(8)];
gteq = [] ;
return