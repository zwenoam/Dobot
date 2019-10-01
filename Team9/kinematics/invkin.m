function [Q1,Q2] = invkin(p,d)
%ikdobot computes inverse kinematics for dobot 
% takes desired coordinate x,y,z and returns q1,q2,q3
% Inputs: p: the desired coordinate[x;y;z]of the pen end(the distance from the origin) 
% Outputs: q: the rotation angles of the first three axis
%% Build the coordinate frame
ex=[1;0;0];ey=[0;1;0];ez=[0;0;1];
%% Dobot parameters(mm)
l1 = 103;l2 = 135;l3 = 160;Lg = 56;  %length from point T to q4 rotation
h1=ez;h2=ey;h3=ey;
p12=l1*ez;p23=l2*ez;p34=l3*ex;
%% Calculate inverse kinematics
q1i=atan(p(2)/p(1));
%Caculate the coordinate of O4
p=p-p12-[Lg*cos(q1i);Lg*sin(q1i);-d]; 
%solve for q3
q3s=subprob3(ey,-p34,p23,norm(p));
q21=subprob1(h2,p23+rotk(h3,q3s(1))*p34,rotk(-h1,q1i)*(p));
q22=subprob1(h2,p23+rotk(h3,q3s(2))*p34,rotk(-h1,q1i)*(p));
%solve for q2
Q2=[q1i,q21,q3s(1)+q21]';
%solve for q1
Q1=[q1i,q22,q3s(2)+q22]';
end