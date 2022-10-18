function [] = gen3DFigExp_Dual(fignum,Pexp,c)
figure(fignum);
subplot(2,2,1);hold on;
plot3(Pexp(1,:),Pexp(2,:),Pexp(3,:),c,'LineWidth',2);xlabel('X');ylabel('Y');zlabel('Z');view(3)
subplot(2,2,2);hold on;
plot3(Pexp(1,:),Pexp(2,:),Pexp(3,:),c,'LineWidth',2);xlabel('X');ylabel('Y');zlabel('Z');view([1 0 0])
subplot(2,2,3);hold on;
plot3(Pexp(1,:),Pexp(2,:),Pexp(3,:),c,'LineWidth',2);xlabel('X');ylabel('Y');zlabel('Z');view([0 1 0])
subplot(2,2,4);hold on;
plot3(Pexp(1,:),Pexp(2,:),Pexp(3,:),c,'LineWidth',2);xlabel('X');ylabel('Y');zlabel('Z');view([0 0 1])
end