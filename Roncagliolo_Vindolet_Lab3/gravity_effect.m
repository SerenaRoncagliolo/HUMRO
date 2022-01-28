function [Q1,Q2]=gravity_effect(z)
l=0.8; %lenght leg 1 and leg 2
m=2; %mass leg 1 and leg 2
I=0.1; %inertia
s=0.5; %distance between G and the hip
g=9.81;
theta=3*pi/180;
Q1=-m*g*((2*l-s)*sin(z(1)-theta)+s*sin(z(1)+z(2)-theta));
Q2=-m*g*s*sin(z(1)+z(2));

end