%% Connect the stim box

[rt,t]=ctrlArduinoStim_hrc('init');
%% run stim

amp=1;%mA
pw=200;%us
freq=30;%Hz
[rt,t]=ctrlArduinoStim_hrc('stim',[amp,pw,freq,1])

%%
ctrlArduinoStim_hrc('stim');
%% close connection
ctrlArduinoStim_hrc('close');