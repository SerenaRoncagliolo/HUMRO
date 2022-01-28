function [Y] = P(X)
%Poincaré return map X(k+1) = P(X(k))
%% Robot and slope characteristics
global I s theta l m g t_ z_ q1_init q2_init


%% rotation matrix



%% inital state z

q1=q1_init;
q2=q2_init;

qd1 = X(2);
qd2 = X(3);

X0 = [q1 qd1 qd2]';% save initial value
z0 = [q1 q2 qd1 qd2]';% save initial value

%% Differential equation
% options = odeset('Events',@PEvents);
% [t,z,te,ze] = ode45(@SS_passif,[0:0.02:10],z0,options); % solve differential equation
% %% Simulation
% simulation(t,z,true) %true to see the simulation
%% Impact model
z_afterImpact=impactModel(z0);
%% Next half step differential equation
z0 = z_afterImpact; % save initial value
options = odeset('Events',@PEvents);
[t,z,te,ze] = ode45(@SS_passif,[0:0.002:10],z0,options); % solve differential equation
%% NExt half step simulation => put in a loop to have more steps
%simulation(t,z,true) %true to see the simulation
% z_out=transpose(z(end,:));
% z_out(1)=mod(z_out(1),-2*pi);
% z_out(2)=mod(z_out(2),-2*pi);
% z(:,1)=mod(z(:,1),2*pi); % Not needed for every z ? 
% z(:,2)=mod(z(:,2),2*pi);
%ze(1) = mod(ze(1),2*pi);
%ze(2) = mod(ze(2),2*pi);

%To print : 
t_ = [ t_ ; t];
z_ = [ z_ ; z];

% state variable X extraction
q1 = ze(1);
q1d = ze(3);
q2d = ze(4);
% q1 = z_out(1);
% q1d = z_out(3);
% q2d = z_out(4);
Y=[q1 q1d q2d];
end

