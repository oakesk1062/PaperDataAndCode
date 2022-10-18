function [MassInertia,Cq,L] = MCgen_floatingbase(q,qdot,robot_const,V0)
%% added capability to have symbolic input on 1/28/2021 at 11pm
% This function computes the Mass-Inertia, centrifugal/Coriolis terms, and
% mapping from external forces to the floating base forces/joint torques
% for the full floating base dynamic model.
%
% Inputs:
% q: joint positions
% robot_kin: robot parameters structure
% V0: base veloicty

% Outputs:
% MassInertia: Mass-inertia matrix 
% Cq: Coriolis/centrifugal forces
% L: matrix mapping external force (in end effector frame) to floating base
%   and joints
%
% Model is of the form: M*[alpha_b;qddot] + C + L*f_{ext} = [fb;tau];
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Extract info from robot parameters structure
h = robot_const.kin.H; 
p = robot_const.kin.P;
I = robot_const.mprops.I;
m = robot_const.mprops.m;
c = robot_const.mprops.c;
N = robot_const.mprops.N;

% Generate H, PHI block matrices
H1 = [h(:,1); 0;0;0]; H2 = [h(:,2); 0;0;0]; H3 = [h(:,3); 0;0;0]; 
H4 = [h(:,4); 0;0;0]; H5 = [h(:,5); 0;0;0]; H6 = [h(:,6); 0;0;0]; 
H7 = [h(:,7); 0;0;0];

H = [eye(6), zeros(6,7); zeros(6) H1 zeros(6); zeros(6,7) H2 zeros(6,5); ...
    zeros(6,8) H3 zeros(6,4); zeros(6,9) H4 zeros(6,3); ...
    zeros(6,10) H5 zeros(6,2); zeros(6,11) H6 zeros(6,1); zeros(6,12) H7];

PHI_arm = phi_gen(q,h,p);
sz = size(PHI_arm);
PHI = zeros(sz(1)+6,sz(2));
if isa(q,'sym')
    PHI = sym(PHI);
end
PHI(7:end,7:end) = PHI_arm(:,7:end);
PHI(1:6,1:6) = eye(6);

P = robot_const.bprops.PB0 + robot_const.bprops.RB0*p(:,1);
R = robot_const.bprops.RB0*rot(h(:,1),q(1));

for k = 2:length(q)+1
    PHI((k*6 - 5):(k*6),1:6) = [R', zeros(3); -R'*hat(P), R'];
    if k ~=length(q)+1
        P = P + R*p(:,k);
        R = R*rot(h(:,k),q(k));
    end
end

% Propogate spatial velocity and generate M matrices
V = zeros(6,8);
if isa(q,'sym')
    V = sym(V);
end
Vtemp = V0;
Vprev = V0;
a = zeros(6,8);
b = zeros(6,8);
M = zeros(6,6,8);
if isa(q,'sym')
    a = sym(a);
    b = sym(b);
    M = sym(M);
end

V(:,1) = Vtemp;
a(:,1) = zeros(6,1);
b(:,1) = [hat(V0(1:3))*robot_const.bprops.I*V0(1:3);...
    robot_const.bprops.m*hat(V0(1:3))*hat(V0(1:3))*robot_const.bprops.c];
M(:,:,1) = [robot_const.bprops.I, ...
    robot_const.bprops.m*hat(robot_const.bprops.c); ...
    -robot_const.bprops.m*hat(robot_const.bprops.c), robot_const.bprops.m*eye(3)];

Vtemp = [robot_const.bprops.RB0', zeros(3); ...
    -robot_const.bprops.RB0'*hat(robot_const.bprops.PB0), robot_const.bprops.RB0']*Vtemp;
Vprev = Vtemp;


for k = 1:7
    
   PHI_TEMP = PHI_arm((6*(k) - 5):(6*(k)),(6*(k) - 5):(6*(k)));
   Htemp = H((6*(k) - 5)+6:(6*(k))+6,k+6);
   Vtemp = PHI_TEMP*Vtemp + Htemp*qdot(k);
   V(:,k+1) = Vtemp;
   
   R = rot(h(:,k),q(k));
   
   a(:,k+1) = [hat(R'*Vprev(1:3))*(Vtemp(1:3));...
        R'*hat(Vprev(1:3))*(hat(Vprev(1:3))*p(:,k))];
   Vprev = Vtemp;
   
   b(:,k+1) = [hat(Vtemp(1:3))*I(:,:,k)*Vtemp(1:3); ...
        m(k)*hat(Vtemp(1:3))*hat(Vtemp(1:3))*c(:,k)];
    
    M(:,:,k+1) =  [I(:,:,k) m(k)*hat(c(:,k)); ...
        -m(k)*hat(c(:,k)) m(k)*eye(3,3)];
end

% Solve for Mass Inertia matrix

M_NE = zeros(48,48);
M_NE(1:6,1:6) = M(:,:,1); M_NE(7:12,7:12) = M(:,:,2); 
M_NE(13:18,13:18) = M(:,:,3); M_NE(19:24,19:24) = M(:,:,4);
M_NE(25:30,25:30) = M(:,:,5); M_NE(31:36,31:36) = M(:,:,6); 
M_NE(37:42,37:42) = M(:,:,7); M_NE(43:48,43:48) = M(:,:,8);

MassInertia = H'*PHI'*M_NE*PHI*H;

% Solve for Coriolis/Centrifugal terms
Cq = H'*PHI'*(M_NE*PHI*a(:) + b(:));

B = zeros(6*8,6);
B(43:48,:) = [eye(3), zeros(3); -hat(robot_const.kin.P(:,end)), eye(3)]';
L = H'*PHI'*B;

end