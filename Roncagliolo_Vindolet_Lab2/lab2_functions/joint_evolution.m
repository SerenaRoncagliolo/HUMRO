function [] = joint_evolution(z,ok)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
if ok
    hold on
    axis("equal")

        subplot(2,1,1);
        plot(z(:,1),z(:,3),'-o');
        subplot(2,1,2)
        plot(z(:,2),z(:,4),'-o');

        pause(0.02)
   
end
end

