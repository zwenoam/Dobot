function workspace=Takephoto(cam)
%% Take a photo of the workspace
%%Take a picture of the desired workspace
%% Set the resolution of the camera

 %cam.resolution = '640x480';
 %cam.resolution = '320x240';

%% Take a picture and save the image
%preview(cam);
t=5;
pause(t);
workspace = snapshot(cam);
imshow(workspace);
end