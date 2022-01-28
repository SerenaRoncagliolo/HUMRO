close all;
clear all;
clc;
%% Robot and slope characteristics
global I s theta l m g t_ z_ q1_init q2_init
case_ = 1;
if (case_ == 1)
    % case 1
    %global I s theta l m g 
    s = 0.5;
    l = 0.8;
    m = 2;
    I = 0.1;
    g = 9.81;
    theta = 3*pi/180;
    
    % Initial values
    q1_init = -0.1860;
    q1d = -2.0504;
    q2d = -0.0428;
    
    
elseif (case_ == 2)
    % case 2
    %global I s theta l m g
    s = 0.45;
    l = 0.8;
    m = 2;
    I = 0.08;
    g = 9.81;
    theta = 3*pi/180;
    
    % Initial values
    q1_init = -0.1933;
    q1d = -2.0262;
    q2d = -0.1253;
    
end


%Configuration at double support => swinging foot touches the ground =>
%q1n=-q1 => sum angles = pi = -q1 -q1 -q2 => q2 = -pi -2q1
q2_init = -pi -2*q1_init;

%% Periodic Motion
%objective : Passive cyclic motion on slope + stability around a defined
%point defined in Poincaré return map
%Variables to define: initial config in double support and inital velocity
%% Poincaré return map
% cyclic motion = fixed point in Poincaré return map
% Poincaré defined just BEFORE impact (arbitrary)

X0 = [q1_init;q1d;q2d];
options = optimset('display','iter','MaxFunEvals',1000,'TolX', 1.0e-010,'TolFun', 1.0e-006);
X = fsolve('test_periodic',X0,options);

%% simulate one step starting from X
q1_init=X(1);
q2_init=-pi-2*X(1);
  
X=P(X)';
% q1 = X(1);
% q2 = -pi-2*q1;
% qd1 = X(2);
% qd2 = X(3);
simulation(t_,z_,true); %true to see the simulation
joint_evolution(z_,true);
