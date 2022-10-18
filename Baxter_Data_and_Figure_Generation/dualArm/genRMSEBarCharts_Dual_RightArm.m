clear; clc;
%%
path1 = pwd;
addpath([path1,'/data'])
addpath([path1,'/genFiguresFunctions_Dual'])
mkdir([path1,'/RMSE'])
OL_runNoLoad_Data = load('dualArm_openLoop_runWithoutAdditionalLoad.mat');
Desired = OL_runNoLoad_Data;
OL_run4lbLoad_Data = load('dualArm_openLoop_runWithCentered4lbLoad.mat');
TunedNoLoad_runNoLoad_Data = load('dualArm_TunedForNoLoad_runWithoutAdditionalLoad.mat');
TunedNoLoad_run4lbLoad_Data = load('dualArm_TunedForNoLoad_runWithCentered4lbLoad.mat');
Tuned2lbLoad_run4lbLoad_Data = load('dualArm_TunedFor2lbLoad_runWithCentered4lbLoad.mat');
Tuned2lbLoad_runNoLoad_Data = load('dualArm_TunedFor2lbLoad_runWithoutAdditionalLoad.mat');
TunedBoth_runNoLoad_Data = load('dualArm_TunedForBothModels_runWithoutAdditionalLoad.mat');
TunedBoth_run4lbLoad_Data = load('dualArm_TunedForBothModels_runWithCentered4lbLoad.mat');
%%
colNames = {'OpenLoop_runNoLoad','TunedForNoLoad_runNoLoad','TunedForLoad_runNoLoad','TunedForBothModels_runNoLoad',...
    'OpenLoop_runWithLoad','TunedForNoLoad_runWithLoad','TunedForLoad_runWithLoad','TunedForBothModels_runWithLoad'};
rowNames = {'Q1(rad)','Q2(rad)','Q3(rad)','Q4(rad)','Q5(rad)','Q6(rad)','Q7(rad)','X(m)','Y(m)','Z(m)','Roll(rad)','Pitch(rad)','Yaw(rad)'};

qermseRight = [OL_runNoLoad_Data.jointErrorRMSE_RightArm,TunedNoLoad_runNoLoad_Data.jointErrorRMSE_RightArm,...
    Tuned2lbLoad_runNoLoad_Data.jointErrorRMSE_RightArm,TunedBoth_runNoLoad_Data.jointErrorRMSE_RightArm,...
    OL_run4lbLoad_Data.jointErrorRMSE_RightArm,TunedNoLoad_run4lbLoad_Data.jointErrorRMSE_RightArm,...
    Tuned2lbLoad_run4lbLoad_Data.jointErrorRMSE_RightArm,TunedBoth_run4lbLoad_Data.jointErrorRMSE_RightArm];
transermseRight = [OL_runNoLoad_Data.translationErrorRMSE_RightArm,TunedNoLoad_runNoLoad_Data.translationErrorRMSE_RightArm,...
    Tuned2lbLoad_runNoLoad_Data.translationErrorRMSE_RightArm,TunedBoth_runNoLoad_Data.translationErrorRMSE_RightArm,...
    OL_run4lbLoad_Data.translationErrorRMSE_RightArm,TunedNoLoad_run4lbLoad_Data.translationErrorRMSE_RightArm,...
    Tuned2lbLoad_run4lbLoad_Data.translationErrorRMSE_RightArm,TunedBoth_run4lbLoad_Data.translationErrorRMSE_RightArm];
rotermseRight = flip([OL_runNoLoad_Data.rotationErrorRMSE_RightArm,TunedNoLoad_runNoLoad_Data.rotationErrorRMSE_RightArm,...
    Tuned2lbLoad_runNoLoad_Data.rotationErrorRMSE_RightArm,TunedBoth_runNoLoad_Data.rotationErrorRMSE_RightArm,...
    OL_run4lbLoad_Data.rotationErrorRMSE_RightArm,TunedNoLoad_run4lbLoad_Data.rotationErrorRMSE_RightArm,...
    Tuned2lbLoad_run4lbLoad_Data.rotationErrorRMSE_RightArm,TunedBoth_run4lbLoad_Data.rotationErrorRMSE_RightArm],1);


tabtmpRight = array2table([qermseRight;transermseRight;rotermseRight],'VariableNames',colNames,'RowNames',rowNames);

%% comp control - No Load - Right Arm
inds = 1:4;
figure;
bar(categorical(tabtmpRight.Properties.RowNames(1:7),tabtmpRight.Properties.RowNames(1:7)),tabtmpRight{1:7,inds})
legend(tabtmpRight.Properties.VariableNames(inds),'Location','best','Interpreter','none')
ylabel('RMSE')
title(['Dual Arm Run Without Additional Load - Right Arm Data'])
savefig(gcf,[path1,'/RMSE/RMSEbarChart_JointTracking_RunNoLoad_RightArm_noLoad.fig'],'compact')
figure;
bar(categorical(tabtmpRight.Properties.RowNames(8:end),tabtmpRight.Properties.RowNames(8:end)),tabtmpRight{8:end,inds})
legend(tabtmpRight.Properties.VariableNames(inds),'Location','best','Interpreter','none')
ylabel('RMSE')
title(['Dual Arm Run Without Additional Load - Right Arm Data'])
savefig(gcf,[path1,'/RMSE/RMSEbarChart_SpatialTracking_runNoLoad_RightArm_noLoad.fig'],'compact')

%% comp control - 4lb center - Right Arm
inds = 5:8;
figure;
bar(categorical(tabtmpRight.Properties.RowNames(1:7),tabtmpRight.Properties.RowNames(1:7)),tabtmpRight{1:7,inds})
legend(tabtmpRight.Properties.VariableNames(inds),'Location','best','Interpreter','none')
ylabel('RMSE')
title(['Dual Arm Run With 4lb Load - Right Arm Data'])
savefig(gcf,[path1,'/RMSE/RMSEbarChart_JointTracking_RightArm_withLoad.fig'],'compact')
figure;
bar(categorical(tabtmpRight.Properties.RowNames(8:end),tabtmpRight.Properties.RowNames(8:end)),tabtmpRight{8:end,inds})
legend(tabtmpRight.Properties.VariableNames(inds),'Location','best','Interpreter','none')
ylabel('RMSE')
title(['Dual Arm Run With 4lb Load - Right Arm Data'])
savefig(gcf,[path1,'/RMSE/RMSEbarChart_SpatialTracking_RightArm_withLoad.fig'],'compact')

%% comp load - open loop - Right arm
inds = [1,5];
figure;
bar(categorical(tabtmpRight.Properties.RowNames(1:7),tabtmpRight.Properties.RowNames(1:7)),tabtmpRight{1:7,inds})
legend(tabtmpRight.Properties.VariableNames(inds),'Location','best','Interpreter','none')
ylabel('RMSE')
title(['Dual Arm - Open Loop Control - Right Arm Data '])
savefig(gcf,[path1,'/RMSE/RMSEbarChart_JointTracking_RightArm_OpenLoop.fig'],'compact')
figure;
bar(categorical(tabtmpRight.Properties.RowNames(8:end),tabtmpRight.Properties.RowNames(8:end)),tabtmpRight{8:end,inds})
legend(tabtmpRight.Properties.VariableNames(inds),'Location','best','Interpreter','none')
ylabel('RMSE')
title(['Dual Arm - Open Loop Control - Right Arm Data'])
savefig(gcf,[path1,'/RMSE/RMSEbarChart_SpatialTracking_RightArm_OpenLoop.fig'],'compact')

%% comp load - tuned no load
inds = [2,6];
figure;
bar(categorical(tabtmpRight.Properties.RowNames(1:7),tabtmpRight.Properties.RowNames(1:7)),tabtmpRight{1:7,inds})
legend(tabtmpRight.Properties.VariableNames(inds),'Location','best','Interpreter','none')
ylabel('RMSE')
title(['Dual Arm - Controller Tuned For No Load - Right Arm Data'])
savefig(gcf,[path1,'/RMSE/RMSEbarChart_JointTracking_RightArm_tunedForNoLoad.fig'],'compact')
figure;
bar(categorical(tabtmpRight.Properties.RowNames(8:end),tabtmpRight.Properties.RowNames(8:end)),tabtmpRight{8:end,inds})
legend(tabtmpRight.Properties.VariableNames(inds),'Location','best','Interpreter','none')
ylabel('RMSE')
title(['Dual Arm - Controller Tuned For No Load - Right Arm Data'])
savefig(gcf,[path1,'/RMSE/RMSEbarChart_SpatialTracking_RightArm_tunedForNoLoad.fig'],'compact')

%% comp load - tuned 2lb load
inds = [3,7];
figure;
bar(categorical(tabtmpRight.Properties.RowNames(1:7),tabtmpRight.Properties.RowNames(1:7)),tabtmpRight{1:7,inds})
legend(tabtmpRight.Properties.VariableNames(inds),'Location','best','Interpreter','none')
ylabel('RMSE')
title(['Dual Arm - Controller Tuned For 2lb Load - Right Arm Data'])
savefig(gcf,[path1,'/RMSE/RMSEbarChart_JointTracking_RightArm_tunedFor2lbLoad.fig'],'compact')
figure;
bar(categorical(tabtmpRight.Properties.RowNames(8:end),tabtmpRight.Properties.RowNames(8:end)),tabtmpRight{8:end,inds})
legend(tabtmpRight.Properties.VariableNames(inds),'Location','best','Interpreter','none')
ylabel('RMSE')
title(['Dual Arm - Controller Tuned For 2lb Load - Right Arm Data'])
savefig(gcf,[path1,'/RMSE/RMSEbarChart_SpatialTracking_RightArm_tunedFor2lbLoad.fig'],'compact')

%% comp load - both
inds = [4,8];
figure;
bar(categorical(tabtmpRight.Properties.RowNames(1:7),tabtmpRight.Properties.RowNames(1:7)),tabtmpRight{1:7,inds})
legend(tabtmpRight.Properties.VariableNames(inds),'Location','best','Interpreter','none')
ylabel('RMSE')
title(['Dual Arm - Controller Tuned For Both Models - Right Arm Data'])
savefig(gcf,[path1,'/RMSE/RMSEbarChart_JointTracking_RightArm_tunedForBothModels.fig'],'compact')
figure;
bar(categorical(tabtmpRight.Properties.RowNames(8:end),tabtmpRight.Properties.RowNames(8:end)),tabtmpRight{8:end,inds})
legend(tabtmpRight.Properties.VariableNames(inds),'Location','best','Interpreter','none')
ylabel('RMSE')
title(['Dual Arm - Controller Tuned For Both Models - Right Arm Data'])
savefig(gcf,[path1,'/RMSE/RMSEbarChart_SpatialTracking_RightArm_tunedForBothModels.fig'],'compact')
