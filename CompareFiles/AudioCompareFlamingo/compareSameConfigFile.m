%%
clc;
clear all;
close all;

%% Open audio files
Path = '/Users/maximekolly/Documents/Devialet/Licencing/Projects/Flamingo/Validation/20210413_New_Tuning/PreviousVersion';

%%

%% Compare -12dB Sweep New branch copy dual 
file2 = 'P2_V0_Space_Old_REF.wav';
file1 = 'P12_V0_New_Space.wav';

filename_dualPod = strcat(Path,'/',file1);
filename_dualL = strcat(Path,'/',file2);

% Compare Ref
diff_ref = compareFiles(filename_dualPod,filename_dualL,1,1,1);

% Compare Sub
diff_sub = compareFiles(filename_dualPod,filename_dualL,2,2,1,1);

% Compare Left
diff_sub = compareFiles(filename_dualPod,filename_dualL,3,3,1,1);

% Compare Left
%diff_left = compareFiles(filename_dualPod,filename_dualL,2,2,1);


% Compare Right
%diff_right = compareFiles(filename_dualPod,filename_dualL,3,3,1);

%% Compare Front
%diff_front = compareFiles(filename_dualPod,filename_dualL,4,4,1);

