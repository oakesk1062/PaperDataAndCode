clear; clc;
%%
path1 = pwd;
addpath([path1,'/data'])
mkdir([path1,'/RMSE/Table'])
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

note = 'rotermse is roll, pitch, yaw';

tabtmp = array2table([qermse;transermse;rotermse],'VariableNames',colNames,'RowNames',rowNames);

eval(['TabRMSE= tabtmp;'])
clear colNames rowNames
save([path1,'/RMSE/RMSE_Table.mat'])

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
savefig(gcf,[path1,'/RMSE/RMSETable.fig'],'compact')

%%
rmpath([path1,'/data'])

