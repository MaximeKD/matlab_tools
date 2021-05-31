%%
clc;
clear all;
close all;

%% Open audio files
Path = '/Users/maximekolly/Documents/Devialet/Licencing/Projects/Poulenc/Validation/20210514_ExternalPipeline/HWExternal';

%% Compare -12dB Sweep New branch copy dual
file1 = 'P11_V0_HWExternal.wav';
file2 = 'P11_V0_HWExternal_Left.wav';

%% 
filename_dualPod = strcat(Path,'/',file1);
filename_dualL = strcat(Path,'/',file2);

%% Compare
canal1 = 2;
canal2 = 9;
diff = compareFiles(filename_dualPod,filename_dualL,canal1,canal2,1);

