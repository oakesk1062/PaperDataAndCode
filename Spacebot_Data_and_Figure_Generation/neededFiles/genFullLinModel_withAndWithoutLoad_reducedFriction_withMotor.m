function [G,Gload,Gbase,Gloadbase] = genFullLinModel_withAndWithoutLoad_reducedFriction_withMotor(qpose)
%states: q,qm,qdot,qmdot
%% create robot object containing kinematic and dynamic parameters
[rob,~] = defineSpacebot_reducedFriction_withMotor();
numj = length(qpose);

%% set up constants as diagonal matrices
N = rob.mprops.N;   K = rob.mprops.K;   Im = rob.mprops.Im;
Bl = rob.mprops.bl; B = rob.mprops.b; Bm = rob.mprops.bm;

%B = B/10;
%Bl = Bl/100;
Nmat = diag(N); Kmat = diag(K); Immat = diag(Im);
Blmat = diag(Bl);   Bmat = diag(B); Bmmat = diag(Bm);
clear N K Im Bl B Bm

%% set up load mass-inertia matrix
load(['target_sat_props.mat'])
Mc = [Isat zeros(3);zeros(3) msat*eye(3)]; 
%iMc = pinv(Mc);
%% set up the state space B,C, and D matrices
B = [zeros(3*numj,numj);inv(Immat)];
C = [zeros(numj) eye(numj) zeros(numj,2*numj)];
%C = [eye(numj) zeros(numj,3*numj)];
D = zeros(numj);
%% precompute some inverses to save on computation
iN = inv(Nmat);    iI = inv(Immat);
%% preallocate variables for speed
%M_load = zeros(numj); 
%Amatload = zeros(4*numj);


    %% generate mass matrices for load and base
    [Mall,~,L] = MCgen_floatingbase(qpose,zeros(7,1),rob,zeros(6,1));
    M = Mall(7:end,7:end);
    Mbq = Mall(1:6,7:end);
    Mqb = Mall(7:end,1:6);
    Mb = Mall(1:6,1:6);
    %% generate the needed matrices for adding a load
    J = robotjacobian(rob.kin,qpose);
    [Rot,~] = fwdkin(rob.kin,qpose);
    %J = [Rot' zeros(3);zeros(3) Rot']*J;
    
    %A = [Rot zeros(3);Rot*hat(PTC) Rot]; %verified with rigid_body_fb_dyn in David's pathgen package
    %Ainv = pinv(A);
    %AinvT = Ainv';
    Ainv = [Rot' zeros(3);-hat(PTC)*Rot' Rot'];
    AinvT = [Rot Rot*hat(PTC);zeros(3) Rot];
    
    %add the load to mass matrix
    M_load = M+J'*AinvT*Mc*Ainv*J;
    %pre compute inverses to reduce computation load
    iM = inv(M);   
    iMload = inv(M_load);
    iMbase = inv(M-Mqb*inv(Mb)*Mbq);
    iMloadbase = inv(M_load-Mqb*inv(Mb)*Mbq-Mqb*inv(Mb)*L(1:6,1:6)*AinvT*Mc*Ainv*J);
    %%   
    % generate the state space A matrices for each case
     Amat = [zeros(numj,2*numj) eye(numj) zeros(numj);...
         zeros(numj,3*numj) eye(numj);...
         -iM*Kmat iM*Kmat*iN -iM*(Blmat+Bmat) iM*Bmat*iN;...
         iI*Kmat*iN -iI*Kmat*iN^2 iI*Bmat*iN -iI*Bmat*iN^2-iI*Bmmat];
    Amatload = [zeros(numj,2*numj) eye(numj) zeros(numj);...
        zeros(numj,3*numj) eye(numj);...
        -iMload*Kmat iMload*Kmat*iN -iMload*(Blmat+Bmat) iMload*Bmat*iN;...
        iI*Kmat*iN -iI*Kmat*iN^2 iI*Bmat*iN -iI*Bmat*iN^2-iI*Bmmat];
     Amatbase = [zeros(numj,2*numj) eye(numj) zeros(numj);...
         zeros(numj,3*numj) eye(numj);...
         -iMbase*Kmat iMbase*Kmat*iN -iMbase*(Blmat+Bmat) iMbase*Bmat*iN;...
         iI*Kmat*iN -iI*Kmat*iN^2 iI*Bmat*iN -iI*Bmat*iN^2-iI*Bmmat];
     Amatloadbase = [zeros(numj,2*numj) eye(numj) zeros(numj);...
         zeros(numj,3*numj) eye(numj);...
         -iMloadbase*Kmat iMloadbase*Kmat*iN -iMloadbase*(Blmat+Bmat) iMloadbase*Bmat*iN;...
         iI*Kmat*iN -iI*Kmat*iN^2 iI*Bmat*iN -iI*Bmat*iN^2-iI*Bmmat];
    

G = ss(Amat,B,C,D);
Gload = ss(Amatload,B,C,D);
Gbase = ss(Amatbase,B,C,D);
Gloadbase = ss(Amatloadbase,B,C,D);

%%
%k=7;Gtmp = (M(k,k)*s^2+(Blmat(k,k)+Bmat(k,k))*s+Kmat(k,k))/(Immat(k,k)*M(k,k)*s^4+(Immat(k,k)*(Blmat(k,k)+Bmat(k,k))+M(k,k)*Bmat(k,k)/Nmat(k,k)^2)*s^3+(Immat(k,k)*Kmat(k,k)+Bmat(k,k)*Blmat(k,k)/Nmat(k,k)^2+M(k,k)*Kmat(k,k)/Nmat(k,k)^2)*s^2+(Blmat(k,k)*Kmat(k,k)/Nmat(k,k)^2)*s);
%Gtmp2 = (M_load(k,k)*s^2+(Blmat(k,k)+Bmat(k,k))*s+Kmat(k,k))/(Immat(k,k)*M_load(k,k)*s^4+(Immat(k,k)*(Blmat(k,k)+Bmat(k,k))+M_load(k,k)*Bmat(k,k)/Nmat(k,k)^2)*s^3+(Immat(k,k)*Kmat(k,k)+Bmat(k,k)*Blmat(k,k)/Nmat(k,k)^2+M(k,k)*Kmat(k,k)/Nmat(k,k)^2)*s^2+(Blmat(k,k)*Kmat(k,k)/Nmat(k,k)^2)*s);


end