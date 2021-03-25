function updateplotlyfig(psL,psR,cumstats,pokeCount)
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here

leftTrialData.x = pokeCount;
leftTrialData.y = cumstats.trials.left;
rightTrialData.x = pokeCount;
rightTrialData.y = cumstats.trials.right;

psL.write(leftTrialData);
psR.write(rightTrialData);

end

