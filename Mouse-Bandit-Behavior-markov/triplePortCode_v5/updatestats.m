function [ stats ] = updatestats(stats,poke,pokeCount,syncFrame)
% [ stats ] = updatestats( pokeHistory )
% parses through one instance pokeHistory to update the pokeCount entry of
% stats
% 3/21/16 by shay neufeld
% 10/18/16 - modified by shay to incorporate syncing with inscopix.

%syncFrame
stats.sync_frame(pokeCount) = syncFrame;

%stats.time
stats.times(pokeCount) = now;

%stats.trials
if poke.isTRIAL == 2
    %if is.TRIAL == 2 then no error has been made only if pressed in center:
    stats.errors.right(pokeCount) = 0;
    stats.errors.left(pokeCount) = 0;
    stats.errors.center(pokeCount) = 0;
    %now correctly ascribe the trial:
    if strcmpi(poke.portPoked,'leftPort')
        stats.trials.left(pokeCount) = 2;
        stats.trials.right(pokeCount) = 0;
    elseif strcmpi(poke.portPoked,'rightPort')
        stats.trials.right(pokeCount) = 2;
        stats.trials.left(pokeCount) = 0;
    elseif strcmpi(poke.portPoked,'centerPort')
        stats.trials.left(pokeCount) = 0;
        stats.trials.right(pokeCount) = 0;
        stats.errors.center = 1;
    end
    %and finally determine if there was a reward:
    if poke.REWARD == 1
        if strcmpi(poke.portPoked,'leftPort')
            stats.rewards.left(pokeCount) = 1;
            stats.rewards.right(pokeCount) = 0;
        elseif strcmpi(poke.portPoked,'rightPort')
            stats.rewards.right(pokeCount) = 1;
            stats.rewards.left(pokeCount) = 0;
        end
    else
        stats.rewards.left(pokeCount) = 0;
        stats.rewards.right(pokeCount) = 0;
    end

%stats.errors
elseif poke.isTRIAL == 0
    stats.trials.right(pokeCount) = 0;
    stats.trials.left(pokeCount) = 0;
    stats.rewards.right(pokeCount) = 0;
    stats.rewards.left(pokeCount) = 0;    
    if strcmpi(poke.portPoked,'leftPort')
        stats.errors.left(pokeCount) = 1;
        stats.errors.right(pokeCount) = 0;
        stats.errors.center(pokeCount) = 0;
    elseif strcmpi(poke.portPoked,'rightPort')
        stats.errors.right(pokeCount) = 1;
        stats.errors.left(pokeCount) = 0;
        stats.errors.center(pokeCount) = 0;
    elseif strcmpi(poke.portPoked,'centerPort')
        stats.errors.center(pokeCount) = 1;
        stats.errors.left(pokeCount) = 0;
        stats.errors.right(pokeCount) = 0;
    end
    
elseif poke.isTRIAL == 1
    %these are the trial initiations
        stats.trials.left(pokeCount) = 0;
        stats.trials.right(pokeCount) = 0;
% there are not errors:
        stats.errors.center(pokeCount) = 0;
        stats.errors.left(pokeCount) = 0;
        stats.errors.right(pokeCount) = 0;
%and there are no rewards for trial iniation:
        stats.rewards.left(pokeCount) = 0;
        stats.rewards.right(pokeCount) = 0;
end


