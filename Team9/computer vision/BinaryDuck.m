function [duck]=BinaryDuck(Obj)
%%% This function convert the photo to a binary form, detects and
%%% save the letters written by pen as 1, detects and save the blank paper 
%%% space as 0; 
%%% The output of this function is the binary logical set of the photo
%% Define color thresholds for letters (yellow)
% Define thresholds for channel 1 based on histogram settings
channel1Min = 91.00;
channel1Max = 255.00;
% Define thresholds for channel 2 based on histogram settings
channel2Min = 84.0;
channel2Max = 255.00;
% Define thresholds for channel 3 based on histogram settings
channel3Min = 0;
channel3Max = 86.00;
%% Transfer the image to binary form
L=Obj;
sliderBP = (L(:,:,1) >= channel1Min ) & (L(:,:,1) <= channel1Max) & ...
    (L(:,:,2) >= channel2Min ) & (L(:,:,2) <= channel2Max) & ...
    (L(:,:,3) >= channel3Min ) & (L(:,:,3) <= channel3Max);
duck = sliderBP;
spy(duck);
end
