function [ p, R ] = fwdkin(q1,q2,q3,d)
%Output:
%       R: rotation ;
%       p: distance from the end of pen to the origin;
%Inputs:
%       q1,q2,q3: the rotation angle of the first three axis
%       d: length of the pen;
%Build the 
ex = [1; 0; 0];ey = [0; 1; 0];ez = [0; 0; 1];
% Dobot Parameters
l1 = 103;l2 = 135;l3 = 160;Lg = 56;
%Compute forward kinematics
h1=ez;h2=ey;h3=ey;
p12=l1*ez;p23=l2*ez;p34=l3*ex;
R = rotk(h1, q1)*rotk(h2, q2)*rotk(h3, q3);
p = p12 + rotk(h1,q1)*rotk(h2,q2)*p23 + rotk(h1,q1)*rotk(h3,q3)*p34+[Lg*cos(q1);Lg*sin(q1);-d];
end