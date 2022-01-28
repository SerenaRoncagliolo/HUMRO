%% HUMRO - Dynamic modeling of a compass
% Camille Vindolet, Serena Roncagliolo

%% function
function [A,H] = function_dyn(q1,q2,q1d,q2d,theta)

%given parameters
l=0.8; %lenght leg 1 and leg 2
m=2; %mass leg 1 and leg 2
I=0.1; %inertia
s=0.5; %distance between G and the hip

%rotation matrix
E=[0 -1; 1 0];

qd=[q1d;q2d];
%gravity express in reference frame X,Y
g=9.81*[sin(theta);-cos(theta)]; 

%versors 
u1=[-sin(q1);cos(q1)]; %leg1
u2=[-sin(q1+q2);cos(q1+q2)]; %leg2

%position mass centers 
G1=(l-s)*u1;
G2=l*u1+s*u2;

%linear velocity mass centers 
VG1=(l-s)*q1d*E*u1;
VG2=l*q1d*E*u1+s*(q1d+q2d)*E*u2;

%angular velocity mass centers 
WG1=q1d;
WG2=q1d+q2d;

%Kinetic Energies
Ec1=0.5*(m*VG1'*VG1+WG1'*I*WG1);
Ec2=0.5*(m*VG2'*VG2+WG2'*I*WG2);

%Total Kinetic Energy
E=Ec1+Ec2;

%Inertia matrix A
a1=(m*(s-l)^2+2*I+m*l^2+2*m*l*s*cos(q2)+m*s^2+I);
a2=(m*l*s*cos(q2)+m*s^2+I);
a3=a2;
a4=m*s^2+I;

A=[a1,a2;a3,a4];

%potential energies
U1=-m*g'*G1;
U2=-m*g'*G2;

%gravity effect
Q1=9.8*m*(2*l-s)*sin(theta-q1)+9.8*m*s*sin(theta-q1-q2);
Q2=9.8*m*s*sin(theta-q1-q2);

%COMPUTE VECTOR H
%matrix B
b1=-2*m*l*s*sin(q2);
b2=0;
B=[b1;b2];
%matrix C
c11=0;
c12=-m*l*s*sin(q2);
c21=m*l*s*sin(q2);
c22=0;
C=[c11,c12;c21,c22];
%qdqd
qdqd=q1d*q2d;
%qdqd^2
qd2=[q1d^2; q2d^2];
%vector H
H=B*qdqd+C*qd2;

end
