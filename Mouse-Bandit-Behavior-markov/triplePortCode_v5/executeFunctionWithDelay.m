
function fTimer = executeFunctionWithDelay(func, delay)
% executeFunctionWithDelay: executes a function after a specified delay (in
% sec)
%
   fTimer = timer('ExecutionMode', 'singleShot', 'StartDelay', delay);
   fTimer.StopFcn = @(o,e)delete(o);
   fTimer.TimerFcn = {@(o,e)func()};
   start(fTimer);
end

