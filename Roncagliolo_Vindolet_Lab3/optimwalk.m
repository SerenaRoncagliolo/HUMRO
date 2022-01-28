function [q1d_after,q2d_after] = optimwalk(z,t)

theta= 3*pi/180;
q1=z(1);
q2=z(2);
q1d=z(3);
q2d=z(4);
[A1,JR2] = function_impact(q1,q2);
Post_vel = inv([A1 -JR2' ; JR2  zeros(2)])*[A1 ; zeros(2) zeros(2)]*[ cos(q1 + theta)*(s - l)*q1d ;
                                                                      sin(q1 + theta)*(s - l)*q1d ;
                                                                      q1d ;
                                                                      q2d ];
                                                                  
q1d_after=Post_vel(3);
q2d_after=Post_vel(4);







end