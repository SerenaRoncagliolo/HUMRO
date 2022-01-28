function [Q]=gravity_effect(z)
global  s theta l m g
Q1=-m*g*((2*l-s)*sin(z(1)-theta)+s*sin(z(1)+z(2)-theta));
Q2=-m*g*s*sin(z(1)+z(2));
Q=[Q1;Q2];
end