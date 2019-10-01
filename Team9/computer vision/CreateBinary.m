function [BinaryPic]=CreateBinary()
%%Take a picture of the desired workspace
%% Set the resolution of the camera
cam = webcam('Integrated Webcam');
cam.resolution = '1280x720';
% cam.resolution = '640x480';
% cam.resolution = '320x240';

%% Take a picture and save the image
preview(cam);
t=5;
pause(t);
workspace = snapshot(cam);
imshow(workspace);

%% Define color thresholds
% Define thresholds for channel 1 based on histogram settings
channel1Min = 200.000;
channel1Max = 255.000;

% Define thresholds for channel 2 based on histogram settings
channel2Min = 84.000;
channel2Max = 255.000;

% Define thresholds for channel 3 based on histogram settings
channel3Min = 86.000;
channel3Max = 255.000;

%% Transfer the image to binary form
I=workspace;
sliderBP = (I(:,:,1) >= channel1Min ) & (I(:,:,1) <= channel1Max) & ...
    (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
    (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);
BinaryPic = sliderBP;
spy(BP);
end
