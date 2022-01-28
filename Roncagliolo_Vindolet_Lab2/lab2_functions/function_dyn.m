function [A,H] = function_dyn(q1,q2,q1d,q2d)

global I s theta l m g

%rotation matrix
E=[0 -1; 1 0];

qd=[q1d;q2d];
g1=9.8*[sin(theta);-cos(theta)];
%code
u1=[-sin(q1);cos(q1)];
u2=[-sin(q1+q2);cos(q1+q2)];
G1=(l-s)*u1;
G2=l*u1+s*u2;
VG1=(l-s)*q1d*E*u1;
VG2=l*q1d*E*u1+s*(q1d+q2d)*E*u2;
WG1=q1d;
WG2=q1d+q2d;
Ec1=0.5*(m*(VG1')*VG1+WG1'*I*WG1);
Ec2=0.5*(m*(VG2')*VG2+WG2'*I*WG2);
E=Ec1+Ec2;

a1=(m*(s-l)^2+2*I+m*l^2+2*m*l*s*cos(q2)+m*s^2);
a2=(m*l*s*cos(q2)+m*s^2+I);
a3=a2;
a4=m*s^2+I;
A=[a1,a2;a3,a4];

%Q1=9.8*m*(2*l-s)*sin(theta-q1)+9.8*m*s*sin(theta-q1-q2);
%Q2=9.8*m*s*sin(theta-q1-q2);

b1=-2*m*l*s*sin(q2);
b2=0;
B=[b1;b2];

c11=0;
c12=-m*l*s*sin(q2);
c21=m*l*s*sin(q2);
c22=0;
C=[c11,c12;c21,c22];

qdqd=q1d*q2d;
qd2=[q1d^2; q2d^2];
H=B*qdqd+C*qd2;
U1=-m*g1'*G1;
U2=-m*g1'*G2;

end
