clear;clc;
%%
path1 = pwd;
addpath([path1,'/data'])
addpath([path1,'/genFiguresFunctions_Dual'])
mkdir([path1,'/figures/inPaper'])
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


tabtmpLeft = array2table([qermseLeft;transermseLeft;rotermseLeft],'VariableNames',colNames,'RowNames',rowNames);
tabtmpRight = array2table([qermseRight;transermseRight;rotermseRight],'VariableNames',colNames,'RowNames',rowNames);

legNames = {'Open Loop, Run Without Load','Tuned For No Load, Run Without Load',...
    'Tuned For Both Models, Run Without Load','Open Loop, Run With 2kg Load',...
    'Tuned For No Load, Run With 2kg Load','Tuned For Both, Run With 2kg Load'};

inds = [1,2,4,5,6,8];
%% left joints
figure;
bar(categorical(tabtmpLeft.Properties.RowNames(1:7),tabtmpLeft.Properties.RowNames(1:7)),tabtmpLeft{1:7,inds})
set(gca,'xticklabel',{'q_1','q_2','q_3','q_4','q_5','q_6','q_7'})
h = legend(legNames,'Location','best','Interpreter','none');
h.Title.String = 'Left Arm';
ylabel('RMSE')
savefig(gcf,[path1,'/figures/inPaper/JointTracking_LeftArm.fig'],'compact')

%% right joints
figure;
bar(categorical(tabtmpRight.Properties.RowNames(1:7),tabtmpRight.Properties.RowNames(1:7)),tabtmpRight{1:7,inds})
set(gca,'xticklabel',{'q_1','q_2','q_3','q_4','q_5','q_6','q_7'})
h = legend(legNames,'Location','best','Interpreter','none');
h.Title.String = 'Right Arm';
ylabel('RMSE')
savefig(gcf,[path1,'/figures/inPaper/JointTracking_RightArm.fig'],'compact')


%% left EE
figure;
bar(categorical(tabtmpLeft.Properties.RowNames(8:end),tabtmpLeft.Properties.RowNames(8:end)),tabtmpLeft{8:end,inds})
set(gca,'xticklabel',{'X','Y','Z','Roll','Pitch','Yaw'})
h = legend(legNames,'Location','best','Interpreter','none');
h.Title.String = 'Left Arm';
ylabel('RMSE')
savefig(gcf,[path1,'/figures/inPaper/SpatialTracking_LeftArm.fig'],'compact')


%% right EE
figure;
bar(categorical(tabtmpRight.Properties.RowNames(8:end),tabtmpRight.Properties.RowNames(8:end)),tabtmpRight{8:end,inds})
set(gca,'xticklabel',{'X','Y','Z','Roll','Pitch','Yaw'})
h = legend(legNames,'Location','best','Interpreter','none');
h.Title.String = 'Right Arm';
ylabel('RMSE')
savefig(gcf,[path1,'/figures/inPaper/SpatialTracking_RightArm.fig'],'compact')


