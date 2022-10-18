clear;clc;
%%
path1 = pwd;
addpath([path1,'/data'])
addpath([path1,'/genFiguresFunctions_Dual'])
mkdir([path1,'/figures'])
OL_runNoLoad_Data = load('dualArm_openLoop_runWithoutAdditionalLoad.mat');
Desired = OL_runNoLoad_Data;
OL_run4lbLoad_Data = load('dualArm_openLoop_runWithCentered4lbLoad.mat');
TunedNoLoad_runNoLoad_Data = load('dualArm_TunedForNoLoad_runWithoutAdditionalLoad.mat');
TunedNoLoad_run4lbLoad_Data = load('dualArm_TunedForNoLoad_runWithCentered4lbLoad.mat');
Tuned2lbLoad_run4lbLoad_Data = load('dualArm_TunedFor2lbLoad_runWithCentered4lbLoad.mat');
Tuned2lbLoad_runNoLoad_Data = load('dualArm_TunedFor2lbLoad_runWithoutAdditionalLoad.mat');
TunedBoth_runNoLoad_Data = load('dualArm_TunedForBothModels_runWithoutAdditionalLoad.mat');
TunedBoth_run4lbLoad_Data = load('dualArm_TunedForBothModels_runWithCentered4lbLoad.mat');

%% no load cases
figspatial = 1;
fig3D = 2;
figJoint = 3;
leg = {'Desired','Open Loop','Tuned For No Load','Tuned For 2lb Load','Tuned For Both Models'};
legTitle = 'Run Without Additional Load - Left Arm';


genSpatialFigDes_Dual(figspatial,Desired.desiredEEPosition_LeftArm,Desired.desiredEEEulerAngles_LeftArm,Desired.t)
genSpatialFigExp_Dual(figspatial,OL_runNoLoad_Data.experimentalEEPosition_LeftArm,OL_runNoLoad_Data.experimentalEEEulerAngles_LeftArm,OL_runNoLoad_Data.t)
genSpatialFigExp_Dual(figspatial,TunedNoLoad_runNoLoad_Data.experimentalEEPosition_LeftArm,TunedNoLoad_runNoLoad_Data.experimentalEEEulerAngles_LeftArm,TunedNoLoad_runNoLoad_Data.t)
genSpatialFigExp_Dual(figspatial,Tuned2lbLoad_runNoLoad_Data.experimentalEEPosition_LeftArm,Tuned2lbLoad_runNoLoad_Data.experimentalEEEulerAngles_LeftArm,Tuned2lbLoad_runNoLoad_Data.t)
genSpatialFigExp_Dual(figspatial,TunedBoth_runNoLoad_Data.experimentalEEPosition_LeftArm,TunedBoth_runNoLoad_Data.experimentalEEEulerAngles_LeftArm,TunedBoth_runNoLoad_Data.t)
h = legend(leg);
h.Title.String = legTitle;
savefig(gcf,[path1,'/figures/runWithoutAdditionalLoad_SpatialEETracking_LeftArm.fig'],'compact')

gen3DFigDes_Dual(fig3D,Desired.desiredEEPosition_LeftArm,Desired.idxSegs)
gen3DFigExp_Dual(fig3D,OL_runNoLoad_Data.experimentalEEPosition_LeftArm)
gen3DFigExp_Dual(fig3D,TunedNoLoad_runNoLoad_Data.experimentalEEPosition_LeftArm)
gen3DFigExp_Dual(fig3D,Tuned2lbLoad_runNoLoad_Data.experimentalEEPosition_LeftArm)
gen3DFigExp_Dual(fig3D,TunedBoth_runNoLoad_Data.experimentalEEPosition_LeftArm)
h = legend(leg);
h.Title.String = legTitle;
savefig(gcf,[path1,'/figures/runWithoutAdditionalLoad_3DEEPositionTracking_LeftArm.fig'],'compact')


genJointFigDes_Dual(figJoint,Desired.q_desired(1:7,:),Desired.t)
genJointFigExp_Dual(figJoint,OL_runNoLoad_Data.q_experimental(1:7,:),OL_runNoLoad_Data.t)
genJointFigExp_Dual(figJoint,TunedNoLoad_runNoLoad_Data.q_experimental(1:7,:),TunedNoLoad_runNoLoad_Data.t)
genJointFigExp_Dual(figJoint,Tuned2lbLoad_runNoLoad_Data.q_experimental(1:7,:),Tuned2lbLoad_runNoLoad_Data.t)
genJointFigExp_Dual(figJoint,TunedBoth_runNoLoad_Data.q_experimental(1:7,:),TunedBoth_runNoLoad_Data.t)
h = legend(leg);
h.Title.String = legTitle;
savefig(gcf,[path1,'/figures/runWithoutAdditionalLoad_JointTracking_LeftArm.fig'],'compact')

figspatial = 100;
fig3D = 200;
figJoint = 300;
leg = {'Desired','Open Loop','Tuned For No Load','Tuned For 2lb Load','Tuned For Both Models'};
legTitle = 'Run Without Additional Load - Right Arm';


genSpatialFigDes_Dual(figspatial,Desired.desiredEEPosition_RightArm,Desired.desiredEEEulerAngles_RightArm,Desired.t)
genSpatialFigExp_Dual(figspatial,OL_runNoLoad_Data.experimentalEEPosition_RightArm,OL_runNoLoad_Data.experimentalEEEulerAngles_RightArm,OL_runNoLoad_Data.t)
genSpatialFigExp_Dual(figspatial,TunedNoLoad_runNoLoad_Data.experimentalEEPosition_RightArm,TunedNoLoad_runNoLoad_Data.experimentalEEEulerAngles_RightArm,TunedNoLoad_runNoLoad_Data.t)
genSpatialFigExp_Dual(figspatial,Tuned2lbLoad_runNoLoad_Data.experimentalEEPosition_RightArm,Tuned2lbLoad_runNoLoad_Data.experimentalEEEulerAngles_RightArm,Tuned2lbLoad_runNoLoad_Data.t)
genSpatialFigExp_Dual(figspatial,TunedBoth_runNoLoad_Data.experimentalEEPosition_RightArm,TunedBoth_runNoLoad_Data.experimentalEEEulerAngles_RightArm,TunedBoth_runNoLoad_Data.t)
h = legend(leg);
h.Title.String = legTitle;
savefig(gcf,[path1,'/figures/runWithoutAdditionalLoad_SpatialEETracking_RightArm.fig'],'compact')

gen3DFigDes_Dual(fig3D,Desired.desiredEEPosition_RightArm,Desired.idxSegs)
gen3DFigExp_Dual(fig3D,OL_runNoLoad_Data.experimentalEEPosition_RightArm)
gen3DFigExp_Dual(fig3D,TunedNoLoad_runNoLoad_Data.experimentalEEPosition_RightArm)
gen3DFigExp_Dual(fig3D,Tuned2lbLoad_runNoLoad_Data.experimentalEEPosition_RightArm)
gen3DFigExp_Dual(fig3D,TunedBoth_runNoLoad_Data.experimentalEEPosition_RightArm)
h = legend(leg);
h.Title.String = legTitle;
savefig(gcf,[path1,'/figures/runWithoutAdditionalLoad_3DEEPositionTracking_RightArm.fig'],'compact')


genJointFigDes_Dual(figJoint,Desired.q_desired(8:14,:),Desired.t)
genJointFigExp_Dual(figJoint,OL_runNoLoad_Data.q_experimental(8:14,:),OL_runNoLoad_Data.t)
genJointFigExp_Dual(figJoint,TunedNoLoad_runNoLoad_Data.q_experimental(8:14,:),TunedNoLoad_runNoLoad_Data.t)
genJointFigExp_Dual(figJoint,Tuned2lbLoad_runNoLoad_Data.q_experimental(8:14,:),Tuned2lbLoad_runNoLoad_Data.t)
genJointFigExp_Dual(figJoint,TunedBoth_runNoLoad_Data.q_experimental(8:14,:),TunedBoth_runNoLoad_Data.t)
h = legend(leg);
h.Title.String = legTitle;
savefig(gcf,[path1,'/figures/runWithoutAdditionalLoad_JointTracking_RightArm.fig'],'compact')

%% load cases 4lb centered
figspatial = 10;
fig3D = 11;
figJoint = 12;
leg = {'Desired','Open Loop','Tuned For No Load','Tuned For 2lb Load','Tuned For Both Models'};
legTitle = 'Run With 4lb Load - Left Arm';


genSpatialFigDes_Dual(figspatial,Desired.desiredEEPosition_LeftArm,Desired.desiredEEEulerAngles_LeftArm,Desired.t)
genSpatialFigExp_Dual(figspatial,OL_run4lbLoad_Data.experimentalEEPosition_LeftArm,OL_run4lbLoad_Data.experimentalEEEulerAngles_LeftArm,OL_run4lbLoad_Data.t)
genSpatialFigExp_Dual(figspatial,TunedNoLoad_run4lbLoad_Data.experimentalEEPosition_LeftArm,TunedNoLoad_run4lbLoad_Data.experimentalEEEulerAngles_LeftArm,TunedNoLoad_run4lbLoad_Data.t)
genSpatialFigExp_Dual(figspatial,Tuned2lbLoad_run4lbLoad_Data.experimentalEEPosition_LeftArm,Tuned2lbLoad_run4lbLoad_Data.experimentalEEEulerAngles_LeftArm,Tuned2lbLoad_run4lbLoad_Data.t)
genSpatialFigExp_Dual(figspatial,TunedBoth_run4lbLoad_Data.experimentalEEPosition_LeftArm,TunedBoth_run4lbLoad_Data.experimentalEEEulerAngles_LeftArm,TunedBoth_run4lbLoad_Data.t)
h = legend(leg);
h.Title.String = legTitle;
savefig(gcf,[path1,'/figures/runWith4lbLoad_SpatialEETracking_LeftArm.fig'],'compact')


gen3DFigDes_Dual(fig3D,Desired.desiredEEPosition_LeftArm,Desired.idxSegs)
gen3DFigExp_Dual(fig3D,OL_run4lbLoad_Data.experimentalEEPosition_LeftArm)
gen3DFigExp_Dual(fig3D,TunedNoLoad_run4lbLoad_Data.experimentalEEPosition_LeftArm)
gen3DFigExp_Dual(fig3D,Tuned2lbLoad_run4lbLoad_Data.experimentalEEPosition_LeftArm)
gen3DFigExp_Dual(fig3D,TunedBoth_run4lbLoad_Data.experimentalEEPosition_LeftArm)
h = legend(leg);
h.Title.String = legTitle;
savefig(gcf,[path1,'/figures/runWith4lbLoad_3DEEPositionTracking_LeftArm.fig'],'compact')


genJointFigDes_Dual(figJoint,Desired.q_desired(1:7,:),Desired.t)
genJointFigExp_Dual(figJoint,OL_run4lbLoad_Data.q_experimental(1:7,:),OL_run4lbLoad_Data.t)
genJointFigExp_Dual(figJoint,TunedNoLoad_run4lbLoad_Data.q_experimental(1:7,:),TunedNoLoad_run4lbLoad_Data.t)
genJointFigExp_Dual(figJoint,Tuned2lbLoad_run4lbLoad_Data.q_experimental(1:7,:),Tuned2lbLoad_run4lbLoad_Data.t)
genJointFigExp_Dual(figJoint,TunedBoth_run4lbLoad_Data.q_experimental(1:7,:),TunedBoth_run4lbLoad_Data.t)
h = legend(leg);
h.Title.String = legTitle;
savefig(gcf,[path1,'/figures/runWith4lbLoad_JointTracking_LeftArm.fig'],'compact')




figspatial = 1000;
fig3D = 1100;
figJoint = 1200;
leg = {'Desired','Open Loop','Tuned For No Load','Tuned For 2lb Load','Tuned For Both Models'};
legTitle = 'Run With 4lb Load - Right Arm';


genSpatialFigDes_Dual(figspatial,Desired.desiredEEPosition_RightArm,Desired.desiredEEEulerAngles_RightArm,Desired.t)
genSpatialFigExp_Dual(figspatial,OL_run4lbLoad_Data.experimentalEEPosition_RightArm,OL_run4lbLoad_Data.experimentalEEEulerAngles_RightArm,OL_run4lbLoad_Data.t)
genSpatialFigExp_Dual(figspatial,TunedNoLoad_run4lbLoad_Data.experimentalEEPosition_RightArm,TunedNoLoad_run4lbLoad_Data.experimentalEEEulerAngles_RightArm,TunedNoLoad_run4lbLoad_Data.t)
genSpatialFigExp_Dual(figspatial,Tuned2lbLoad_run4lbLoad_Data.experimentalEEPosition_RightArm,Tuned2lbLoad_run4lbLoad_Data.experimentalEEEulerAngles_RightArm,Tuned2lbLoad_run4lbLoad_Data.t)
genSpatialFigExp_Dual(figspatial,TunedBoth_run4lbLoad_Data.experimentalEEPosition_RightArm,TunedBoth_run4lbLoad_Data.experimentalEEEulerAngles_RightArm,TunedBoth_run4lbLoad_Data.t)
h = legend(leg);
h.Title.String = legTitle;
savefig(gcf,[path1,'/figures/runWith4lbLoad_SpatialEETracking_RightArm.fig'],'compact')


gen3DFigDes_Dual(fig3D,Desired.desiredEEPosition_RightArm,Desired.idxSegs)
gen3DFigExp_Dual(fig3D,OL_run4lbLoad_Data.experimentalEEPosition_RightArm)
gen3DFigExp_Dual(fig3D,TunedNoLoad_run4lbLoad_Data.experimentalEEPosition_RightArm)
gen3DFigExp_Dual(fig3D,Tuned2lbLoad_run4lbLoad_Data.experimentalEEPosition_RightArm)
gen3DFigExp_Dual(fig3D,TunedBoth_run4lbLoad_Data.experimentalEEPosition_RightArm)
h = legend(leg);
h.Title.String = legTitle;
savefig(gcf,[path1,'/figures/runWith4lbLoad_3DEEPositionTracking_RightArm.fig'],'compact')


genJointFigDes_Dual(figJoint,Desired.q_desired(8:14,:),Desired.t)
genJointFigExp_Dual(figJoint,OL_run4lbLoad_Data.q_experimental(8:14,:),OL_run4lbLoad_Data.t)
genJointFigExp_Dual(figJoint,TunedNoLoad_run4lbLoad_Data.q_experimental(8:14,:),TunedNoLoad_run4lbLoad_Data.t)
genJointFigExp_Dual(figJoint,Tuned2lbLoad_run4lbLoad_Data.q_experimental(8:14,:),Tuned2lbLoad_run4lbLoad_Data.t)
genJointFigExp_Dual(figJoint,TunedBoth_run4lbLoad_Data.q_experimental(8:14,:),TunedBoth_run4lbLoad_Data.t)
h = legend(leg);
h.Title.String = legTitle;
savefig(gcf,[path1,'/figures/runWith4lbLoad_JointTracking_RightArm.fig'],'compact')

