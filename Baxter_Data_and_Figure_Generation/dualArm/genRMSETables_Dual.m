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
%colNames = {'OpenLoop_runNoLoad','TunedForNoLoad_runNoLoad','Tune%dForLoad_runNoLoad','TunedForBothModels_runNoLoad',...
 %   'OpenLoop_runWithLoad','TunedForNoLoad_runWithLoad','TunedForL%oad_runWithLoad','TunedForBothModels_runWithLoad'};
colNames = {'OL_NoLoad','TuneNoLoad_NoLoad','TuneLoad_NoLoad','TuneBoth_NoLoad',...
    'OL_Load','TuneNoLoad_Load','TuneLoad_Load','TuneBoth_Load'};
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

note = 'rotermse is roll, pitch, yaw';
%%
eval(['TabRMSELeft= tabtmpLeft;'])
eval(['TabRMSERight=tabtmpRight;'])
clear colNames rowNames
save([path1,'/RMSE/RMSETables.mat'],'TabRMSELeft','TabRMSERight')
%%
figure;
TString = evalc('disp(tabtmpLeft)');
% Use TeX Markup for bold formatting and underscores.
TString = strrep(TString,'<strong>','\bf');
TString = strrep(TString,'</strong>','\rm');
TString = strrep(TString,'_','\_');
% Get a fixed-width font.
FixedWidth = get(0,'FixedWidthFontName');
% Output the table using the annotation command.
annotation(gcf,'Textbox','String',TString,'Interpreter','Tex',...
    'FontName',FixedWidth,'Units','Normalized','Position',[0 0 1 1]);
pos = get(gcf,'position');
set(gcf,'position',[pos(1:2)/4 pos(3)*1.6 pos(4)*0.65])
savefig(gcf,[path1,'/RMSE/RMSETableLeftArm.fig'],'compact')
%%
figure;
TString = evalc('disp(tabtmpRight)');
% Use TeX Markup for bold formatting and underscores.
TString = strrep(TString,'<strong>','\bf');
TString = strrep(TString,'</strong>','\rm');
TString = strrep(TString,'_','\_');
% Get a fixed-width font.
FixedWidth = get(0,'FixedWidthFontName');
% Output the table using the annotation command.
annotation(gcf,'Textbox','String',TString,'Interpreter','Tex',...
    'FontName',FixedWidth,'Units','Normalized','Position',[0 0 1 1]);
pos = get(gcf,'position');
set(gcf,'position',[pos(1:2)/4 pos(3)*1.6 pos(4)*0.65])
savefig(gcf,[path1,'/RMSE/RMSETableRightArm.fig'],'compact')
