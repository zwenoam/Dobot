function [Paper]=Paperdetect(workspace)
%%% This function convert the photo to a binary form, detects and
%%% save the area of paper as 1, detects and save the other areas
%%% as 0; 
%%% The output of this function is the binary logical set of the photo
%% Define color thresholds for paper (white)
channel1Min = 91.000;
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
Paper = sliderBP;


end
