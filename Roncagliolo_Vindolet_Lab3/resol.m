function Criteria=resol(Jsolcons)
global gt gteq
%% definition of polynomial functions
%initial conditions
q1_0 = 90 *pi/180;
q2_0 = 90 *pi/180;
q1d_0 = q1d_after;
q2d_0 = q2d_after;

%final conditions
q1_f = -90 *pi/180;
q2_f = -90 *pi/180;
q1d_f = q1d;
q2d_f = q2d;

%mid conditions (we don't know the time, but is when both legs are
%coincident)
q1_m = 0 *pi/180;
q2_m = 180 *pi/180;
%q1d_m = 0;
%q2d_m = 0;

%input calculation through polinomials
syms a0 a1 a2 a3 a4 a5
syms b0 b1 b2 b3 b4 b5
%position equations
%position equations
%q1
eq1=a0*0^5+a1*0^4+a2*0^3+a3*0^2+a4*0+a5==q1_0;
eq2=a0*final_time^5+a1*final_time^4+a2*final_time^3+a3*final_time^2+a4*final_time+a5==q1_f;
eq3=a0*mid_time^5+a1*mid_time^4+a2*mid_time^3+a3*mid_time^2+a4*mid_time+a5==q1_m;
%q2
eq4=a0*0^5+a1*0^4+a2*0^3+a3*0^2+a4*0+a5==q2_0;
eq5=a0*final_time^5+a1*final_time^4+a2*final_time^3+a3*final_time^2+a4*final_time+a5==q2_f;
eq6=a0*mid_time^5+a1*mid_time^4+a2*mid_time^3+a3*mid_time^2+a4*mid_time+a5==q2_m;

%velocity equations
%q1
eq7=b0*5*0^4+b1*4*0^3+3*b2*0^2+2*b3*0+b4==q1d_0;
eq8=b0*5*final_time^4+b1*4*final_time^3+3*b2*final_time^2+2*b3*final_time+b4==q1d_f;
eq9=b0*5*mid_time^4+b1*4*mid_time^3+3*b2*mid_time^2+2*b3*mid_time+b4==q1d_m;
%q2
eq10=b0*5*0^4+b1*4*0^3+3*b2*0^2+2*b3*0+b4==q2d_0;
eq11=b0*5*final_time^4+b1*4*final_time^3+3*b2*final_time^2+2*b3*final_time+b4==q2d_f;
eq12=b0*5*mid_time^4+b1*4*mid_time^3+3*b2*mid_time^2+2*b3*mid_time+b4==q2d_m;


%% impact equation
[A1,JR2] = function_impact(q1,q2);
Post_vel = inv([A1 -JR2' ; JR2  zeros(2)])*[A1 ; zeros(2) zeros(2)]*[ cos(q1 + theta)*(s - l)*q1d ;
                                                                      sin(q1 + theta)*(s - l)*q1d ;
                                                                      q1d ;
                                                                      q2d ];
%% Computation of the inverse dynamique system
Hg=[0;0];
[Q1,Q2]=gravity_effect(z);
Hg(1)=Q1;
Hg(2)=Q2;
[A,H]=function_dyn(z(1),z(2),z(3),z(4),theta);
qadd=-inv(A)*(H+Hg);
q1dd=qadd(1);
q2dd=qadd(2);


R =function_reactionforce(q1,q2,q1d,q2d,q1dd,q2dd);
Gamma=A+H+Hg;

u1=[-sin(q1);cos(q1)]; %leg1
u2=[-sin(q1+q2);cos(q1+q2)]; %leg2
l=0.8;
delta=T/100;
Lstep=(l*u1+l*u2);
Lstep=Lstep(1);


%% Computation of the criterion C and nonlinear constraints
C = 1/Lstep *symsum(Gamma^2*delta,k,1,100);
gteq = [] ;
return