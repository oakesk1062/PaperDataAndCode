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

qermseLeft = [OL_runNoLoad_Data.jointErrorRMSE_LeftArm,TunedNoLoad_runNoLoad_Data.jointErrorRMSE_LeftArm,...
    Tuned2lbLoad_runNoLoad_Data.jointErrorRMSE_LeftArm,TunedBoth_runNoLoad_Data.jointErrorRMSE_LeftArm,...
    OL_run4lbLoad_Data.jointErrorRMSE_LeftArm,TunedNoLoad_run4lbLoad_Data.jointErrorRMSE_LeftArm,...
    Tuned2lbLoad_run4lbLoad_Data.jointErrorRMSE_LeftArm,TunedBoth_run4lbLoad_Data.jointErrorRMSE_LeftArm];
transermseLeft = [OL_runNoLoad_Data.translationErrorRMSE_LeftArm,TunedNoLoad_runNoLoad_Data.translationErrorRMSE_LeftArm,...
    Tuned2lbLoad_runNoLoad_Data.translationErrorRMSE_LeftArm,TunedBoth_runNoLoad_Data.translationErrorRMSE_LeftArm,...
    OL_run4lbLoad_Data.translationErrorRMSE_LeftArm,TunedNoLoad_run4lbLoad_Data.translationErrorRMSE_LeftArm,...
    Tuned2lbLoad_run4lbLoad_Data.translationErrorRMSE_LeftArm,TunedBoth_run4lbLoad_Data.translationErrorRMSE_LeftArm];
rotermseLeft = flip([OL_runNoLoad_Data.rotationErrorRMSE_LeftArm,TunedNoLoad_runNoLoad_Data.rotationErrorRMSE_LeftArm,...
    Tuned2lbLoad_runNoLoad_Data.rotationErrorRMSE_LeftArm,TunedBoth_runNoLoad_Data.rotationErrorRMSE_LeftArm,...
    OL_run4lbLoad_Data.rotationErrorRMSE_LeftArm,TunedNoLoad_run4lbLoad_Data.rotationErrorRMSE_LeftArm,...
    Tuned2lbLoad_run4lbLoad_Data.rotationErrorRMSE_LeftArm,TunedBoth_run4lbLoad_Data.rotationErrorRMSE_LeftArm],1);


tabtmpLeft = array2table([qermseLeft;transermseLeft;rotermseLeft],'VariableNames',colNames,'RowNames',rowNames);

%% comp control - No Load - Left Arm
inds = 1:4;
figure;
bar(categorical(tabtmpLeft.Properties.RowNames(1:7),tabtmpLeft.Properties.RowNames(1:7)),tabtmpLeft{1:7,inds})
legend(tabtmpLeft.Properties.VariableNames(inds),'Location','best','Interpreter','none')
ylabel('RMSE')
title(['Dual Arm Run Without Additional Load - Left Arm Data'])
savefig(gcf,[path1,'/RMSE/RMSEbarChart_JointTracking_RunNoLoad_LeftArm_noLoad.fig'],'compact')
figure;
bar(categorical(tabtmpLeft.Properties.RowNames(8:end),tabtmpLeft.Properties.RowNames(8:end)),tabtmpLeft{8:end,inds})
legend(tabtmpLeft.Properties.VariableNames(inds),'Location','best','Interpreter','none')
ylabel('RMSE')
title(['Dual Arm Run Without Additional Load - Left Arm Data'])
savefig(gcf,[path1,'/RMSE/RMSEbarChart_SpatialTracking_runNoLoad_LeftArm_noLoad.fig'],'compact')

%% comp control - 4lb center - Left Arm
inds = 5:8;
figure;
bar(categorical(tabtmpLeft.Properties.RowNames(1:7),tabtmpLeft.Properties.RowNames(1:7)),tabtmpLeft{1:7,inds})
legend(tabtmpLeft.Properties.VariableNames(inds),'Location','best','Interpreter','none')
ylabel('RMSE')
title(['Dual Arm Run With 4lb Load - Left Arm Data'])
savefig(gcf,[path1,'/RMSE/RMSEbarChart_JointTracking_LeftArm_withLoad.fig'],'compact')
figure;
bar(categorical(tabtmpLeft.Properties.RowNames(8:end),tabtmpLeft.Properties.RowNames(8:end)),tabtmpLeft{8:end,inds})
legend(tabtmpLeft.Properties.VariableNames(inds),'Location','best','Interpreter','none')
ylabel('RMSE')
title(['Dual Arm Run With 4lb Load - Left Arm Data'])
savefig(gcf,[path1,'/RMSE/RMSEbarChart_SpatialTracking_LeftArm_withLoad.fig'],'compact')

%% comp load - open loop - left arm
inds = [1,5];
figure;
bar(categorical(tabtmpLeft.Properties.RowNames(1:7),tabtmpLeft.Properties.RowNames(1:7)),tabtmpLeft{1:7,inds})
legend(tabtmpLeft.Properties.VariableNames(inds),'Location','best','Interpreter','none')
ylabel('RMSE')
title(['Dual Arm - Open Loop Control - Left Arm Data '])
savefig(gcf,[path1,'/RMSE/RMSEbarChart_JointTracking_LeftArm_OpenLoop.fig'],'compact')
figure;
bar(categorical(tabtmpLeft.Properties.RowNames(8:end),tabtmpLeft.Properties.RowNames(8:end)),tabtmpLeft{8:end,inds})
legend(tabtmpLeft.Properties.VariableNames(inds),'Location','best','Interpreter','none')
ylabel('RMSE')
title(['Dual Arm - Open Loop Control - Left Arm Data'])
savefig(gcf,[path1,'/RMSE/RMSEbarChart_SpatialTracking_LeftArm_OpenLoop.fig'],'compact')

%% comp load - tuned no load
inds = [2,6];
figure;
bar(categorical(tabtmpLeft.Properties.RowNames(1:7),tabtmpLeft.Properties.RowNames(1:7)),tabtmpLeft{1:7,inds})
legend(tabtmpLeft.Properties.VariableNames(inds),'Location','best','Interpreter','none')
ylabel('RMSE')
title(['Dual Arm - Controller Tuned For No Load - Left Arm Data'])
savefig(gcf,[path1,'/RMSE/RMSEbarChart_JointTracking_LeftArm_tunedForNoLoad.fig'],'compact')
figure;
bar(categorical(tabtmpLeft.Properties.RowNames(8:end),tabtmpLeft.Properties.RowNames(8:end)),tabtmpLeft{8:end,inds})
legend(tabtmpLeft.Properties.VariableNames(inds),'Location','best','Interpreter','none')
ylabel('RMSE')
title(['Dual Arm - Controller Tuned For No Load - Left Arm Data'])
savefig(gcf,[path1,'/RMSE/RMSEbarChart_SpatialTracking_LeftArm_tunedForNoLoad.fig'],'compact')

%% comp load - tuned 2lb load
inds = [3,7];
figure;
bar(categorical(tabtmpLeft.Properties.RowNames(1:7),tabtmpLeft.Properties.RowNames(1:7)),tabtmpLeft{1:7,inds})
legend(tabtmpLeft.Properties.VariableNames(inds),'Location','best','Interpreter','none')
ylabel('RMSE')
title(['Dual Arm - Controller Tuned For 2lb Load - Left Arm Data'])
savefig(gcf,[path1,'/RMSE/RMSEbarChart_JointTracking_LeftArm_tunedFor2lbLoad.fig'],'compact')
figure;
bar(categorical(tabtmpLeft.Properties.RowNames(8:end),tabtmpLeft.Properties.RowNames(8:end)),tabtmpLeft{8:end,inds})
legend(tabtmpLeft.Properties.VariableNames(inds),'Location','best','Interpreter','none')
ylabel('RMSE')
title(['Dual Arm - Controller Tuned For 2lb Load - Left Arm Data'])
savefig(gcf,[path1,'/RMSE/RMSEbarChart_SpatialTracking_LeftArm_tunedFor2lbLoad.fig'],'compact')

%% comp load - both
inds = [4,8];
figure;
bar(categorical(tabtmpLeft.Properties.RowNames(1:7),tabtmpLeft.Properties.RowNames(1:7)),tabtmpLeft{1:7,inds})
legend(tabtmpLeft.Properties.VariableNames(inds),'Location','best','Interpreter','none')
ylabel('RMSE')
title(['Dual Arm - Controller Tuned For Both Models - Left Arm Data'])
savefig(gcf,[path1,'/RMSE/RMSEbarChart_JointTracking_LeftArm_tunedForBothModels.fig'],'compact')
figure;
bar(categorical(tabtmpLeft.Properties.RowNames(8:end),tabtmpLeft.Properties.RowNames(8:end)),tabtmpLeft{8:end,inds})
legend(tabtmpLeft.Properties.VariableNames(inds),'Location','best','Interpreter','none')
ylabel('RMSE')
title(['Dual Arm - Controller Tuned For Both Models - Left Arm Data'])
savefig(gcf,[path1,'/RMSE/RMSEbarChart_SpatialTracking_LeftArm_tunedForBothModels.fig'],'compact')
