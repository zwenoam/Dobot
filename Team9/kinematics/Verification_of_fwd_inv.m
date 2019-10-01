%% Verify the forward and inverse kinematics
% run this code to test:
q1=rand;
q2=rand;
q3=rand;
[p,R]=fwdkin(q1,q2,q3,115);
[qv1,qv2]=invkin(p,115);
[[q1 q2 q3]' qv1 qv2]
% first column is prescribed q, second and third column are solutions.
% first and second column match

