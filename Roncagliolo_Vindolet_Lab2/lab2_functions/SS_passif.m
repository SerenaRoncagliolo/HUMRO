function zdot = SS_passif(t,z)
global I s theta l m g

Q=[0;0];
Q=gravity_effect(z);
[A,H]=function_dyn(z(1),z(2),z(3),z(4));
qadd=-inv(A)*(H+Q);
q1dd=qadd(1);
q2dd=qadd(2);
q1d=z(3);
q2d=z(4);
zdot=[q1d;q2d;q1dd;q2dd];

end
