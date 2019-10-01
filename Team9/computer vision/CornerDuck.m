function [od] = CornerDuck(Duck)
%Takes as input a binary picture of the duck detected.
%Returns the center of the duck in terms of center of the binary picture

[y,x] = size(Duck);
L1 = [0,0];L2 = [0,0];
L3 = [0,0];L4 = [0,0];
flag = 0;

%Finds Corner 1
for Y = 1:y
    for X = x:-1:1
        if Duck(Y,X)
            L1(1) = X;
            L1(2) = Y;
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
        if Duck(Y,X)
            L2(1) = X;
            L2(2) = Y; 
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
        if Duck(Y,X)
            L3(1) = X;
            L3(2) = Y; 
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
        if Duck(Y,X)
            L4(1) = X;
            L4(2) = Y;
            flag = 1;
            break
        end
    end
    if flag == 1
      break
    end
end

% Calculate the center of the duck
od=zeros(2,1);
od(2) = -1*(0.5*(L1(1)+L2(1))-640) * pixilWidth;
od(1) = (-0.5*((L3(2)+L4(2))-360 )* pixilWidth;


Figure1 = figure('name','Output');
hold on;
spy(Duck,'R');
plot(L1(1),L1(2),'xK','MarkerSize',15);
plot(L2(1),L2(2),'xK','MarkerSize',15);
plot(L3(1),L3(2),'xK','MarkerSize',15);
plot(L4(1),L4(2),'xK','MarkerSize',15);
od=
end