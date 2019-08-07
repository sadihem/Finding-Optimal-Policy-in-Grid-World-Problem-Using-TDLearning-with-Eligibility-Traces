%Initialize matrixes
clc
clear all
close all
global mazesize
%2 1 2 1 best, avg 9.2
% mazesize = 20;
% maze = getDigiEgg(mazesize);
mazesize = 20 ;
global mazeOverride
mazeOverride = 1 ;
global override
override = - 2 ;
%maze = getDigiEgg(mazesize);
maze = getDigiEgg( - 2 );
exploration = .9 ;
optSeed = [optA,optG,optL];
oldmaxavgResultVars = zeros ( 1 , 3 );
maxavgResultVars = ones ( 1 , 3 );
startRow = mazesize;
startCol = 1 ;
runs = 1000 ;
global run ;
%Set goalRow and goalCol
for mazerow = 1 : mazesize( 1 )
for mazecol = 1 : mazesize( 1 )
if (maze(mazerow,mazecol) == - 1 )
goalRow = mazerow;
goalCol = mazecol;
end
end
end
%might need this up here maxavgResultVars = ones(1,3);
Q = zeros (mazesize( 1 ),mazesize( 1 ), 4 );
E = zeros (mazesize( 1 ),mazesize( 1 ), 4 );
row = startRow;
col = startCol;
nextRow= startRow;
nextCol= startCol;
maxLimit = 10000 ;
%New starting position
rowStarts = zeros ( 1 ,runs);
colStarts = zeros ( 1 ,runs);
for (ij = 1 : runs)
newRow = randi(mazesize( 1 ), 1 );
newCol = randi(mazesize( 1 ), 1 );
while (maze(newRow,newCol) == 0 || maze(newRow,newCol) == - 1 )
newRow = randi(mazesize( 1 ), 1 );
newCol = randi(mazesize( 1 ), 1 );
end
rowStarts(ij) = newRow;
colStarts(ij) = newCol;
end
moves = zeros ( 1 ,runs);
limit = 0
%Run Temporal code
for run = 1 : runs
limit = limit + 1
limit = 0 ;
E = zeros (mazesize( 1 ),mazesize( 1 ), 4 ); %reset E
moves( run ) = 0 ;
while ((~(row == goalRow && col == goalCol)) && (limit < maxLimit))
limit = limit + 1 ;
moves( run ) = moves( run ) + 1 ;
%Finds optimal action, picks random if tie
temp = Q(row,col, : );
temp2 = find (temp == ( max ( max (temp))));
optimalA = temp2(randi([ 1 length (temp2)], 1 ));
%if(rand(1) > exploration)
% optimalA = (randi([1 4],1))
%end
nextReward = rewardSmall(row,col,optimalA);
[nextRow, nextCol] = nextStateSmall( row,col,optimalA);
temp = Q(nextRow,nextCol, : );
temp2 = find (temp == ( max ( max (temp))));
optimalAprime = temp2(randi([ 1 length (temp2)], 1 ));
delta = nextReward + gamma * Q(nextRow,nextCol,optimalAprime) - Q(row,col,optimalA);
%E(row,col,optimalA) = E(row,col,optimalA) + 1;
%E(row,col,optimalA) = (1-alpha)*E(row,col,optimalA) + 1
E(row,col,optimalA) = 1 ;
avgE = E( : , : , 1 ) + E( : , : , 2 ) + E( : , : , 3 ) + E( : , : , 4 )
if (limit > maxLimit * .9 )
pause = 1 ;
disp (row)
disp (col)
disp (optimalA)
disp (Q(row,col,optimalA))
disp (optimalAprime)
disp (Q(nextRow,nextCol,optimalAprime))
end
for staterow = 1 : mazesize( 1 )
for statecol = 1 : mazesize( 1 )
for action = 1 : 4
Q(staterow,statecol,action) = Q(staterow,statecol,action) +
alpha * delta * E(staterow,statecol,action);
E(staterow,statecol,action) = gamma * lambda * E(staterow,statecol,action);
end
end
end
row = nextRow;
col = nextCol;
end
if (limit == maxLimit)
for iii = run: runs
moves(iii) = maxLimit * 100 ;
end
end
row = rowStarts( run );
col = colStarts( run );
end