function [A,H,Hg] = function_dyn2(q1_,q2_,q1d_,q2d_,theta_)
%% Exercise 1
%list of variables
syms q1 q2 q1d q2d q1dd q2dd theta l m I S g x y xd yd

%constant variables
l_=0.8; m_=2; I_=0.1; S_=0.5; g_=9.81;

%g_ = g_*[sin(theta);-cos(theta)];

%Frame 0 to frame to G1
OG1 = Rot('z',theta)*Rot('z',q1)*Trans(0,(l-S),0);
X1 = simplify([OG1(1,4) ; OG1(2,4)]);
X1d = simplify([diff(X1(1),q1) diff(X1(1),q2) ; diff(X1(2),q1) diff(X1(2),q2)]);

%Frame 0 to frame to G2
OG2 = Rot('z',theta)*Rot('z',q1)*Trans(0,l,0)*Rot('z',q2)*Trans(0,S,0);
X2 = simplify([OG2(1,4) ; OG2(2,4)]);
X2d = simplify([diff(X2(1),q1) diff(X2(1),q2) ; diff(X2(2),q1) diff(X2(2),q2)]);

%Velocities
V = [ X1d(1,1) X1d(1,2) ; X1d(2,1) X1d(2,2) ; 1 0 ; X2d(1,1) X2d(1,2) ; X2d(2,1) X2d(2,2) ; 1 1 ];
VT = V';

%A
A = VT * [diag([m;m;I;m;m;I])] * V;

%Hg
U1 = -m*X1(2)*g;
U2 = -m*X2(2)*g;
Q1 = [diff(U1,q1) ; diff(U1,q2)];
Q2 = [diff(U2,q1) ; diff(U2,q2)];
Hg = Q1 + Q2;

%B and C
B = [diff(A(1,1),q2)+diff(A(1,2),q1)-diff(A(1,2),q1) ; diff(A(2,1),q2)+diff(A(2,2),q1)-diff(A(1,2),q2)];
C = [diff(A(1,1),q1)-1/2*diff(A(1,1),q1) diff(A(1,2),q2)-1/2*diff(A(2,2),q1); diff(A(2,1),q1)-1/2*diff(A(1,1),q2) diff(A(2,2),q2)-1/2*diff(A(2,2),q2)];

%H
H = B*[q1d*q2d] + C*[q1d*q1d ; q2d*q2d];


%replace syms values for numerical values
A = double(subs(A,[l,m,I,S,g,q1,q2,q1d,q2d,theta],[l_,m_,I_,S_,g_,q1_,q2_,q1d_,q2d_,theta_]));
H = double(subs(H,[l,m,I,S,g,q1,q2,q1d,q2d,theta],[l_,m_,I_,S_,g_,q1_,q2_,q1d_,q2d_,theta_]));
Hg = double(subs(Hg,[l,m,I,S,g,q1,q2,q1d,q2d,theta],[l_,m_,I_,S_,g_,q1_,q2_,q1d_,q2d_,theta_]));

end


%% Sub functions
function M = Rot(axis,m)
if axis == 'x'
M =    [1    0      0      0;
        0 cos(m) -sin(m) 0;
        0 sin(m) cos(m)  0;
        0    0      0      1 ];
elseif axis == 'y'
M =     [cos(m)  0 sin(m)   0;
           0     1    0     0;
        -sin(m)  0 cos(m)   0;
           0     0    0     1 ];
elseif axis == 'z'
M =     [cos(m) -sin(m) 0 0;
         sin(m)  cos(m) 0 0;
           0        0     1 0;
           0        0     0 1 ]; 
end
end

function M = Trans(x,y,z)
M =     [ 1 0 0 x ;
          0 1 0 y ;
          0 0 1 z ;
          0 0 0 1 ];
end