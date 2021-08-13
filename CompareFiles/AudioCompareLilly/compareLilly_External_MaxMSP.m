%%
clc;
clear all;
close all;

%% Open audio files
path_external = '/Users/maximekolly/Documents/Devialet/Licencing/Projects/Lilly/Validation/20210618_HW_External/HWExternal';
path_maxmsp = '/Users/maximekolly/Documents/Devialet/Licencing/Projects/Lilly/Validation/20210618_HW_External/FullMaxMSP';

%%

%% Compare -12dB Sweep New branch copy dual 
%file_external = 'P12_V0_A0_2021-06-07-090310.wav';
%file_maxmsp = 'P12_V0_A0_2021-06-07-090023.wav';

file_external = 'P12_V0_A0_2021-06-18-155805.wav';
file_maxmsp = 'P12_V0_A0_2021-06-18-155556.wav';

filename_1 = strcat(path_external,'/',file_external);
filename_2 = strcat(path_maxmsp,'/',file_maxmsp);

% Compare Ref
diff_1 = compareFiles(filename_1,filename_2,1,1,1);

diff_2 = compareFiles(filename_1,filename_2,2,2,1);

diff_3 = compareFiles(filename_1,filename_2,3,3,1);

diff_4 = compareFiles(filename_1,filename_2,4,4,1);

diff_5 = compareFiles(filename_1,filename_2,5,5,1);

diff_6 = compareFiles(filename_1,filename_2,6,6,1);

diff_7 = compareFiles(filename_1,filename_2,7,7,1);

diff_10 = compareFiles(filename_1,filename_2,10,10,1);
