clear;clc;
path1 = pwd;
addpath([path1,'/neededFiles'])


%%
pathType = 'complex'; %complex, 16
part = 'start'; %start, end
Ngear = [6529;2737;5074;4631;4560;3611;1674];

HeightScaleFactor = 1.5;
labelSize = 10;
titleSize = 12;
legendSize = 12;
wlim = [1e-5 1000];
flim = [1e-5 15];

%% get pose / gen OL system
if strcmp(pathType,'complex')
    poses = load('forPaper_linearSEW_Path_smallestAbsoluteJ7Movement.mat','q_lambda');
    if strcmp(part,'start')
        pose = poses.q_lambda(:,1);
    else
        pose = poses.q_lambda(:,end);
    end
else
    poses = load('pathno16_ps01.mat','q_lambda');
    if strcmp(part,'start')
        pose = poses.q_lambda(:,1);
    else
        pose = poses.q_lambda(:,end);
    end
end
[G,Gload,~,~] = genFullLinModel_withAndWithoutLoad_reducedFriction_withMotor(pose);
%% get controllers / gen CL systems
 Cnotmp = load('PDnoLoadOnly_contTime_noMargins.mat');
 Cyestmp = load('PDLoadOnly_contTime_noMargins.mat');
 Cbothtmp = load('PDboth_contTime_noMargins.mat');


for ii = 1:7
    Cno(ii,ii) = tf(pid(Cnotmp.kp(ii),Cnotmp.ki(ii),Cnotmp.kd(ii),1/Cnotmp.N(ii))/Ngear(ii));
    Cyes(ii,ii) = tf(pid(Cyestmp.kp(ii),Cyestmp.ki(ii),Cyestmp.kd(ii),1/Cyestmp.N(ii))/Ngear(ii));
    Cboth(ii,ii) = tf(pid(Cbothtmp.kp(ii),Cbothtmp.ki(ii),Cbothtmp.kd(ii),1/Cbothtmp.N(ii))/Ngear(ii));
    decMag = 20;
       
    CLSISO{1}{1}(ii,ii) = feedback(G(ii,ii)*Cno(ii,ii),1);
    CLSISO{2}{1}(ii,ii) = feedback(G(ii,ii)*Cyes(ii,ii),1);
    CLSISO{3}{1}(ii,ii) = feedback(G(ii,ii)*Cboth(ii,ii),1);
    
    CLSISO{1}{2}(ii,ii) = feedback(Gload(ii,ii)*Cno(ii,ii),1);
    CLSISO{2}{2}(ii,ii) = feedback(Gload(ii,ii)*Cyes(ii,ii),1);
    CLSISO{3}{2}(ii,ii) = feedback(Gload(ii,ii)*Cboth(ii,ii),1);
end


%% gen bodes
% opts = bodeoptions;
% opts.FreqUnits = 'Hz';
% opts.XLim = {[1e-5 1000]};
% opts.YLim = {[-10 10]};

for ii = 1:3
    for jj = 1:2
        [mtmp,ptmp,wtmp] = bode(CLSISO{ii}{jj},{wlim(1),wlim(2)});
        mSISO{ii}{jj} = mag2db(mtmp);
        pSISO{ii}{jj} = ptmp;
        wSISO{ii}{jj} = wtmp/(2*pi);
    end
end
        
%%
contrType = {'Tuned Without Load','Tuned With Load','Tuned For Both'};
loadState = {'Run Without Load','Run With Load'};


for jj = 1:2
        figure('WindowState','maximized');
        for kk = 1:7
               subplot(3,3,kk*(kk~=7)+8*(kk==7));
               semilogx(squeeze(wSISO{1}{jj}),squeeze(mSISO{1}{jj}(kk,kk,:)),...
                   squeeze(wSISO{2}{jj}),squeeze(mSISO{2}{jj}(kk,kk,:)),...
                   squeeze(wSISO{3}{jj}),squeeze(mSISO{3}{jj}(kk,kk,:)),'LineWidth',2);
               ylim([-10 10]); xlim(flim); xticks([1e-5 1e-3 0.1 10]); grid on;
               xlabel('Frequency (Hz)','FontSize',labelSize);
               ylabel({'Magnitude'; '(dB)'},'FontSize',labelSize);
               title(['Joint ',num2str(kk)])
        end
        h_leg = legend('Tuned Without Load',...
            'Tuned With Load','Tuned For Both','FontSize',legendSize);
end

