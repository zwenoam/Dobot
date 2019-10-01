function [origin, rotation, height, width,corner] = cornerDetection(Paper)
%Takes as input a bitMask picture of the paper to be drawn on.
%Returns the Origin in terms of its location in the Bit Mask relative to
%the center in mm, the rotation of the paper relative to the camera, and the
%height and the width of the paper, height being the distance between the
%far left corner and the bottom most corner and width being the distance
%between the far left corner and the top corner
[y,x] = size(Paper);
corner1 = [0,0];corner2 = [0,0];
corner3 = [0,0];corner4 = [0,0];
flag = 0;
pixilWidth = 0.1522;
%Finds Corner 1
for Y = 1:y
    for X = x:-1:1
        if Paper(Y,X)
            corner1(1) = X;
            corner1(2) = Y;
            flag = 1;
            break
        end
    end
    if flag == 1
        flag = 0;
        break
    end
end

%Finds Corner 2
for Y = y:-1:1
    for X = 1:x
        if Paper(Y,X)
            corner2(1) = X;
            corner2(2) = Y; 
            flag = 1;
            break
        end
    end
    if flag == 1
        flag = 0;
        break
    end
end

%Finds Corner 3
for X = 1:x
    for Y = 1:y
        if Paper(Y,X)
            corner3(1) = X;
            corner3(2) = Y; 
            flag = 1;
            break
        end
    end
    if flag == 1
        flag = 0;
        break
    end
end

%Finds Corner 4
for X = x:-1:1
    for Y = y:-1:1
        if Paper(Y,X)
            corner4(1) = X;
            corner4(2) = Y;
            flag = 1;
            break
        end
    end
    if flag == 1
        flag = 0;
        break
    end
end

%Relates the orgin point to the center of the image in mm

if corner1(1) < corner2(1)
    %Recalculates Corner 1
     fprintf('test');
    for Y = 1:y
        for X = 1:x
            if Paper(Y,X)
                corner1(1) = X;
                corner1(2) = Y;
                flag = 1;
                break
            end
        end
        if flag == 1
            flag = 0;
            break
        end
    end

    %Recalculates Corner 2
    for Y = y:-1:1
        for X = x:-1:1
            if Paper(Y,X)
                corner2(1) = X;
                corner2(2) = Y; 
                flag = 1;
                break
            end
        end
        if flag == 1
            flag = 0;
            break
        end
    end

    %Recalculates Corner 3
    for X = 1:x
        for Y = y:-1:1
            if Paper(Y,X)
                corner3(1) = X;
                corner3(2) = Y; 
                flag = 1;
                break
            end
        end
        if flag == 1
            flag = 0;
            break
        end
    end

    %Recalculates Corner 4
    for X = x:-1:1
        for Y = 1:y
            if Paper(Y,X)
                corner4(1) = X;
                corner4(2) = Y;
                flag = 1;
                break
            end
        end
        if flag == 1
            break
        end
    end
    
    origin=zeros(2,1);
    % Calculate the coordinate of the origin point
    origin(2) = -1*(corner3(1) - 640) * pixilWidth;
    origin(1) = ((corner3(2) * -1)+ 360) * pixilWidth;
    
    % Calculate the rotation angle of the paper from the Dobot frame
    rotation = atan((corner3(2)-corner1(2))/((corner1(1)-corner3(1))));
else
    
    % Calculate the coordinate of the origin point
    origin(2) = -1*(corner2(1) - 640) * pixilWidth;
    origin(1) = ((corner2(2) * -1)+ 360) * pixilWidth;
    % Calculate the rotation angle of the paper from the Dobot frame
    rotation = atan((corner1(2)-corner4(2))/((corner4(1)-corner1(1))));
end
%Calclulates the width height and rotation;
width = sqrt(((corner3(1)-corner1(1))^2)+(corner3(2)-corner1(2))^2)*pixilWidth;
height = sqrt(((corner3(1)-corner2(1))^2)+(corner3(2)-corner2(2))^2)*pixilWidth;
corner=[corner1;corner2;corner3;corner4];

Figure1 = figure('name','Output');
hold on;
spy(Paper,'B');
plot(corner1(1),corner1(2),'xK','MarkerSize',15);
plot(corner2(1),corner2(2),'xK','MarkerSize',15);
plot(corner3(1),corner3(2),'xK','MarkerSize',15);
plot(corner4(1),corner4(2),'xK','MarkerSize',15);
end