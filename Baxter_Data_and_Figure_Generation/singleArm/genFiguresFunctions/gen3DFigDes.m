function [] = gen3DFigDes(fignum,Pdes,idx)
figure(fignum);
subplot(2,2,1);hold on;plot3(Pdes(1,:),Pdes(2,:),Pdes(3,:),'k','LineWidth',2);
plot3(Pdes(1,1),Pdes(2,1),Pdes(3,1),'g<','LineWidth',3,'MarkerSize',20);
plot3(Pdes(1,idx(1)),Pdes(2,idx(1)),Pdes(3,idx(1)),'m^','LineWidth',3,'MarkerSize',20);
plot3(Pdes(1,idx(2)),Pdes(2,idx(2)),Pdes(3,idx(2)),'m>','LineWidth',3,'MarkerSize',20);
plot3(Pdes(1,idx(3)),Pdes(2,idx(3)),Pdes(3,idx(3)),'mV','LineWidth',3,'MarkerSize',20);

subplot(2,2,2);hold on;plot3(Pdes(1,:),Pdes(2,:),Pdes(3,:),'k','LineWidth',2);
plot3(Pdes(1,1),Pdes(2,1),Pdes(3,1),'g>','LineWidth',3,'MarkerSize',20);
plot3(Pdes(1,idx(1)),Pdes(2,idx(1)),Pdes(3,idx(1)),'m^','LineWidth',3,'MarkerSize',20);
plot3(Pdes(1,idx(2)),Pdes(2,idx(2)),Pdes(3,idx(2)),'m<','LineWidth',3,'MarkerSize',20);
plot3(Pdes(1,idx(3)),Pdes(2,idx(3)),Pdes(3,idx(3)),'mV','LineWidth',3,'MarkerSize',20);

subplot(2,2,3);hold on;plot3(Pdes(1,:),Pdes(2,:),Pdes(3,:),'k','LineWidth',2);
plot3(Pdes(1,1),Pdes(2,1),Pdes(3,1),'g>','LineWidth',3,'MarkerSize',20);
plot3(Pdes(1,idx(1)),Pdes(2,idx(1)),Pdes(3,idx(1)),'m^','LineWidth',3,'MarkerSize',20);
plot3(Pdes(1,idx(2)),Pdes(2,idx(2)),Pdes(3,idx(2)),'m<','LineWidth',3,'MarkerSize',20);
plot3(Pdes(1,idx(3)),Pdes(2,idx(3)),Pdes(3,idx(3)),'mV','LineWidth',3,'MarkerSize',20);

subplot(2,2,4);hold on;plot3(Pdes(1,:),Pdes(2,:),Pdes(3,:),'k','LineWidth',2);
end