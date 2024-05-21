function [torque]  = Universal_wall_1(prevTorque, position, speed, start_Y, start_Z, width, height)

%outWall should be outer wall parameters, typically |0.15|. right and up is
%positive while left and down is negative

F= [0; 0; 0];
%Fzac = [0; 0; 0];
rect = [start_Y, start_Z, width, height];

%ref pozicija in ravnina
%ref_pos=[0.21; 0; -0.21];
% x is always ON
%Fzac = ([600; 0; 0].*(ref_pos-position)) - ([10; 3; 3].*(speed));

%F= k(ps-pp)-bv

% Calculate AABB info (center, half-extents)
rectHalfWidth = rect(3) / 2;
rectHalfLength = rect(4) / 2;
rectCenter = [rect(1) + rectHalfWidth, rect(2) - rectHalfLength];


yWall_R = rectCenter + rectHalfWidth; %0.15;
yWall_L = rectCenter - rectHalfWidth; %-0.15;
zWall_U = rectCenter + rectHalfLength; %0.15;
zWall_D = rectCenter - rectHalfLength; %-0.15;

k=1500;
bforward=10;
max_force=25;

%Y direction in wall
if (((position(2)>yWall_R) && (position(3)<zWall_U) ) && (position(3)>Wall_D))
    if(speed(2) > 0)
        F(2) = max([-max_force; -k * (position(2)-yWall_R) + bforward * speed(2)]);
    else
        F(2) = max([-max_force; -k * (position(2)-yWall_R)]);
    end
elseif (position(2)<yWall_L)
    if(speed(2) < 0)
        F(2) = min([max_force; -k * (position(2)-yWall_L) + bforward * speed(2)]);
    else
        F(2) = min([max_force; -k * (position(2)-yWall_L)]);
    end
else
    F(2)=0 ;
end


%Y-Walls
%if (position(2)>yWall_R)
%    if(speed(2) > 0)
%        F(2) = max([-max_force; -k * (position(2)-yWall_R) + bforward * speed(2)]);
%    else
%         F(2) = max([-max_force; -k * (position(2)-yWall_R)]);
%     end
% elseif (position(2)<yWall_L)
%     if(speed(2) < 0)
%         F(2) = min([max_force; -k * (position(2)-yWall_L) + bforward * speed(2)]);
%     else
%         F(2) = min([max_force; -k * (position(2)-yWall_L)]);
%     end
% else
%     F(2)=0 ;
% end


%Z-walls
% if (position(3)<zWall_D)
%     if(speed(3) < 0)
%         F(3) = min([max_force; -k * (position(3)-zWall_D) + bforward * speed(3)]);
%     else
%         F(3) = min([max_force; -k * (position(3)-zWall_D)]);
%     end
% elseif (position(3)>zWall_U)
%     if(speed(3) > 0)
%         F(3) = max([-max_force; -k * (position(3)-zWall_U) + bforward * speed(3)]);
%     else
%         F(3) = max([-max_force; -k * (position(3)-zWall_U)]);
%     end
% else
%     F(3)=0;
% end

torque=F+prevTorque;