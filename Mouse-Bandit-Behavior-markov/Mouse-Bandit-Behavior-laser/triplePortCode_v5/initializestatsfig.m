function h = initializestatsfig(stats)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
XPLOT = 1;
figure('Name','Stats Figure','NumberTitle','off')
subplot(3,1,1)
h(1) = plot(XPLOT,stats.trials.left);
h(1).XDataSource = 'XPLOT';
h(1).YDataSource = 'stats.trials.left';
hold on
h(2) = plot(XPLOT,stats.trials.right,'k');
h(2).XDataSource = 'XPLOT';
h(2).YDataSource = 'stats.trials.right';
title('Trials');

subplot(3,1,2)
h(3) = plot(XPLOT,stats.rewards.left);
h(3).XDataSource = 'XPLOT';
h(3).YDataSource = 'stats.rewards.left';
hold on
h(4) = plot(XPLOT,stats.rewards.right,'k');
h(4).XDataSource = 'XPLOT';
h(4).YDataSource = 'stats.rewards.right';
title('Rewards');

subplot(3,1,3)
h(5) = plot(XPLOT,stats.errors.left);
h(5).XDataSource = 'XPLOT';
h(5).YDataSource = 'stats.errors.left';
hold on
h(6) = plot(XPLOT,stats.errors.right,'k');
h(6).XDataSource = 'XPLOT';
h(6).YDataSource = 'stats.errors.right';
hold on
h(7) = plot(XPLOT,stats.errors.center,'r');
h(7).XDataSource = 'XPLOT';
h(7).YDataSource = 'stats.errors.center';
title('Errors');
legend('Left Port','Right Port','Center Port')
end

