function [collision,difference,closest] = CheckCollision(circle, rect)

%center x, y, radij
circle = [0,0,0.1];
%top left corner(x,y) width length - where x and y are the top left corner of
%the rect
%rect_Top_L = [-0.15, 0.15, 0.05, 0.05];
rect = [-0.15, 0.15, 0.05, 0.05]; %[2,2,1,1];
%rect1 = [-2,3,1,1];
%rect2 = [-1,-0.5,0.5,1.5];
%rect3 = [2,-0.5,1,1];
%rect4 = [0.5,0.5,1,1];
%rect5 = [0.5,-0.5,1,1];
%rect6 = [0.5,-0.5,1,1];
%rect7 = [-0.5,-2,1,1];

% Calculate center point of the circle
circleCenter = [circle(1), circle(2)];

% Calculate AABB info (center, half-extents)
rectHalfWidth = rect(3) / 2;
rectHalfLength = rect(4) / 2;
rectCenter = [rect(1) + rectHalfWidth, rect(2) - rectHalfLength];

% Get difference vector between circle center and rectangle center
difference = circleCenter - rectCenter; %od rect do circ

% Clamp the difference vector to AABB half-extents
clampedX = max(-rectHalfWidth, min(difference(1), rectHalfWidth));
clampedY = max(-rectHalfLength, min(difference(2), rectHalfLength));

% Add clamped value to rectangle center to get the point on the rectangle closest to the circle
closest = rectCenter + [clampedX, clampedY];

% Check if the closest point is inside the rectangle
%closest(1) = min(max(closest(1), rect(1)), rect(1) + rect(3)); % Clamp x-coordinate
%closest(2) = min(max(closest(2), rect(2)), rect(2)- rect(4) ); % Clamp y-coordinate

% Retrieve vector between circle center and closest point on rectangle
difference = closest - circleCenter;

% Check if length of difference vector is less than circle radius
collision = norm(difference) < circle(3);
%[collision,difference,closest];
end

%%
%INSTRUCTIONS FOR FUTURE WORK

%1)  save outer wall points
% A-----------------------B
% |                       |
% |                       |
% |                       |
% |                       |
% |                       |
% |                       |
% |                       |
% |                       |
% |                       |
% C-----------------------D

%2) Create a starting square so players dont imediatly get pushed into a
%wall

%3) save all walls into multidimensional array - walls should not be in the
%starting square
%A = [1 2 3; 4 5 6; 7 8 9]
%walls = [x y width length;
%          x y width length;.......]

%4) SEND wall data to unity and display the walls in unity

%5) RUN CheckCollision func in a loop for all walls
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% [m, n] = size(A);
% for i = 1:m
%     circle = [pos.x, pos.y, R] %feed circle data
%     %top left corner(x,y) width length
%     rect = [A(i,1),A(i,2),A(i,3),A(i,4)]
%     [col,diff,closest] = CheckCollision(circle, rect)
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% if col then
   % apply force:       F_fromWalls = 30*unit(difference)        
   % note you only have y and x -> this force is 2D
   
   %F_new = [0;0;0]
   %F_new(1) = F_old(1) + F_fromWalls(1)
   %F_new(2) = F_old(2) + F_fromWalls(2)
   %F_new(3) = F_old(3) 
   
   
   