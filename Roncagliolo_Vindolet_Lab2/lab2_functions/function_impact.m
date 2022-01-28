%% HUMRO - Dynamic modeling of a compass
% Camille Vindolet, Serena Roncagliolo

%%function
function [A1,Jr2] = function_impact(q1,q2)

%parameters
global I s theta l m g
M=2*m;

%matrix A
a11=2*m;
a12=0;
a13=0.5*(2*s*m*cos(q1)-2*m*s*cos(q1+q2));
a14=0.5*(-2*m*s*cos(q1+q2));
a21=a12;
a22=2*m;
a23=0.5*(2*m*s*sin(q1)-2*m*s*sin(q1+q2));
a24=0.5*(-2*m*s*sin(q1+q2));
a31=a13;
a32=a23;
a33=2*m*s^2+2*I;
a34=0.5*(2*I+2*m*s^2);
a41=a14;
a42=a24;
a43=a34;
a44=m*s^2+I;
A1=[a11,a12,a13,a14;
a21,a22,a23,a24;
a31,a32,a33,a34;
a41,a42,a43,a44];

%matrix J2R
j1=-l*cos(q1+q2);
j2=-l*sin(q1+q2);
Jr2=[j1,j1,1,0;j2,j2,0,1];
end
