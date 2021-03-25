function [ stats ] = initializestats
%[ stats ] = initializestats
%initialize the stats structure to have one entry where everything is zero
%(and the time is now) so we can start plotting and have something to
%update when the mouse starts poking. 
%Note that when the mouse makes its first poke, pokeCount will be 1 and
%everything initalized here will be written over. That's what we want. 

stats.times(1) = now;
stats.trials.left(1) = 0;
stats.trials.right(1) = 0;
stats.rewards.left(1) = 0;
stats.rewards.right(1) = 0;
stats.errors.left(1) = 0;
stats.errors.right(1) = 0;
stats.errors.center(1) = 0;

end

