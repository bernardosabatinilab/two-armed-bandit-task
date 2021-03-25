function updatestatsfig(stats,h,pokeCount)
%updatestatsfig(stats,h)
XPLOT = 1:pokeCount;

for i = 1:size(h,2)
    refreshdata(h(i),'caller')
end

