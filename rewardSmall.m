function [ myReward ] = rewardSmall ( row,col,action)
nextRow = row;
nextCol = col;
standStillReward = 0 ;
goalReward = 1 ;
% maze = [1 1 0 -1;
% 0 1 1 1;
% 0 1 0 0;
% 1 1 1 1];
global mazesize
global mazeOverride
global override
if (mazeOverride ~= 1 )
maze = getDigiEgg(mazesize);
else
maze = getDigiEgg(override);
end
%maze = getDigiEgg(-1); %temp
%1 up, 2 right, 3 down, 4 left
if (action == 1 )
nextRow = nextRow - 1 ;
end
if (action == 2 )
nextCol = nextCol + 1 ;
end
if (action == 3 )
nextRow = nextRow + 1 ;
end
if (action == 4 )
nextCol = nextCol - 1 ;
end
if (nextRow > mazesize( 1 ) || nextRow < 1 || nextCol > mazesize( 1 ) || nextCol < 1 )
%Illegial move, stand still
myReward = standStillReward;
elseif (maze(nextRow, nextCol) == 0 )
myReward = standStillReward;
elseif (maze(nextRow, nextCol) == - 1 )
myReward = goalReward;
else
myReward = 0 ;
end
end