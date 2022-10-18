clear;clc;
addpath([pwd,'/data'])
addpath([pwd,'/genFiguresFunctions_Dual'])

OLNo = load('dualArm_openLoop_runWithoutAdditionalLoad.mat');
OLYes = load('dualArm_openLoop_runWithCentered4lbLoad.mat');
TNNo = load('dualArm_TunedForNoLoad_runWithoutAdditionalLoad.mat');
TNYes = load('dualArm_TunedForNoLoad_runWithCentered4lbLoad.mat');
TBNo = load('dualArm_TunedForBothModels_runWithoutAdditionalLoad.mat');
TBYes = load('dualArm_TunedForBothModels_runWithCentered4lbLoad.mat');

for ii = 1:length(OLNo.desiredEEPosition_LeftArm)
    Pdes(:,ii) = mean([OLNo.desiredEEPosition_LeftArm(:,ii) OLNo.desiredEEPosition_RightArm(:,ii)],2);
    %Edes(:,ii) = mean(OLNo.desiredEEEulerAngles_LeftArm(:,ii) OLNo.desiredEEEulerAngles_RightArm(:,ii)],2);   
    PON(:,ii) = mean([OLNo.experimentalEEPosition_LeftArm(:,ii) OLNo.experimentalEEPosition_RightArm(:,ii)],2);
end
for ii = 1:length(OLYes.desiredEEPosition_LeftArm)
    POY(:,ii) = mean([OLYes.experimentalEEPosition_LeftArm(:,ii) OLYes.experimentalEEPosition_RightArm(:,ii)],2);
end
for ii = 1:length(TNNo.experimentalEEPosition_LeftArm)
    PTNNo(:,ii) = mean([TNNo.experimentalEEPosition_LeftArm(:,ii) TNNo.experimentalEEPosition_RightArm(:,ii)],2);
end
for ii = 1:length(TNYes.experimentalEEPosition_LeftArm)
    PTNYes(:,ii) = mean([TNYes.experimentalEEPosition_LeftArm(:,ii) TNYes.experimentalEEPosition_RightArm(:,ii)],2);
end
for ii = 1:length(TBNo.experimentalEEPosition_LeftArm)
    PTBNo(:,ii) = mean([TBNo.experimentalEEPosition_LeftArm(:,ii) TBNo.experimentalEEPosition_RightArm(:,ii)],2);
end
for ii = 1:length(TBYes.experimentalEEPosition_LeftArm)
    PTBYes(:,ii) = mean([TBYes.experimentalEEPosition_LeftArm(:,ii) TBYes.experimentalEEPosition_RightArm(:,ii)],2);
end

gen3DFigDes_Dual(10,Pdes,OLNo.idxSegs)
gen3DFigExp_Dual(10,PON,'b')
gen3DFigExp_Dual(10,PTNNo,'r')
gen3DFigExp_Dual(10,PTBNo,'y')
legend('Desired','Open Loop','Tuned Without Load','Tuned For Both')
sgtitle('Run Without Load')

gen3DFigDes_Dual(20,Pdes,OLYes.idxSegs)
gen3DFigExp_Dual(20,POY,'b')
gen3DFigExp_Dual(20,PTNYes,'r')
gen3DFigExp_Dual(20,PTBYes,'y')
legend('Desired','Open Loop','Tuned Without Load','Tuned For Both')
sgtitle('Run With 2kg Load')

rmpath([pwd,'/data'])
rmpath([pwd,'/genFiguresFunctions_Dual'])
