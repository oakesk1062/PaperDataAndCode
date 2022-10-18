function [robot_mdl,robot_structure] = defineSpacebot_reducedFriction_withMotor()

% This function defines the spacebot kinematic and dynamic model. 
% This function also generates a structure for visualization.
%
% Inputs: None
%
% Outputs:
% robot_mdl: structure of the form
        % .DH_d: values for d (m) in modified DH parameters
        % .DH_alpha: values for alpha (rad) in modified DH parameters
        % .kin.H: joint axes for alternate Product of Exponentials (PoE)
        %   formulation
        % .kin.P: inter-joint translation for alternate PoE formulation
        % .kin.joint_type: joint types used for code leveraging alternate
        %   PoE formulation
        % .mprops.Im: motor inertias (kg m^2)
        % .mprops.bm: motor friction (Nm s/rad)
        % .mprops.N: gear ratios
        % .mprops.K: linear spring constants (Nm/rad)
        % .mprops.bL: gearbox friction (Nm s/rad)
        % .mprops.b: coupled friction (Nm s/rad)
        % .mprops.m: link masses (kg)
        % .mpropsSS.c: center of gravity vector from joint i to COM i 
        %   (in ith frame) (m) using Simscape frames
        % .mprops.c: center of gravity vector from joint i to COM i 
        %   (in ith frame) (m) using PoE frames
        % .mpropsSS.I: inertia tensors of each link (about ith COM) 
        %   (kg m^2) using Simscape frames
        % .mprops.I: inertia tensors of each link (at ith frame) (kg m62)
        %   using PoE frames
        % .name: robot name
        % .limit: structure containing pertinent limits
        % .vis: structure constaining visualization parameters
        % .bprops.RB0: rotation matrix from base satellite frame to robot
        %   base frame
        % .bprops.PB0: translation from base satellite frame to robot base
        %   frame represented in satellite base frame
        % .bprops.m: base satellite mass
        % .bprops.c: base satellite COM vector represented in base
        %   satellite frame
        % .bprops.I: base satellite inertia at COM
        % .bprops.base_r: base radius for visualization in Simscape
        % .bprops.base_length: base length for visualization in Simscape
% robot_structure: structure for visualization 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define basic axes:
x0 = [1;0;0]; y0 = [0;1;0]; z0 = [0;0;1]; zed = zeros(3,1);

% Grab standard robot structure
robot_mdl = defineEmptyRobot(1);

robot_mdl.limit.tauLimit = [0.16;0.16;0.065;0.14;0.03;0.015;0.0085];

tmp = [1.5;1.5;3;3;4;4;4]*2*pi/60;
robot_mdl.limit.velocity_limit = [-tmp tmp];

% Define Gear Ratios:
robot_mdl.mprops.N = [6529;2737;5074;4631;4560;3611;1674];

% Kinematic Properties:
% Define link lengths here (correspond to absolute value of modified 
% DH parameter d):
l1 = 0.48;
l2 = 0.37;
l3 = 1.06;
l4 = 0.28;
l5 = 1.18;
l6 = 0.37;
% DH Parameters:
robot_mdl.DH_d = [l1;l2;l3;-l4;l5;0;0;l6];
robot_mdl.DH_alpha = [0;pi/2;-pi/2;pi/2;-pi/2;pi/2;-pi/2];
% Alternate PoE formulation:
robot_mdl.kin.H = [z0 -y0 z0 -y0 z0 -y0 z0];
robot_mdl.kin.P = [l1*z0 zed [0; -l2; l3] zed [0; l4; l5] zed zed l6*z0];
robot_mdl.kin.joint_type = zeros(1,7);
robot_mdl.joint_type = robot_mdl.kin.joint_type; % Define twice for different functions

% Set joint limits:
robot_mdl.limit.lower_joint_limit = [-228;-223;-260;-125;-290;-184;-360]*pi/180;
robot_mdl.limit.upper_joint_limit = [128;126;134;113;106;178;150]*pi/180;

% Motor Properties:
%robot_mdl.mprops.bm = [1e-6;1e-6;7.5e-7;7.5e-7;2.5e-7;2.5e-7;2.5e-7];
robot_mdl.mprops.Im = [1.92e-06,2.48e-06,1.44e-06,2.59e-06,5.96e-07,7.23e-07,6.31e-07];

% Joint Properties:
robot_mdl.mprops.K = [2.59e5;1.9e5;9.83e4;1.19e5;1.55e4;1.61e4;8.07e3];
robot_mdl.mprops.bl = [4500;4550;2000;3500;3200;3250;1400];
robot_mdl.mprops.b = [158;285;230;435;112;220;157];
robot_mdl.mprops.bl = robot_mdl.mprops.bl/10;
%robot_mdl.mprops.b = robot_mdl.mprops.b;
robot_mdl.mprops.bm = 1e-6*ones(7,1);

% Link Properties:
robot_mdl.mprops.m = [18;9;9;7;4;2.5;17];
cSS = [0,   -0.003,     0,      0.002,-0.001,0.003,0.015;...
    0.018,  -0.010, -0.004,     0.003,-0.197,-0.004,0.019;...
    -0.043, -0.087, -0.118,     0.176,-0.165,0.040,0.530];
robot_mdl.mpropsSS.c = cSS;
robot_mdl.mprops.c = [cSS(:,1),...
    [1 0 0; 0 0 -1; 0 1 0]*[cSS(1,2);cSS(2,2);cSS(3,2)+l2],...
    cSS(:,3),[1 0 0; 0 0 -1; 0 1 0]*[cSS(1,4);cSS(2,4);cSS(3,4)-l4],...
    cSS(:,5),[1 0 0; 0 0 -1; 0 1 0]*cSS(:,6),cSS(:,7)];
% Specify link inertias in MDH: 
IMDH = zeros(3,3,7);
IMDH(:,:,1) = [0.39,0,0;0,0.131,-0.008;0,-0.008,0.25];
IMDH(:,:,2) = [0.36,0.003,0.004;0.003,0.142,0.001;0.004,0.001,0.146];
IMDH(:,:,3) = [2.275,0,-0.001;0,0.068,0.039;-0.001,0.039,2.836];
IMDH(:,:,4) = [0.089,0.001,0;0.001,0.021,0.002;0,0.002,0.061];
IMDH(:,:,5) = [0.558,0,0;0,0.051,0.227;0,0.227,1.002];
IMDH(:,:,6) = [0.024,0,0;0,0.013,0;0,0,0.197];
IMDH(:,:,7) = [0.21,0,0;0,0.014,0;0,0,0.135];
% Convert to Simscape frames:
robot_mdl.mpropsSS.I = zeros(3,3,7);
robot_mdl.mpropsSS.I(:,:,1) = [1 0 0; 0 0 -1; 0 1 0]*IMDH(:,:,1)*[1 0 0; 0 0 -1; 0 1 0]';
robot_mdl.mpropsSS.I(:,:,2) = [1 0 0; 0 0 1; 0 -1 0]*IMDH(:,:,2)*[1 0 0; 0 0 1; 0 -1 0]';
robot_mdl.mpropsSS.I(:,:,3) = [1 0 0; 0 0 -1; 0 1 0]*IMDH(:,:,3)*[1 0 0; 0 0 -1; 0 1 0]';
robot_mdl.mpropsSS.I(:,:,4) = [1 0 0; 0 0 1; 0 -1 0]*IMDH(:,:,4)*[1 0 0; 0 0 1; 0 -1 0]';
robot_mdl.mpropsSS.I(:,:,5) = [1 0 0; 0 0 -1; 0 1 0]*IMDH(:,:,5)*[1 0 0; 0 0 -1; 0 1 0]';
robot_mdl.mpropsSS.I(:,:,6) = [1 0 0; 0 0 1; 0 -1 0]*IMDH(:,:,6)*[1 0 0; 0 0 1; 0 -1 0]';
robot_mdl.mpropsSS.I(:,:,7) = [1 0 0; 0 0 -1; 0 1 0]*IMDH(:,:,7)*[1 0 0; 0 0 -1; 0 1 0]';
% Convert to PoE frames:
IcPoE = zeros(3,3,7);
IcPoE(:,:,1) = robot_mdl.mpropsSS.I(:,:,1);
IcPoE(:,:,2) = IMDH(:,:,2);
IcPoE(:,:,3) = robot_mdl.mpropsSS.I(:,:,3);
IcPoE(:,:,4) = IMDH(:,:,4);
IcPoE(:,:,5) = robot_mdl.mpropsSS.I(:,:,5);
IcPoE(:,:,6) = IMDH(:,:,6);
IcPoE(:,:,7) = robot_mdl.mpropsSS.I(:,:,7);

% Compute link inertias at PoE frames
IPoE = zeros(3,3,7);
for k = 1:7
    IPoE(:,:,k) = IcPoE(:,:,k) - robot_mdl.mprops.m(k)*(hat(robot_mdl.mprops.c(:,k))*hat(robot_mdl.mprops.c(:,k)));
end  
robot_mdl(1).mprops.I = IPoE;

% Define base properties
robot_mdl.bprops.RB0 = eye(3);
robot_mdl.bprops.PB0 = [0.4;0;2];
robot_mdl.bprops.m = 3660;
robot_mdl.bprops.c = [-0.3;0.4;-0.2];
robot_mdl.bprops.I = [37350,650,650;650,21270,-2210;650,-2210,7610];
robot_mdl.bprops.base_r = 0.6;
robot_mdl.bprops.base_length = 4;

% Name robot:
robot_mdl.name = 'Spacebot Arm';

% Set visualization parameters:
joint_radius = [0.2;0.2;0.2;0.2;0.1;0.1;0.1];
joint_height = [0.4;0.4;0.4;0.4;0.4;0.4;0.4];
joint_props = {'FaceColor', [0.3;0.3;0.3]};
link_props_light = {'FaceColor', [0.3;0.3;0.3],'EdgeAlpha', 0}; 
link_props_dark = {'FaceColor', [0.6;0.6;0.6],'EdgeAlpha', 0};
link_props_white = {'FaceColor',[0;0;0],'EdgeAlpha',0};

% Build visualization model:
robot_mdl.vis.joints = ...
        struct('param',cell(1,7),'props',cell(1,7));
for n=1:7
    robot_mdl.vis.joints(n).param = ...
                               struct('radius',joint_radius(n), ...
                               'height',joint_height(n));
    robot_mdl.vis.joints(n).props = joint_props;
end
    
robot_mdl.vis.links = struct('handle', cell(1,8), ...
                            'R', cell(1,8), 't', cell(1,8), ...
                            'param',cell(1,8),'props',cell(1,8));
                            
robot_mdl.vis.links(1).handle = @createCylinder;
robot_mdl.vis.links(1).R = eye(3);
robot_mdl.vis.links(1).t = 0.5*l1*z0; 
robot_mdl.vis.links(1).param = ...
        struct('radius', 0.2, 'height', l1);
robot_mdl.vis.links(1).props = link_props_light;                          
                      
robot_mdl.vis.links(2).handle = @createCylinder;
robot_mdl.vis.links(2).R = rot(x0,pi/2);
robot_mdl.vis.links(2).t = 0.5*l2*-y0;
robot_mdl.vis.links(2).param = ...
        struct('radius', 0.2, 'height', l2);
robot_mdl.vis.links(2).props = link_props_dark;

robot_mdl.vis.links(3).handle = @createCylinder;
robot_mdl.vis.links(3).R = eye(3);
robot_mdl.vis.links(3).t = ((-l2*y0) + (0.5*(l3-0.2)*z0));
robot_mdl.vis.links(3).param = ...
        struct('radius', 0.2, 'height', (l3 + 0.2));
robot_mdl.vis.links(3).props = link_props_light;

robot_mdl.vis.links(4).handle = @createCylinder;
robot_mdl.vis.links(4).R = rot(x0,-pi/2);
robot_mdl.vis.links(4).t = 0.5*l4*y0;
robot_mdl.vis.links(4).param = ...
        struct('radius', 0.2, 'height', l4);
robot_mdl.vis.links(4).props = link_props_dark;

robot_mdl.vis.links(5).handle = @createCylinder;
robot_mdl.vis.links(5).R = eye(3);
robot_mdl.vis.links(5).t = (l4*y0 + 0.5*(l5-0.6)*z0);
robot_mdl.vis.links(5).param = ...
        struct('radius', 0.2, 'height', (l5-0.2));
robot_mdl.vis.links(5).props = link_props_light;

robot_mdl.vis.links(6).handle = @createCylinder;
robot_mdl.vis.links(6).R = rot(x0,pi/4);
robot_mdl.vis.links(6).t = ((-0.25*y0) + (-0.25*z0));
robot_mdl.vis.links(6).param = ...
        struct('radius', 0.075, 'height', 0.6);
robot_mdl.vis.links(6).props = link_props_dark;

robot_mdl.vis.links(7).handle = @createCylinder;
robot_mdl.vis.links(7).R = rot(x0,-pi/2);
robot_mdl.vis.links(7).t = -0.25*y0;
robot_mdl.vis.links(7).param = ...
        struct('radius', 0.075, 'height', 0.5);
robot_mdl.vis.links(7).props = link_props_dark;

robot_mdl.vis.links(8).handle = @createCylinder;
robot_mdl.vis.links(8).R = eye(3);
robot_mdl.vis.links(8).t = 0.5*l6*z0;
robot_mdl.vis.links(8).param = ...
        struct('radius', 0.05, 'height', l6);
robot_mdl.vis.links(8).props = link_props_white;

% Define dimensions of coordinate frame
robot_mdl.vis.frame = struct('scale', 0.4, 'width', 0.05);
    
% Define structure for full combined robot
robot_structure = defineEmptyRobotStructure(1);
robot_structure.name = robot_mdl.name;
[robot_structure.create_properties] = deal({'CreateFrames','on'});
end