%%
clc;
clear all;
close all;

%% Open audio files
Path = '/Users/maximekolly/Documents/Devialet/Licencing/Projects/Pony/Validation/210324_New_Files';

%% Compare -12dB Sweep New branch copy dual c346d929c860d503eb901460dbe3a816d646ebf6
%file1 = 'Ref_P33_Old_m12dB.wav';
%file2 = 'P22_Output_m12dB_c346d929c860d503eb901460dbe3a816d646ebf6.wav';
% OK

%% Compare -12dB Sweep New branch copy dual 8bfcb70943df66ab445e21f57e45fa6b87c530d3
%file1 = 'Ref_P33_Old_m12dB.wav';
%file2 = 'P23_m12dB_8bfcb70943df66ab445e21f57e45fa6b87c530d3.wav';
% OK

%% Compare -12dB Sweep New branch copy dual a8ed159fa2b4930aebd1ddf7543c4df96f9d69a6
%file1 = 'Ref_P33_Old_m12dB.wav';
%file2 = 'P23_m12dB_a8ed159fa2b4930aebd1ddf7543c4df96f9d69a6.wav';
% OK

%% Compare -12dB Sweep New branch copy dual e66be224113e32e2fcae1c66628222c4d9ce9e1f
%file1 = 'Ref_P33_Old_m12dB.wav';
%file2 = 'P23_m12dB_e66be224113e32e2fcae1c66628222c4d9ce9e1f.wav';
% OK

%% Compare -12dB Sweep New branch copy dual 74d80b1dad574199369364b254202b5be3601a17
%file1 = 'Ref_P33_Old_m12dB.wav';
%file2 = 'P23_m12dB_74d80b1dad574199369364b254202b5be3601a17.wav';
% OK

%% Compare -12dB Sweep New branch copy dual 
%file1 = 'Ref_P33-m12dB_f_2d7203783124480d4261a6958896c9c99cfb28f1.wav';
%file2 = 'P23_m12dB_74d80b1dad574199369364b254202b5be3601a17.wav';
% OK

%% Compare -12dB Sweep New branch copy dual 
file2 = 'Ref_P31_Sin15kHz_6dB_2021-03-25-105228.wav';
file1 = 'New_P21_Sin15kHz_6dB_2021-03-25-105022.wav';

filename_dualPod = strcat(Path,'/',file1);
filename_dualL = strcat(Path,'/',file2);

% Compare Ref
diff_ref = compareFiles(filename_dualPod,filename_dualL,1,1,1);


% Compare Sub
diff_sub = compareFiles(filename_dualPod,filename_dualL,9,9,1,1);


% Compare Left
diff_left = compareFiles(filename_dualPod,filename_dualL,2,2,1);


% Compare Right
diff_right = compareFiles(filename_dualPod,filename_dualL,3,3,1);

%% Compare Front
diff_front = compareFiles(filename_dualPod,filename_dualL,4,4,1);

