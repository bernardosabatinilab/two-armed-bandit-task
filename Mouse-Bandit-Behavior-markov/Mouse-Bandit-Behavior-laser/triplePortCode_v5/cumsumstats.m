function [ cumstats ] = cumsumstats( stats )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

cumstats.trials.left = cumsum(stats.trials.left)./2;
cumstats.trials.right = cumsum(stats.trials.right)./2;
cumstats.rewards.left = cumsum(stats.rewards.left);
cumstats.rewards.right = cumsum(stats.rewards.right);
cumstats.errors.left = cumsum(stats.errors.left);
cumstats.errors.right = cumsum(stats.errors.right);
cumstats.errors.center = cumsum(stats.errors.center);

end

