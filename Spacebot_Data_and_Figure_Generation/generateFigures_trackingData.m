clear;clc;
load('simulationResults.mat')
ind6 = [1 2 3 5 6 7];
legErr = {'Tuned Without Load - Run Without Load','Tuned With Load - Run Without Load','Tuned For Both - Run Without Load','Tuned Without Load - Run With Load','Tuned With Load - Run With Load','Tuned For Both - Run With Load'};
fntSize = 12;
%% link tracking error
figure;
for ii = 1:6
    subplot(3,3,ii);hold on;
    plot(tunedNoLoad_noLoad.t,tunedNoLoad_noLoad.qerror(ii,:),'LineWidth',2);
    plot(tunedLoad_noLoad.t,tunedLoad_noLoad.qerror(ii,:),'LineWidth',2);
    plot(tunedBoth_noLoad.t,tunedBoth_noLoad.qerror(ii,:),'LineWidth',2);
    plot(tunedNoLoad_Load.t,tunedNoLoad_Load.qerror(ii,:),'LineWidth',2);
    plot(tunedLoad_Load.t,tunedLoad_Load.qerror(ii,:),'LineWidth',2);
    plot(tunedBoth_Load.t,tunedBoth_Load.qerror(ii,:),'LineWidth',2);
    xlabel('Time (s)');ylabel('Link Error (rad)');title(['Joint ',num2str(ii)])
end
subplot(3,3,8);hold on;
plot(tunedNoLoad_noLoad.t,tunedNoLoad_noLoad.qerror(7,:),'LineWidth',2);
plot(tunedLoad_noLoad.t,tunedLoad_noLoad.qerror(7,:),'LineWidth',2);
plot(tunedBoth_noLoad.t,tunedBoth_noLoad.qerror(7,:),'LineWidth',2);
plot(tunedNoLoad_Load.t,tunedNoLoad_Load.qerror(7,:),'LineWidth',2);
plot(tunedLoad_Load.t,tunedLoad_Load.qerror(7,:),'LineWidth',2);
plot(tunedBoth_Load.t,tunedBoth_Load.qerror(7,:),'LineWidth',2);
xlabel('Time (s)');ylabel('Link Error (rad)');title(['Joint ',num2str(7)])
legend(legErr,'FontSize',fntSize)




disp('Link Max Errors (rad)')
[max(abs(tunedNoLoad_noLoad.qerror),[],2) max(abs(tunedLoad_noLoad.qerror),[],2) max(abs(tunedBoth_noLoad.qerror),[],2) max(abs(tunedNoLoad_Load.qerror),[],2) max(abs(tunedLoad_Load.qerror),[],2) max(abs(tunedBoth_Load.qerror),[],2)]
disp('Link Max Errors (deg)')
[max(abs(tunedNoLoad_noLoad.qerror),[],2) max(abs(tunedLoad_noLoad.qerror),[],2) max(abs(tunedBoth_noLoad.qerror),[],2) max(abs(tunedNoLoad_Load.qerror),[],2) max(abs(tunedLoad_Load.qerror),[],2) max(abs(tunedBoth_Load.qerror),[],2)]*180/pi
disp('Link Error RMSE (rad)')
[vecnorm(tunedNoLoad_noLoad.qerror,2,2)/length(tunedNoLoad_noLoad.t) vecnorm(tunedLoad_noLoad.qerror,2,2)/length(tunedLoad_noLoad.t),...
    vecnorm(tunedBoth_noLoad.qerror,2,2)/length(tunedBoth_noLoad.t)  vecnorm(tunedNoLoad_Load.qerror,2,2)/length(tunedNoLoad_Load.t),...
    vecnorm(tunedLoad_Load.qerror,2,2)/length(tunedLoad_Load.t) vecnorm(tunedBoth_Load.qerror,2,2)/length(tunedBoth_Load.t)]


%% Spatial tracking error
figure;
for ii = 1:3
    subplot(2,4,ii);hold on;
    plot(tunedNoLoad_noLoad.t,tunedNoLoad_noLoad.EulerError(ii,:),'LineWidth',2);
    plot(tunedLoad_noLoad.t,tunedLoad_noLoad.EulerError(ii,:),'LineWidth',2);
    plot(tunedBoth_noLoad.t,tunedBoth_noLoad.EulerError(ii,:),'LineWidth',2);
    plot(tunedNoLoad_Load.t,tunedNoLoad_Load.EulerError(ii,:),'LineWidth',2);
    plot(tunedLoad_Load.t,tunedLoad_Load.EulerError(ii,:),'LineWidth',2);
    plot(tunedBoth_Load.t,tunedBoth_Load.EulerError(ii,:),'LineWidth',2);
    xlabel('Time (s)');ylabel('End Effector Orientation Error (rad)');
end
subplot(2,4,1);title('Roll');subplot(2,4,2);title('Pitch');subplot(2,4,3);title('Yaw')
for ii = 1:3
    subplot(2,4,ind6(ii+3));hold on;
    plot(tunedNoLoad_noLoad.t,tunedNoLoad_noLoad.Perror(ii,:)*100,'LineWidth',2);
    plot(tunedLoad_noLoad.t,tunedLoad_noLoad.Perror(ii,:)*100,'LineWidth',2);
    plot(tunedBoth_noLoad.t,tunedBoth_noLoad.Perror(ii,:)*100,'LineWidth',2);
    plot(tunedNoLoad_Load.t,tunedNoLoad_Load.Perror(ii,:)*100,'LineWidth',2);
    plot(tunedLoad_Load.t,tunedLoad_Load.Perror(ii,:)*100,'LineWidth',2);
    plot(tunedBoth_Load.t,tunedBoth_Load.Perror(ii,:)*100,'LineWidth',2);
    xlabel('Time (s)');ylabel('End Effector Position Error (cm)');
end
subplot(2,4,5);title('X');subplot(2,4,6);title('Y');subplot(2,4,7);title('Z')
legend(legErr,'FontSize',fntSize)



disp('EE Euler Max Errors (rad)')
[max(abs(tunedNoLoad_noLoad.EulerError),[],2) max(abs(tunedLoad_noLoad.EulerError),[],2) max(abs(tunedBoth_noLoad.EulerError),[],2),...
    max(abs(tunedNoLoad_Load.EulerError),[],2) max(abs(tunedLoad_Load.EulerError),[],2) max(abs(tunedBoth_Load.EulerError),[],2)]
disp('EE Euler Max Errors (deg)')
[max(abs(tunedNoLoad_noLoad.EulerError),[],2) max(abs(tunedLoad_noLoad.EulerError),[],2) max(abs(tunedBoth_noLoad.EulerError),[],2),...
    max(abs(tunedNoLoad_Load.EulerError),[],2) max(abs(tunedLoad_Load.EulerError),[],2) max(abs(tunedBoth_Load.EulerError),[],2)]*180/pi
disp('EE Euler Error RMSE (rad)')
[vecnorm(tunedNoLoad_noLoad.EulerError,2,2)/length(tunedNoLoad_noLoad.t) vecnorm(tunedLoad_noLoad.EulerError,2,2)/length(tunedLoad_noLoad.t),...
    vecnorm(tunedBoth_noLoad.EulerError,2,2)/length(tunedBoth_noLoad.t) vecnorm(tunedNoLoad_Load.EulerError,2,2)/length(tunedNoLoad_Load.t),...
    vecnorm(tunedLoad_Load.EulerError,2,2)/length(tunedLoad_Load.t) vecnorm(tunedBoth_Load.EulerError,2,2)/length(tunedBoth_Load.t)]

disp('EE Position Max Errors (m)')
[max(abs(tunedNoLoad_noLoad.Perror),[],2) max(abs(tunedLoad_noLoad.Perror),[],2) max(abs(tunedBoth_noLoad.Perror),[],2),...
    max(abs(tunedNoLoad_Load.Perror),[],2) max(abs(tunedLoad_Load.Perror),[],2) max(abs(tunedBoth_Load.Perror),[],2)]


disp('EE Position Max Errors (cm)')
[max(abs(tunedNoLoad_noLoad.Perror),[],2) max(abs(tunedLoad_noLoad.Perror),[],2) max(abs(tunedBoth_noLoad.Perror),[],2),...
    max(abs(tunedNoLoad_Load.Perror),[],2) max(abs(tunedLoad_Load.Perror),[],2) max(abs(tunedBoth_Load.Perror),[],2)]*100

disp('EE Position Error RMSE (m)')
[vecnorm(tunedNoLoad_noLoad.Perror,2,2)/length(tunedNoLoad_noLoad.t) vecnorm(tunedLoad_noLoad.Perror,2,2)/length(tunedLoad_noLoad.t),...
    vecnorm(tunedBoth_noLoad.Perror,2,2)/length(tunedBoth_noLoad.t) vecnorm(tunedNoLoad_Load.Perror,2,2)/length(tunedNoLoad_Load.t),...
    vecnorm(tunedLoad_Load.Perror,2,2)/length(tunedLoad_Load.t) vecnorm(tunedBoth_Load.Perror,2,2)/length(tunedBoth_Load.t)]

