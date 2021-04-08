%%
clc;
clear all;
close all;

%% Open audio files
path = 'audio';

%% Compare -12dB Sweep New branch copy dual 
file2 = 'max_out_ref.wav';
file1 = 'out_c.f32.HP_ref.wav';

filename_dualPod = strcat(path,'/',file1);
filename_dualL = strcat(path,'/',file2);

% Compare
%diff_ref = compareFiles(filename_dualPod,filename_dualL,1,1,1,1);

% Compare
%diff_sub = compareFiles(filename_dualPod,filename_dualL,2,2,1,1);

% Compare
diff_left = compareFiles(filename_dualPod,filename_dualL,3,3,1,1);

% Compare
% diff_right = compareFiles(filename_dualPod,filename_dualL,4,4,1);
