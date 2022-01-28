function [z_afterImpact] = impactModel(ze)
%% Robot and slope characteristics
global I s theta l m g q1_init q2_init
%% rotation matrix
E=[0,-1;1,0];

%% Initial state
% q1 = 0.1860; % decomment for running the main
% q2 = 2.7696;

% q1 = -0.1860+2*pi; % decomment for running case 1
% q2 = -pi -2*q1;
%% unitary vectors of both legs
u1=[-sin(q1_init);cos(q1_init)]; %leg1
u2=[-sin(q1_init+q2_init);cos(q1_init+q2_init)]; %leg2

%% impact model: M*X_afterImpact = N*X_beforeImpact
[A1,Jr2]=function_impact(ze(1),ze(2));%(q1,q2)=(ze(1),ze(2)) is the state just before impact

%% compute state before impact X=[Xd,Yd,Q1d,Q2d] Pd=[Xd,Yd]=velocity of the hip 
X_beforeImpact=zeros(4,1);
Pd=l*E*ze(3)*u1; %(xd;yd)=l*E*q1d*u1
X_beforeImpact(1,1)=Pd(1,1);
X_beforeImpact(2,1)=Pd(2,1);
X_beforeImpact(3,1)=ze(3);
X_beforeImpact(4,1)=ze(4);

%% building M
M=zeros(6);
Jr2t=Jr2';
for i=1:4
    for j=1:4
        M(i,j)=A1(i,j);
    end
end

for i=1:4
    for j=5:6
        M(i,j)=-Jr2t(i,j-4);
    end
end

for i=5:6
    for j=1:4
        M(i,j)=Jr2(i-4,j);
    end
end
%% compute N matrix
N=zeros(6,4);
for i=1:4
    for j=1:4
        N(i,j)=A1(i,j);
    end
end
%% compute state after impact
X_afterImpact=inv(M)*N*X_beforeImpact; % 6*1 matrix vector column 

%% compute q1 and q2 after impact; same as before impact
q1=ze(1);
q2=ze(2); 

%% relabeling
q1=pi+q1+q2;
q2=-q2;


%% z_afterImpact
z_afterImpact=zeros(4,1);
z_afterImpact(1,1)=q1;
z_afterImpact(2,1)=q2;
z_afterImpact(3,1)=X_afterImpact(3,1)+X_afterImpact(4,1);
z_afterImpact(4,1)=-X_afterImpact(4,1);
end

