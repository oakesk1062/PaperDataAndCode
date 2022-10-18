function [] = genJointFigDes(fignum,q_desired,t)
figure(fignum);
for ii = 1:6
    subplot(3,3,ii);hold on;plot(t,q_desired(ii,:)*180/pi,'k','LineWidth',2);title(['Joint ',num2str(ii)])
    xlabel('Time (s)'); ylabel('Position (deg)');
end
subplot(3,3,8);hold on;plot(t,q_desired(7,:)*180/pi,'k','LineWidth',2);title(['Joint ',num2str(7)]);

end

