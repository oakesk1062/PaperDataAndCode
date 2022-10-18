
clear;clc;
%%
path1 = pwd;
addpath([path1,'/data'])
addpath([path1,'/genFiguresFunctions_Dual'])
mkdir([path1,'/RMSE/PercentDifference'])
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
%colNames = {'OpenLoop_runNoLoad','TunedForNoLoad_runNoLoad','TunedForLoad_runNoLoad','TunedForBothModels_runNoLoad',...
%    'OpenLoop_runWithLoad','TunedForNoLoad_runWithLoad','TunedForLoad_runWithLoad','TunedForBothModels_runWithLoad'};
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

%%
for ii = 1:length(colNames)
    qediffLeft = (qermseLeft-qermseLeft(:,ii))./qermseLeft(:,ii)*100;
    transediffLeft = (transermseLeft-transermseLeft(:,ii))./transermseLeft(:,ii)*100;
    rotediffLeft = (rotermseLeft-rotermseLeft(:,ii))./rotermseLeft(:,ii)*100;
    eval(['tab_',colNames{ii},'LeftArm = array2table([qediffLeft;transediffLeft;rotediffLeft],''VariableNames'',colNames,''RowNames'',rowNames);']);
    eval(['tabName = tab_',colNames{ii},'LeftArm;']);
    genTableVisual(tabName)
    savefig(gcf,[path1,'/RMSE/PercentDifference/PercentDifferenceTable_',colNames{ii},'LeftArm.fig'],'compact')
    
    qediffRight = (qermseRight-qermseRight(:,ii))./qermseRight(:,ii)*100;
    transediffRight = (transermseRight-transermseRight(:,ii))./transermseRight(:,ii)*100;
    rotediffRight = (rotermseRight-rotermseRight(:,ii))./rotermseRight(:,ii)*100;
    eval(['tab_',colNames{ii},'RightArm = array2table([qediffRight;transediffRight;rotediffRight],''VariableNames'',colNames,''RowNames'',rowNames);']);
    eval(['tabName = tab_',colNames{ii},'RightArm;']);
    genTableVisual(tabName)
    savefig(gcf,[path1,'/RMSE/PercentDifference/PercentDifferenceTable_',colNames{ii},'RightArm.fig'],'compact')
end


clear colNames ii qediff qermse rotediff rotermse rowNames transediff transermse
save([path1,'/RMSE/PercentDifference/PercentDiffTables.mat'])

close all;

function [] = genTableVisual(tabtmp)
figure;
TString = evalc('disp(tabtmp)');
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

end

