clear; close;clc;
robot = RobotRaconteur.Connect('tcp://localhost:10001/dobotRR/dobotController');
% measuring and set the pen length
d=79;
%% D straight
% Set up the start point and the end point of the straight
xs = 216; %x start
ys = 0; %y start
xe = 166; %x end
ye = 0; %y end

p=[xs,xe;ys,ye;0,0];

Q = zeros(3,2);
for j=1:2
   Q(:,j) = invkin(p(:,j),d);
   Q=180*Q/pi;
   robot.setJointPositions(int16(Q(1,j)),int16(Q(2,j)),int16(Q(3,j)),int16(0),int16(0))
   pause(0.2)  % stop between each point
%  Try to control the speed of movement by adjusting the pause time
%  pause(0.1)
%  pause(0.5)
end

% raise pen at the end point up for 10mm
pause(0.5)
p=[166;0;10];
q = invkin(p,d);
q=180*q/pi;
robot.setJointPositions(int16(q(1)),int16(q(2)),int16(q(3)),int16(0),int16(0));

clear Q e; 

%% D round
pause(0.5)

ldot=.2; T=1/ldot; % T=length of time to travel the path
%ldot=.1;
%ldot=.5;
%ldot=1;
%define the circle

r=25; %(mm) radius of the circle
xc = 191; %x center of circle
yc = 0; %y center of circle

dt=.1;
t=(0:dt:T);
N=length(t);
q=zeros(3,N);
u=zeros(3,N-1);
L=zeros(1,N);

q(:,1)=[166;0;0];
maxunorm=100;
u_planned = zeros(2,N-1);
u_p = zeros(2,N-1);
normu=norm(u_p);

for k=1:N-1
    qd=[r*cos((L(k)-1)*pi)+xc;-r*sin((L(k)-1)*pi)+yc];
    u_planned(:,k)=-k*(q(1:2,k)-qd)*ldot;
    
    if norm(u_planned(:,k))>maxunorm
        u_p(:,k)=u_planned(:,k)/norm(u_planned(:,k))*maxunorm;
    else
        u_p(:,k)=u_planned(:,k);
    end
    normu(k)=norm(u_p(:,k));
    u(:,k)=[u_p(:,k);0];
    q(:,k+1)=q(:,k)+ dt * u(:,k);
    L(k+1)=L(k)+ldot*dt;
end

qd=[r*cos((L-1)*pi)+xc;-r*sin((L-1)*pi)+yc];
q(:,N) = [qd(:,length(qd));0];

figure(1);plot(q(1,:),q(2,:),'-k.');
legend('q')
hold on

Q = zeros(1,3,length(q));
for j=1:length(q)
   Q(:,:,j) = invkin(q(:,j),d);
   Q=Q*180/pi;
   robot.setJointPositions(int16(Q(1,1,j)),int16(Q(1,2,j)),int16(Q(1,3,j)),int16(0),int16(0))
   pause(0.06)
end

pause(0.2)

% raise the pen end 
p=[216;0;10];
q = invkin(p,d);
q=180*q/pi;
robot.setJointPositions(int16(q(1)),int16(q(2)),int16(q(3)),int16(0),int16(0));
clear Q e;  

%% O left half round
pause(0.5)

% raise the pen end
p=[166;55;10];
q = invkin(p,d);
q=180*q/pi;
robot.setJointPositions(int16(q(1)),int16(q(2)),int16(q(3)),int16(0),int16(0));

ldot=.2; T=1/ldot;
%define the circle
r = 25;
xc = 191;
yc = 55;
%Build the trajectory
dt=.1;
t=(0:dt:T);
N=length(t);
q=zeros(3,N);
u=zeros(3,N-1);
L=zeros(1,N);

q(:,1)=[166;55;0];
maxunorm=100;
u_planned = zeros(2,N-1);
u_p = zeros(2,N-1);

for k=1:N-1
    qd=[r*cos((L(k)-1)*pi)+xc;r*sin((L(k)-1)*pi)+yc];
    u_planned(:,k)=-k*(q(1:2,k)-qd)*ldot;
    
    if norm(u_planned(:,k))>maxunorm
        u_p(:,k)=u_planned(:,k)/norm(u_planned(:,k))*maxunorm;
    else
        u_p(:,k)=u_planned(:,k);
    end
    
    normu(k)=norm(u_p(:,k));
    u(:,k)=[u_p(:,k);0];
    q(:,k+1)=q(:,k)+ dt * u(:,k);
    L(k+1)=L(k)+ldot*dt;
end

qd=[r*cos((L-1)*pi)+xc;r*sin((L-1)*pi)+yc];
q(:,N) = [qd(:,length(qd));0];

figure(1);plot(q(1,:),q(2,:));
legend('q')
hold on

Q = zeros(1,3,length(q));
for j=1:length(q)
   Q(:,:,j) = invkin(q(:,j),d);
    Q=Q*180/pi;
   robot.setJointPositions(int16(Q(1,1,j)),int16(Q(1,2,j)),int16(Q(1,3,j)),int16(0),int16(0))
   pause(0.08)
end

clear Q e;  

%% O right half round
% Raise the pen end
pause(0.5)
p=[216;55;20];
q = invkin(p,d);
q=180*q/pi;
robot.setJointPositions(int16(q(1)),int16(q(2)),int16(q(3)),int16(0),int16(0));

% Raise the pen end
pause(1)
p=[166;55;20];
q = invkin(p,d);
q=180*q/pi;
robot.setJointPositions(int16(q(1)),int16(q(2)),int16(q(3)),int16(0),int16(0));


ldot=.2; T=1/ldot; 
%define the circle
r = 25;
xc = 191;
yc =55;

dt=.1;
t=(0:dt:T);
N=length(t);
q=zeros(3,N);
u=zeros(3,N-1);
L=zeros(1,N);

q(:,1)=[166;55;0];
maxunorm=100;
u_planned = zeros(2,N-1);
u_p = zeros(2,N-1);

for k=1:N-1
    qd=[r*cos((L(k)-1)*pi)+xc;-r*sin((L(k)-1)*pi)+yc];
    u_planned(:,k)=-k*(q(1:2,k)-qd)*ldot;
    
    if norm(u_planned(:,k))>maxunorm
        u_p(:,k)=u_planned(:,k)/norm(u_planned(:,k))*maxunorm;
    else
        u_p(:,k)=u_planned(:,k);
    end
    
    normu(k)=norm(u_p(:,k));
    u(:,k)=[u_p(:,k);0];
    q(:,k+1)=q(:,k)+ dt * u(:,k);
    L(k+1)=L(k)+ldot*dt;
end

qd=[r*cos((L-1)*pi)+xc;-r*sin((L-1)*pi)+yc];
q(:,N) = [qd(:,length(qd));0];

figure(1);plot(q(1,:),q(2,:),'x');
legend('q')
hold on

Q = zeros(1,3,length(q));
for j=1:length(q)
   Q(:,:,j) = invkin(q(:,j),d);
   Q=Q*180/pi;
    robot.setJointPositions(int16(Q(1,1,j)),int16(Q(1,2,j)),int16(Q(1,3,j)),int16(0),int16(60))
    pause(0.06)
end

%Raise pen end
pause(0.5)
p=[216;55;10];
q = invkin(p,d);
q=180*q/pi;
robot.setJointPositions(int16(q(1)),int16(q(2)),int16(q(3)),int16(0),int16(0));

clear Q e;   

%% I straight
% Raise pen end
pause(0.5)
p=[216;90;10];
q = invkin(p,d);
q=180*q/pi;
robot.setJointPositions(int16(q(1)),int16(q(2)),int16(q(3)),int16(0),int16(0));


xs = 216; %x start
ys = 90; %y start
xe = 166; %x end
ye = 90; %y end

q = [xs xe;ys ye;0 0];

Q = zeros(1,3,length(q));
    
for j=1:2
   Q(:,:,j) = invkin(q(:,j),d);
   Q=180*Q/pi;
   robot.setJointPositions(int16(Q(1,1,j)),int16(Q(1,2,j)),int16(Q(1,3,j)),int16(0),int16(60))
end

% raise pen end
pause(0.5)
p=[166;90;10];
q = invkin(p,d);
q=180*q/pi;
robot.setJointPositions(int16(q(1)),int16(q(2)),int16(q(3)),int16(0),int16(0));

clear Q e; 

%% T horizontal
% raise pen end
pause(0.5)
p=[166;115;10];
q = invkin(p,d);
q=180*q/pi;
robot.setJointPositions(int16(q(1)),int16(q(2)),int16(q(3)),int16(0),int16(0));

xs = 166;
ys = 115;
xe = 166;
ye =155;

q = [xs xe;ys ye;0 0];
Q = zeros(1,3,length(q));
for j=1:2
   Q(:,:,j) = invkin(q(:,j),d);
   Q=180*Q/pi;
   robot.setJointPositions(int16(Q(1,1,j)),int16(Q(1,2,j)),int16(Q(1,3,j)),int16(0),int16(0))
   pause(0.1)
end

% raise pen end
pause(0.5)
p=[166;135;10];
q = invkin(p,d);
q=180*q/pi;
robot.setJointPositions(int16(q(1)),int16(q(2)),int16(q(3)),int16(0),int16(0));

clear Q e; 

%% T vertical
% raise pen end
pause(0.5)
p=[166;135;10];
q = invkin(p,d);
q=180*q/pi;
robot.setJointPositions(int16(q(1)),int16(q(2)),int16(q(3)),int16(0),int16(0));
pause(0.5)

xs = 166; %x start
ys = 135; %y start
xe = 216; %x end
ye = 135; %y end

q = [xs xe;ys ye;0 0];
Q = zeros(1,3,length(q));
for j=1:2
   Q(:,:,j) = invkin(q(:,j),d);
   Q=180*Q/pi;
   robot.setJointPositions(int16(Q(1,1,j)),int16(Q(1,2,j)),int16(Q(1,3,j)),int16(0),int16(0))
   pause(0.2)
end

% raise pen end
pause(0.5)
p=[216;115;10];
q = invkin(p,d);
q=180*q/pi;
robot.setJointPositions(int16(q(1)),int16(q(2)),int16(q(3)),int16(0),int16(0));
clear Q e; 


