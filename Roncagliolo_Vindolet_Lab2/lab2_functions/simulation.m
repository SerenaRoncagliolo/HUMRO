function [ ] = simulation( t,z,ok)
%% This function creates an animation of the motion of the hummanoid robot
%% by drawing lines between points in the robots links as these points move in time
%% The points are rotates due to the fact that the robot is operating on a slope theta degrees
%% to the horizontal refrence frame
global I s theta l m g
L=l;

if ok	 
   for k = 1:length(t)

    hold off
        plot([0 -L*sin(z(k,1))],[0 L*cos(z(k,1))])
        hold on
        plot([-L*sin(z(k,1)) -L*sin(z(k,1))-L*sin(z(k,1)+z(k,2))],[L*cos(z(k,1))  L*cos(z(k,1))+L*cos(z(k,1)+z(k,2))])
        yline(0);
        axis("equal")
        pause(0.02)
    end

end
end
