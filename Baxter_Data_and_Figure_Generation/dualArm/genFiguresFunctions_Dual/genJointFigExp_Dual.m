function [] = genJointFigExp_Dual(fignum,q_baxter,t)
figure(fignum);
for ii = 1:6
    subplot(3,3,ii);hold on;plot(t,q_baxter(ii,:)*180/pi,'LineWidth',2);title(['Joint ',num2str(ii)])
    xlabel('Time (s)'); ylabel('Position (deg)');
end
subplot(3,3,8);hold on;plot(t,q_baxter(7,:)*180/pi,'LineWidth',2);title(['Joint ',num2str(7)]);

end