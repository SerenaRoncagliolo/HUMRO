%% The main program to call fmincon

    % Write the main program. At the beginning of this program we can define the physical
    % parameters. 
    %The initial set of optimization variables should be defined. 
    %You can define the instruction to call fmincon. After by using the solution for the optimization
    % variables you can plot the interesting variables. The number of optimization
    % variables must be determined considered that you want to design a periodic walking
    % gait with the compass biped. Another problem is to choose which optimization
    % variables.
    
%(a) global any parameters you need : masses, inertia, etc.
global l m I s theta
global gt gteq
l=0.8; %lenght leg 1 and leg 2
m=2; %mass leg 1 and leg 2
I=0.1; %inertia
s=0.5;
theta= 3*pi/180;
%Step duration
T = 1;

% Initial Parameters
q1 = -0.1860;
q2 = pi - 2*q1; %condition when in DT
q1d = -2.0504;
q2d = -0.0428;


%Solver

%(b) Jsolcons0 = [ ? ? ? ? ?] ; initial optimization variables
Jsolcons0 = [ q1 q2 q1d q2d t] ;
%(c) Call to fmincon
    lb = [-pi/2 -2*pi -10 -10 0 ];
    %i. lb = [ q1_max q2_max q1d_max q2d_max t_min] ;
    ub = [+pi/2 +2*pi +10 +10 T ];
    %ii. ub = [ q1_min q2_min q1d_min q2d_min t_min] ;
    %iii. options = optimset(’Display’,’iter’,’MaxFunEvals’, ? ?,’MaxIter’, ? ?,’LargeScale’,’off’) ;
    %'iter' displays output at each iteration
    %MaxFunEvals=Maximum number of function evaluations allowed.
    %MaxIter=Maximum number of iterations allowed.
    %[Jsolcons,Fval,EXITFLAG] = fmincon("resol",Jsolcons0,Equality(A),Equality(b),Inequality(Aeq),Inequality(beq),lb,ub,"constraint",options) ;
    [Jsolcons,Fval,EXITFLAG] = fmincon("resol",Jsolcons0,[],[],[],[],lb,ub,"constraint",options) ;
 % corresponding to x = fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon,options)
 