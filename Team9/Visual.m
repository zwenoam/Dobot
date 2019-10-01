% Take a picture of the paper and define the workspace
cam = webcam('Logitech HD Webcam C270');
cam.resolution = '1280x720';
preview(cam);
Obj=Takephoto(cam);
% Obj=imglow;
[Paper]=Paperdetect(Obj);
pause(1);
[O, R, h, w,corner] = cornerDetection(Paper);

% Analyze the duck on the paper
[Duck]=BinaryDuck(Obj);
[L1,L2,L3,L4,od] = CornerDuck(Duck);

% Find the location of duck center in Dobot frame
xc=223;yc=0;  % camera center point measured
Oc=[xc;yc;0]; % projection of camera center point on paper 
Od=Oc+[od;0]; % duck center point in Dobot frame

% define the four points of the squares
S1=od+[30;30;0];
S2=od+[-30;30;0];
S3=od+[-30;-30;0];
S4=od+[30;-30;0];
S5=od+[30;30;0];
S=[S1,S2,S3,S4,S5];
d=79; %pen length
% Implement inverse kinematics
for i=1:5
    p=S(:,i);
    q=invkin(p,d);
    robot.setJointPositions(int16(q(1)),int16(q(2)),int16(q(3)),int16(0),int16(0))
    pause(0.06) 
end