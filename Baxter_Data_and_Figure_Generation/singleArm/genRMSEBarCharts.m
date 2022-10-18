clear; clc;

%%
path1 = pwd;
addpath([path1,'/data'])
mkdir([path1,'/RMSE'])
OL_runNoLoad_Data = load('openLoop_runWithoutAdditionalLoad.mat');
OL_run2lbLoad_Data = load('openLoop_runWith2lbLoad.mat');
TunedNoLoad_runNoLoad_Data = load('controllerTunedForNoAdditionalLoad_runWithoutAdditionalLoad.mat');
Tuned2lbLoad_run2lbLoad_Data = load('controllerTunedFor2lbLoad_runWith2lbLoad.mat');
TunedBoth_runNoLoad_Data = load('controllerTunedForBothLoadStates_runWithoutAdditionalLoad.mat');
TunedBoth_run2lbLoad_Data = load('controllerTunedForBothLoadStates_runWith2lbLoad.mat');

%%
colNames = {'OpenLoop_RunWithoutLoad','TunedForNoLoad_RunWithoutLoad',...
    'TunedForBoth_RunWithoutLoad','OpenLoop_RunWithLoad','TunedForLoad_RunWithLoad',...
    'TunedForBoth_RunWithLoad'};
rowNames = {'Q1(rad)','Q2(rad)','Q3(rad)','Q4(rad)','Q5(rad)','Q6(rad)','Q7(rad)','X(m)','Y(m)','Z(m)','Roll(rad)','Pitch(rad)','Yaw(rad)'};

qermse = [OL_runNoLoad_Data.jointErrorRMSE,TunedNoLoad_runNoLoad_Data.jointErrorRMSE,...
    TunedBoth_runNoLoad_Data.jointErrorRMSE,OL_run2lbLoad_Data.jointErrorRMSE,...
    Tuned2lbLoad_run2lbLoad_Data.jointErrorRMSE,TunedBoth_run2lbLoad_Data.jointErrorRMSE];
transermse = [OL_runNoLoad_Data.translationErrorRMSE,TunedNoLoad_runNoLoad_Data.translationErrorRMSE,...
    TunedBoth_runNoLoad_Data.translationErrorRMSE,OL_run2lbLoad_Data.translationErrorRMSE,...
    Tuned2lbLoad_run2lbLoad_Data.translationErrorRMSE,TunedBoth_run2lbLoad_Data.translationErrorRMSE];
rotermse = flip([OL_runNoLoad_Data.rotationErrorRMSE,TunedNoLoad_runNoLoad_Data.rotationErrorRMSE,...
    TunedBoth_runNoLoad_Data.rotationErrorRMSE,OL_run2lbLoad_Data.rotationErrorRMSE,...
    Tuned2lbLoad_run2lbLoad_Data.rotationErrorRMSE,TunedBoth_run2lbLoad_Data.rotationErrorRMSE],1);
tabtmp = array2table([qermse;transermse;rotermse],'VariableNames',colNames,'RowNames',rowNames);

%%
figure;
bar(categorical(tabtmp.Properties.RowNames(8:end),tabtmp.Properties.RowNames(8:end)),tabtmp{8:end,:})
legend(tabtmp.Properties.VariableNames,'Location','best','Interpreter','none')
ylabel('RMSE')
savefig(gcf,[path1,'/RMSE/RMSEbarSpatialTracking.fig'],'compact')

figure;
bar(categorical(tabtmp.Properties.RowNames(1:7),tabtmp.Properties.RowNames(1:7)),tabtmp{1:7,:})
legend(tabtmp.Properties.VariableNames,'Location','best','Interpreter','none')
ylabel('RMSE')
savefig(gcf,[path1,'/RMSE/RMSEbarJointTracking.fig'],'compact')

rmpath([path1,'/data'])
