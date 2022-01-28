%% HUMRO - Dynamic modeling of a compass
% Camille Vindolet, Serena Roncagliolo

%% function
function [F] = function_reactionforce(q1,q2,q1d,q2d,q1dd,q2dd)

%parameters
m=2;
l=0.8;
I=0.1;
s=0.5;
M=2*m;
theta=2*pi/180;

%rotation matrix E
E=[0 -1; 1 0];

%gravity express in reference frame X,Y
g=9.81*[sin(theta);-cos(theta)];

%versors
u1=[-sin(q1);cos(q1)];
u2=[-sin(q1+q2);cos(q1+q2)];

%position mass centres
G1=(l-s)*u1;
G2=l*u1+s*u2;

%position hip G
G=0.5*(G1+G2);

%velocity mass centres
G1d=(l-s)*q1d*E*u1;
G2d=l*q1d*E*u1+s*(q1d+q2d)*E*u2;

%velocity hip G
Gd=0.5*(G1d+G2d);

%acceleration mass centres
G1dd=-(l-s)*(q1d^2)*u1+(l-s)*q1dd*E*u1;
G2dd=-l*(q1d^2)*u1-s*(q2d+q1d)^2*u2+l*q1dd*E*u1+s*(q1dd+q2dd)*E*u2;

%acceleration hip G
Gdd=0.5*(G1dd+G2dd);

%REACTION FORCE
F=M*Gdd-M*g;
end