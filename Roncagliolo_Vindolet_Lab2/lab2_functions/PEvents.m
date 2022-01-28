function [VALUE,ISTERMINAL,DIRECTION]=PEvents(t,z)
global I s theta l m g

Y_swingingFoot=l*cos(z(1))+l*cos(z(1)+z(2));
X_swingingFoot=-l*(sin(z(1))+sin(z(1)+z(2)));
if X_swingingFoot > 0.1 % doesn't stop if both legs in 0,0
    
    VALUE = Y_swingingFoot;% the heigth of the leg tip 

else 
    VALUE = 1; % must be positive
end
ISTERMINAL=1;
DIRECTION=-1; % 0or -1

% %% This function is used to test the integration
% %% to detect when an event occurs and therefore stop the integration.
% %% Its returns parameters used by ode45
% 
end