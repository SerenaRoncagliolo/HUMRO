clc
clear all
close all
%% Robot and slope characteristics
global I s theta l m g q1_init q2_init

l = 0.8;
m = 2;
I = 0.1;
s = 0.5;
g = 9.81;
theta = 3*pi/180;



%% rotation matrix
E=[0,-1;1,0];

%% inital state z
q1_init = 0.1860;
q2_init = 2.7696;
q1 = 0.1860;
q2 = 2.7696;
qa=[q1;q2];
qd1 = -1.4281;
qd2 = 0.3377;
qad=[qd1;qd2];
z0 = [q1 q2 qd1 qd2]';% save initial value
%% unitary vectors of both legs
u1=[-sin(q1);cos(q1)]; %leg1
u2=[-sin(q1+q2);cos(q1+q2)]; %leg2
%P=l*u1;
%% Differential equation
options = odeset('Events',@PEvents);
[t,z,te,ze] = ode45(@SS_passif,[0:0.02:10],z0,options); % solve differential equation
%% Simulation
simulation(t,z,true) %true to see the simulation
%% Impact model
z_afterImpact=impactModel(ze);
%% Next half step differential equation
z0 = z_afterImpact; % save initial value
[t,z,te,ze] = ode45(@SS_passif,[0:0.02:10],z0,options); % solve differential equation
%% NExt half step simulation => put in a loop to have more steps
simulation(t,z,true) %true to see the simulation


% %% The periodic passive motion on a slope
% %A cyclic motion is a fixed point of the Poincaré return map.
% %2 angles that differ from 2p are equal: q1=mod(q1+q2+pi,2*pi)
% %q1=mod(q1,2*pi)
% 
%     %% Used functions
%     
%         %% [x,fval,exitflag,output]=fminsearch(fun,x0,options)
%         %fminsearch = Find minimum of unconstrained multivariable function using derivative-free method
%         %starts at the point x0 and attempts to find a local minimum x of the function described in fun
%         %minimizes with the optimization options specified in the structure options. Use optimset to set these options.
%         %returns in fval the value of the objective function fun at the solution x
%         %additionally returns a value exitflag that describes the exit condition
%         %additionally returns a structure output with information about the optimization process
%         
%         %% options = OPTIMSET ('display','iter','MaxFunEvals',1000,'TolX', 1.0e-010,'TolFun', 1.0e-006);
%         %OPTIMSET Create or edit optimization options structure
% 
%         %% X = fsolve('test_periodic',X0,options) 
%         % with f=test_ periodic(X); 
%         %Starting from initial optimization variables X0, it will find the state X that minimize f. f is P(X*)- X*.
%         %starts at x0 and tries to solve the equations fun(x) = 0, an array of zeros.
%     %% Define a fixed point X by optimization technique
%     % Case 1
%         q1 = -0.1860;
%         q1 = mod(q1,2*pi);
%         q1d = -2.0504;
%         q2d = -0.0428;
%         X0 = [q1;q1d;q2d];
%         options = optimset('display','iter','MaxFunEvals',1000,'TolX', 1.0e-010,'TolFun', 1.0e-006);
%         X = fsolve('test_periodic',X0,options);
%         %% simulate one step starting from X
%          X=P(X);
%         %% Show the joint evolution in a phase plan
%         % see in P
%      % Case 2
%         q1 = -0.1933;
%         q1 = mod(q1,2*pi);
%         q1d = -2.0262;
%         q2d = -0.1253;
%         X0 = [q1;q1d;q2d];
%         options = optimset('display','iter','MaxFunEvals',1000,'TolX', 1.0e-010,'TolFun', 1.0e-006);
%         X = fsolve('test_periodic',X0,options);
%         %% simulate one step starting from X
%          X=P(X);
%         %% Show the joint evolution in a phase plan
%         % see in P    
%     
% %% Stability analysis
% %A periodic motion is stable, if starting close to the periodic motion, the motion will converge to the
% %periodic one. A periodic motion is unstable, if starting close to the periodic motion, the motion will
% %moves away from the periodic one.
% %The eigenvalues of the Jacobian of the Poincaré map is a tool to check the stability of a fixed point.