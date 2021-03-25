
%% play a pure tone
function playTone(frequency, duration, intensity)
    
Fs = 48000;  % set sampling rate to 48000 Hz (perhaps some sound cards can handle 96000) 

wave = intensity*sin((0:1/Fs:duration)*2*pi*frequency);

sound(wave,Fs)