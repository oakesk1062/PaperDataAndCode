clear;clc;

%%
path1 = pwd;
addpath([path1,'/data'])
addpath([path1,'/genFiguresFunctions'])
mkdir([path1,'/figures'])
OL_runNoLoad_Data = load('openLoop_runWithoutAdditionalLoad.mat');
Desired = OL_runNoLoad_Data;
OL_run2lbLoad_Data = load('openLoop_runWith2lbLoad.mat');
TunedNoLoad_runNoLoad_Data = load('controllerTunedForNoAdditionalLoad_runWithoutAdditionalLoad.mat');
Tuned2lbLoad_run2lbLoad_Data = load('controllerTunedFor2lbLoad_runWith2lbLoad.mat');
TunedBoth_runNoLoad_Data = load('controllerTunedForBothLoadStates_runWithoutAdditionalLoad.mat');
TunedBoth_run2lbLoad_Data = load('controllerTunedForBothLoadStates_runWith2lbLoad.mat');

%% no load cases
figspatial = 1;
fig3D = 2;
figJoint = 3;
leg = {'Desired','Open Loop','Tuned For No Additional Load','Tuned For Both Load States'};
legTitle = 'Run Without Additional Load';


genSpatialFigDes(figspatial,Desired.desiredEEPosition,Desired.desiredEEEulerAngles,Desired.t)
genSpatialFigExp(figspatial,OL_runNoLoad_Data.experimentalEEPosition,OL_runNoLoad_Data.experimentalEEEulerAngles,OL_runNoLoad_Data.t)
genSpatialFigExp(figspatial,TunedNoLoad_runNoLoad_Data.experimentalEEPosition,TunedNoLoad_runNoLoad_Data.experimentalEEEulerAngles,TunedNoLoad_runNoLoad_Data.t)
genSpatialFigExp(figspatial,TunedBoth_runNoLoad_Data.experimentalEEPosition,TunedBoth_runNoLoad_Data.experimentalEEEulerAngles,TunedBoth_runNoLoad_Data.t)
h = legend(leg);
h.Title.String = legTitle;
savefig(gcf,[path1,'/figures/runWithoutAdditionalLoad_EESpatialTracking.fig'],'compact')

gen3DFigDes(fig3D,Desired.desiredEEPosition,Desired.idxSegs)
gen3DFigExp(fig3D,OL_runNoLoad_Data.experimentalEEPosition)
gen3DFigExp(fig3D,TunedNoLoad_runNoLoad_Data.experimentalEEPosition)
gen3DFigExp(fig3D,TunedBoth_runNoLoad_Data.experimentalEEPosition)
h = legend(leg);
h.Title.String = legTitle;
savefig(gcf,[path1,'/figures/runWithoutAdditionalLoad_3DEEPositionTracking.fig'],'compact')


genJointFigDes(figJoint,Desired.q_desired,Desired.t)
genJointFigExp(figJoint,OL_runNoLoad_Data.q_experimental,OL_runNoLoad_Data.t)
genJointFigExp(figJoint,TunedNoLoad_runNoLoad_Data.q_experimental,TunedNoLoad_runNoLoad_Data.t)
genJointFigExp(figJoint,TunedBoth_runNoLoad_Data.q_experimental,TunedBoth_runNoLoad_Data.t)
h = legend(leg);
h.Title.String = legTitle;
savefig(gcf,[path1,'/figures/runWithoutAdditionalLoad_JointTracking.fig'],'compact')


%% load cases
figspatial = 4;
fig3D = 5;
figJoint = 6;
leg = {'Desired','Open Loop','Tuned For 2lb Load','Tuned For Both Load States'};
legTitle = 'Run With 2lb Load';


genSpatialFigDes(figspatial,Desired.desiredEEPosition,Desired.desiredEEEulerAngles,Desired.t)
genSpatialFigExp(figspatial,OL_run2lbLoad_Data.experimentalEEPosition,OL_run2lbLoad_Data.experimentalEEEulerAngles,OL_run2lbLoad_Data.t)
genSpatialFigExp(figspatial,Tuned2lbLoad_run2lbLoad_Data.experimentalEEPosition,Tuned2lbLoad_run2lbLoad_Data.experimentalEEEulerAngles,Tuned2lbLoad_run2lbLoad_Data.t)
genSpatialFigExp(figspatial,TunedBoth_run2lbLoad_Data.experimentalEEPosition,TunedBoth_run2lbLoad_Data.experimentalEEEulerAngles,TunedBoth_run2lbLoad_Data.t)
h = legend(leg);
h.Title.String = legTitle;
savefig(gcf,[path1,'/figures/runWith2lbLoad_EESpatialTracking.fig'],'compact')


gen3DFigDes(fig3D,Desired.desiredEEPosition,Desired.idxSegs)
gen3DFigExp(fig3D,OL_run2lbLoad_Data.experimentalEEPosition)
gen3DFigExp(fig3D,Tuned2lbLoad_run2lbLoad_Data.experimentalEEPosition)
gen3DFigExp(fig3D,TunedBoth_run2lbLoad_Data.experimentalEEPosition)
h = legend(leg);
h.Title.String = legTitle;
savefig(gcf,[path1,'/figures/runWithwlbLoad_3DEEPositionTracking.fig'],'compact')


genJointFigDes(figJoint,Desired.q_desired,Desired.t)
genJointFigExp(figJoint,OL_run2lbLoad_Data.q_experimental,OL_run2lbLoad_Data.t)
genJointFigExp(figJoint,Tuned2lbLoad_run2lbLoad_Data.q_experimental,Tuned2lbLoad_run2lbLoad_Data.t)
genJointFigExp(figJoint,TunedBoth_run2lbLoad_Data.q_experimental,TunedBoth_run2lbLoad_Data.t)
h = legend(leg);
h.Title.String = legTitle;
savefig(gcf,[path1,'/figures/runWith2lbLoad_JointTracking.fig'],'compact')


%% comp controls
figspatial = 7;
fig3D = 8;
figJoint = 9;
leg = {'Desired',...
    ['\newline Tuned For No Additional Load \newline Run Without Additional Load \newline \newline'],...
    ['\newline Tuned For Both Load States \newline Run Without Additional Load \newline \newline'],...
    ['\newline Tuned For 2lb Load \newline Run With 2lb Load \newline \newline'],...
    ['\newline Tuned For Both Load States \newline Run With 2lb Load \newline \newline']};
legTitle = 'Compare Controllers';


genSpatialFigDes(figspatial,Desired.desiredEEPosition,Desired.desiredEEEulerAngles,Desired.t)
genSpatialFigExp(figspatial,TunedNoLoad_runNoLoad_Data.experimentalEEPosition,TunedNoLoad_runNoLoad_Data.experimentalEEEulerAngles,TunedNoLoad_runNoLoad_Data.t)
genSpatialFigExp(figspatial,TunedBoth_runNoLoad_Data.experimentalEEPosition,TunedBoth_runNoLoad_Data.experimentalEEEulerAngles,TunedBoth_runNoLoad_Data.t)
genSpatialFigExp(figspatial,Tuned2lbLoad_run2lbLoad_Data.experimentalEEPosition,Tuned2lbLoad_run2lbLoad_Data.experimentalEEEulerAngles,Tuned2lbLoad_run2lbLoad_Data.t)
genSpatialFigExp(figspatial,TunedBoth_run2lbLoad_Data.experimentalEEPosition,TunedBoth_run2lbLoad_Data.experimentalEEEulerAngles,TunedBoth_run2lbLoad_Data.t)
h = legend(leg);
h.Title.String = legTitle;
savefig(gcf,[path1,'/figures/compareControllers_EESpatialTracking.fig'],'compact')


gen3DFigDes(fig3D,Desired.desiredEEPosition,Desired.idxSegs)
gen3DFigExp(fig3D,TunedNoLoad_runNoLoad_Data.experimentalEEPosition)
gen3DFigExp(fig3D,TunedBoth_runNoLoad_Data.experimentalEEPosition)
gen3DFigExp(fig3D,Tuned2lbLoad_run2lbLoad_Data.experimentalEEPosition)
gen3DFigExp(fig3D,TunedBoth_run2lbLoad_Data.experimentalEEPosition)
h = legend(leg);
h.Title.String = legTitle;
savefig(gcf,[path1,'/figures/compareControllers_3DEEPositionTracking.fig'],'compact')


genJointFigDes(figJoint,Desired.q_desired,Desired.t)
genJointFigExp(figJoint,TunedNoLoad_runNoLoad_Data.q_experimental,TunedNoLoad_runNoLoad_Data.t)
genJointFigExp(figJoint,TunedBoth_runNoLoad_Data.q_experimental,TunedBoth_runNoLoad_Data.t)
genJointFigExp(figJoint,Tuned2lbLoad_run2lbLoad_Data.q_experimental,Tuned2lbLoad_run2lbLoad_Data.t)
genJointFigExp(figJoint,TunedBoth_run2lbLoad_Data.q_experimental,TunedBoth_run2lbLoad_Data.t)
h = legend(leg);
h.Title.String = legTitle;
savefig(gcf,[path1,'/figures/compareControllers_JointTracking.fig'],'compact')

%% comp all
figspatial = 10;
fig3D = 11;
figJoint = 12;
leg = {'Desired',...
    ['\newline Open Loop \newline Run Without Additional Load \newline \newline'],...
    ['\newline Tuned For No Additional Load \newline Run Without Additional Load \newline \newline'],...
    ['\newline Tuned For Both Load States \newline Run Without Additional Load \newline \newline'],...
    ['\newline Open Loop \newline Run With 2lb Load \newline \newline'],...
    ['\newline Tuned For 2lb Load \newline Run With 2lb Load \newline \newline'],...
    ['\newline Tuned For Both Load States \newline Run With 2lb Load \newline \newline']};
legTitle = 'Compare Controllers';


genSpatialFigDes(figspatial,Desired.desiredEEPosition,Desired.desiredEEEulerAngles,Desired.t)
genSpatialFigExp(figspatial,OL_runNoLoad_Data.experimentalEEPosition,OL_runNoLoad_Data.experimentalEEEulerAngles,OL_runNoLoad_Data.t)
genSpatialFigExp(figspatial,TunedNoLoad_runNoLoad_Data.experimentalEEPosition,TunedNoLoad_runNoLoad_Data.experimentalEEEulerAngles,TunedNoLoad_runNoLoad_Data.t)
genSpatialFigExp(figspatial,TunedBoth_runNoLoad_Data.experimentalEEPosition,TunedBoth_runNoLoad_Data.experimentalEEEulerAngles,TunedBoth_runNoLoad_Data.t)
genSpatialFigExp(figspatial,OL_run2lbLoad_Data.experimentalEEPosition,OL_run2lbLoad_Data.experimentalEEEulerAngles,OL_run2lbLoad_Data.t)
genSpatialFigExp(figspatial,Tuned2lbLoad_run2lbLoad_Data.experimentalEEPosition,Tuned2lbLoad_run2lbLoad_Data.experimentalEEEulerAngles,Tuned2lbLoad_run2lbLoad_Data.t)
genSpatialFigExp(figspatial,TunedBoth_run2lbLoad_Data.experimentalEEPosition,TunedBoth_run2lbLoad_Data.experimentalEEEulerAngles,TunedBoth_run2lbLoad_Data.t)
h = legend(leg);
h.Title.String = legTitle;
savefig(gcf,[path1,'/figures/compareAllCases_EESpatialTracking.fig'],'compact')


gen3DFigDes(fig3D,Desired.desiredEEPosition,Desired.idxSegs)
gen3DFigExp(fig3D,OL_runNoLoad_Data.experimentalEEPosition)
gen3DFigExp(fig3D,TunedNoLoad_runNoLoad_Data.experimentalEEPosition)
gen3DFigExp(fig3D,TunedBoth_runNoLoad_Data.experimentalEEPosition)
gen3DFigExp(fig3D,OL_run2lbLoad_Data.experimentalEEPosition)
gen3DFigExp(fig3D,Tuned2lbLoad_run2lbLoad_Data.experimentalEEPosition)
gen3DFigExp(fig3D,TunedBoth_run2lbLoad_Data.experimentalEEPosition)
h = legend(leg);
h.Title.String = legTitle;
savefig(gcf,[path1,'/figures/compareAllCases_3DEEPositionTracking.fig'],'compact')


genJointFigDes(figJoint,Desired.q_desired,Desired.t)
genJointFigExp(figJoint,OL_runNoLoad_Data.q_experimental,OL_runNoLoad_Data.t)
genJointFigExp(figJoint,TunedNoLoad_runNoLoad_Data.q_experimental,TunedNoLoad_runNoLoad_Data.t)
genJointFigExp(figJoint,TunedBoth_runNoLoad_Data.q_experimental,TunedBoth_runNoLoad_Data.t)
genJointFigExp(figJoint,OL_run2lbLoad_Data.q_experimental,OL_run2lbLoad_Data.t)
genJointFigExp(figJoint,Tuned2lbLoad_run2lbLoad_Data.q_experimental,Tuned2lbLoad_run2lbLoad_Data.t)
genJointFigExp(figJoint,TunedBoth_run2lbLoad_Data.q_experimental,TunedBoth_run2lbLoad_Data.t)
h = legend(leg);
h.Title.String = legTitle;
savefig(gcf,[path1,'/figures/compareAllCases_JointTracking.fig'],'compact')

%%
rmpath([path1,'/data'])
rmpath([path1,'/genFiguresFunctions'])
%%
close all;