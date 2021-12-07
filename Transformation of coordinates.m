%% Transformation between different coordinates
%used for space dynamics and control course 2020
while true
    %printing all the options of transformations that are available to the
    %user
    fprintf("hi, these are the transformations available from this program")
    fprintf("\n1: Direction cosine matrix to euler angle");
    fprintf("\n2: Direction cosine matrix to Quaternions");
    fprintf("\n3: Direction cosine matrix to principle angle and principle axis");
    fprintf("\n4: Euler angle to Direction cosine matrix");
    fprintf("\n5: Euler angle to quaternions");
    fprintf("\n6: Euler angle to principle axis and principle axis");
    fprintf("\n7: quaternions to direction cosine matrix");
    fprintf("\n8: quaternions to euler angles");
    fprintf("\n9: quaternions to principle angles and principle axis");
    fprintf("\n10: principle angles to Direction cosine matrix");
    fprintf("\n11: principle angles to quaternions");
    fprintf("\n12: principle angles to euler angles");
    fprintf("\n13: quit");
    %asking for the user input 
    option = input("\nplease enter the transformation you wish to make: ");

    switch option
        case 1 %transforming from direction cosine matrix to Euler angles 
            
            while true %this is done in case the user inputs a cosine matrix that is not 3x3,
                %the program will ask the user to enter the direction
                %cosine matrix again
                C =input("\nplease enter the Direction cosine matrix");
                if size(C)==[3,3] %check if the inout is 3x3
                    [rx,ry,rz]= GetEulerAngles(C)
                %if it is 3x3, we need to go out of the loop
                    break
                else
                    %return that there was a mistake and loop again
                    fprintf("\nthere was a mistake in your dirction cosine matrix");
                end 
            end
        case 2
            %transfromation of direction cosine matrix to quaternions
            while true
                C = input("please enter the direction Cosine Matrix: ");
                if size(C)==[3,3]
                    q= QtoDCM(C)

                    break
                else
                    fprintf("\nthere was a mistake in your dirction cosine matrix");
                end 
            end
        case 3
            %transformation of direction cosine matrix to PRinciple angle
            %and axis
            while true
                C = input("please enter the direction Cosine Matrix: ");
                if size(C)==[3,3]
                    [a,b]= DCMtoPRV(C)
                    break
                else
                    fprintf("\nThere was a mistake in your dirction cosine matrix");
                end 
            end
        case 4
            % transformation of euler angle to direction cosine matrix
            roll = input("\nplease enter roll in rad: ");
            pitch = input("\nplease ente pitch in rad: ");
            yaw = input("\nplease entere yaw in rad: ");
            % the transformation of euler angle to direction cosine matrix
            % depends on the order in which it happens, so We ask the user
            % to enter the order as well
            fprintf("\nthe transformations maybe done by the following orders:")
            fprintf("\n1: xyz");
            fprintf("\n2: xzy");
            fprintf("\n3: yxz\n4: yzx\n5: zxy\n6: zyx");
            order = input("please enter your option: ");
            % depending on the order of the transformations, we have
            % different functions
            switch order
                case 1
                    DCM = dcmfromeuler(roll,pitch,yaw,"xyz")
                case 2
                    DCM = dcmfromeuler(roll,pitch,yaw,"xzy")
                case 3
                    DCM = dcmfromeuler(roll,pitch,yaw,"yxz")
                case 4
                    DCM = dcmfromeuler(roll,pitch,yaw,"yzx")
                case 5
                    DCM = dcmfromeuler(roll,pitch,yaw,"zxy")
                case 6
                    DCM = dcmfromeuler(roll,pitch,yaw,"zyx")
            end
        case 5%%transformation of euler to quaternion
            roll = input("\nplease enter roll in rad: ");
            pitch = input("\nplease ente pitch in rad: ");
            yaw = input("\nplease entere yaw in rad: ");
            fprintf("\nthe transformations maybe done by the following orders:")
            fprintf("\n1: xyz");
            fprintf("\n2: xzy");
            fprintf("\n3: yxz\n4: yzx\n5: zxy\n6: zyx");
            order = input("please enter your option: ");
            switch order
                case 1
                    DCM = dcmfromeuler(roll,pitch,yaw,"xyz")
                case 2
                    DCM = dcmfromeuler(roll,pitch,yaw,"xzy")
                case 3
                    DCM = dcmfromeuler(roll,pitch,yaw,"yxz")
                case 4
                    DCM = dcmfromeuler(roll,pitch,yaw,"yzx")
                case 5
                    DCM = dcmfromeuler(roll,pitch,yaw,"zxy")
                case 6
                    DCM = dcmfromeuler(roll,pitch,yaw,"zyx")
            end
            Q = DCMtoQ(DCM)
    
        case 6 %%transformation euler to principle angle
            
            roll = input("\nplease enter roll in rad: ");
            pitch = input("\nplease ente pitch in rad: ");
            yaw = input("\nplease entere yaw in rad: ");
            fprintf("\nthe transformations maybe done by the following orders:")
            fprintf("\n1: xyz");
            fprintf("\n2: xzy");
            fprintf("\n3: yxz\n4: yzx\n5: zxy\n6: zyx");
            order = input("please enter your option: ");
            switch order
                case 1
                    DCM = dcmfromeuler(roll,pitch,yaw,"xyz")
                case 2
                    DCM = dcmfromeuler(roll,pitch,yaw,"xzy")
                case 3
                    DCM = dcmfromeuler(roll,pitch,yaw,"yxz")
                case 4
                    DCM = dcmfromeuler(roll,pitch,yaw,"yzx")
                case 5
                    DCM = dcmfromeuler(roll,pitch,yaw,"zxy")
                case 6
                    DCM = dcmfromeuler(roll,pitch,yaw,"zyx")
            end
            [e,phi] = DCMtoPRV(DCM)
        case 7 %%transformation quaternion to dcm
            while true
                Q = input("please enter the quaternion vector: ");
                if length(Q) ==4
                    DCM = QtoDCM(Q)
                    break
                else
                    fprintf("\nthere is something wrong with the quaternion vector");
                end
            end

        case 8 %%transformation of quaternion to euler
            while true
                Q = input("please enter the quaternion vector: ");
                if length(Q) ==4
                    DCM = QtoDCM(Q);
                    [rx,ry,rz] =GetEulerAngles(DCM)
                    break
                else
                    fprintf("\nthere is something wrong with the quaternion vector");
                end
            end
        case 9 %%transformation of quaternion to principle axis
             while true
                Q = input("please enter the quaternion vector: ");
                if length(Q) ==4
                    DCM = QtoDCM(Q);
                    [e,phi] = DCMtoPRV(DCM)
                    break
                else
                    fprintf("\nthere is something wrong with the quaternion vector");
                end
            end
        case 10 %%transformation of principle axis to DCM
            phi =input("\nplease enter the principle angle: ");
            while true
                e = input("\nenter the principle axis vector: ");
                if length(e) == 3
                    C = PRVtoDCM(e,phi)
                    break
                else
                    fprintf("\nthere was something wrong with the principle axis vector");
                end
            end


        case 11 %%transformation of principle angle to quaternion
            phi =input("\n please enter the principle axis: ");
            while true
                e = input("\nenter the principle axis vector: ");
                if length(e) == 3
                    C = PRVtoDCM(e,phi);
                    Q = DCMtoQ(C)
                    break
                else
                    fprintf("\nthere was something wrong with the principle axis vector");
                end
            end
        case 12 %%transformation of principle axis to euler angle
            phi =input("\n please enter the principle axis: ");
            while true
                e = input("\nenter the principle axis vector: ");
                if length(e) == 3
                    C = PRVtoDCM(e,phi);
                    [rx,ry,rz] = GetEulerAngles(C)
                    break
                else
                    fprintf("\nthere was something wrong with the principle axis vector");
                end
            end

        case 13
            break

    end
end
        
%% we have the function definitions of all the transformations


%% converts from direction cosine matrix to principle angles and principle axis
function [e,phi] = DCMtoPRV(C)   %% a is the principle axis and b is the principle angle
phi = acos(0.5*(trace(C)-1));
[c,D] = eig(C);
phi = phi/((2*pi)/360);
eL = [C(2,3)-C(3,2);C(3,1)-C(1,3);C(1,2)-C(2,1)];

e = 0.5*eL/sind(phi);
end

%% converts from principle angle and principle axis to drection cosine matrix
function C = PRVtoDCM(e,phi)
E = [0,-e(3),e(2);e(3),0,-e(1);-e(2),e(1),0];
C = cosd(phi)*eye(3)+(1-cosd(phi))*e*(e')-sind(phi)*E;
end

%% converts quaternions ro direction cosine matrix
function C=QtoDCM(Q)
q1=Q(1); q2=Q(2); q3=Q(3); q4=Q(4);
C = [q1^2-q2^2-q3^2+q4^2, 2*(q1*q2+q3*q4), 2*(q1*q3-q2*q4);
     2*(q1*q2-q3*q4), -q1^2+q2^2-q3^2+q4^2, 2*(q2*q3+q1*q4);
     2*(q1*q3+q2*q4), 2*(q2*q3-q1*q4), -q1^2-q2^2+q3^2+q4^2 ];
end

%% converts direction cosine matrix to quaternions
function Q=DCMtoQ(C)
K3=[C(1,1)-C(2,2)-C(3,3), C(2,1)+C(1,2), C(3,1)+C(1,3), C(2,3)-C(3,2);
    C(2,1)+C(1,2), C(2,2)-C(1,1)-C(3,3), C(3,2)+C(2,3), C(3,1)-C(1,3);
    C(3,1)+C(1,3), C(3,2)+C(2,3), C(3,3)-C(1,1)-C(2,2), C(1,2)-C(2,1);
    C(2,3)-C(3,2), C(3,1)-C(1,3), C(1,2)-C(2,1), C(1,1)+C(2,2)+C(3,3)]/3;
[eigvec, eigval] = eig(K3);
[x,i] = max(diag(eigval));
Q = eigvec(:,i);
end


%% converts direction cosine matrix to euler angle
function [rx,ry,rz]= GetEulerAngles(R)

% This function return the rotation along x,y and z direction from a 
% Rotation Matrix

%Inputs:
    % R= 3x3 Rotation Matrix
%Outputs:
    % rx= Rotation along x direction in radians
    % ry= Rotation along y direction in radians
    % rz= Rotation along z direction in radians
    
%     R =
%  
% [                           cos(ry)*cos(rz),                          -cos(ry)*sin(rz),          sin(ry)]
% [ cos(rx)*sin(rz) + cos(rz)*sin(rx)*sin(ry), cos(rx)*cos(rz) - sin(rx)*sin(ry)*sin(rz), -cos(ry)*sin(rx)]
% [ sin(rx)*sin(rz) - cos(rx)*cos(rz)*sin(ry), cos(rz)*sin(rx) + cos(rx)*sin(ry)*sin(rz),  cos(rx)*cos(ry)]


ry=asin(R(1,3));
rz=acos(R(1,1)/cos(ry));
rx=acos(R(3,3)/cos(ry));
end


%% converts euler angel to direction cosine matrix
function DCM=dcmfromeuler(roll,pitch,yaw,order)

rM=[1    0           0;
    0    cos(roll)   sin(roll);
    0    -sin(roll)  cos(roll)];

pM=[cos(pitch)      0       -sin(pitch);
    0               1       0;
    sin(pitch)      0       cos(pitch)];

yM=[cos(yaw)        sin(yaw)        0;
    -sin(yaw)       cos(yaw)        0;
    0               0               1];

% % -------------------------------------------------------------------------
% % for Rotations if order of rotations is 'rpy' (i.e. roll-->pith-->yaw)
% % then in matrix multiplication we would multiply them in reverse order
% % i.e. first muliply yM with pM let 
% % T=yM*pM then multiply T with rM i.e
% % Ans=T*rM
% % or Ans=(yM*yM)*rM
% % where rM,yM and yM are rotation matrices
% % -------------------------------------------------------------------------
if(strcmpi(order,'xyz')==1 || strcmpi(order,'rpy')==1)
    DCM=(yM*pM)*rM;  
elseif(strcmpi(order,'xzy')==1 || strcmpi(order,'ryp')==1)
    DCM=(pM*yM)*rM;
elseif(strcmpi(order,'yxz')==1 || strcmpi(order,'pry')==1)
    DCM=(yM*rM)*pM;
elseif(strcmpi(order,'yzx')==1 || strcmpi(order,'pyr')==1)
    DCM=(rM*yM)*pM;
elseif(strcmpi(order,'zxy')==1 || strcmpi(order,'yrp')==1)
    DCM=(pM*rM)*yM;
elseif(strcmpi(order,'zyx')==1 || strcmpi(order,'ypr')==1)
    DCM=(rM*pM)*yM;
else
    error('could not recognized the sequence of rotation')
end
end
