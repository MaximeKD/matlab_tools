%% 
clc
clear all

%% Open audio files
Path = '/Users/maximekolly/Documents/Devialet/Licencing/Projects/Cezanne/210323_AudioFileValidation';

%filename1 = 'out_stereo_dive.wav'; 
filename1 = 'P2_V0_Cezanne_NRT_1.wav';
filename2 = 'out_stereo_dive_2ms_LR_delay.wav';

filenamePath1 = strcat(Path,'/',filename1);
filenamePath2 = strcat(Path,'/',filename2);

%% Compare Left
diff_left = compareFiles(filenamePath1,filenamePath2,2,1,1,1);


%% Compare Right
diff_right = compareFiles(filenamePath1,filenamePath2,3,2,1,1);

