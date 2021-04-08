%%
clc;
clear all;
close all;

%% Open audio files
Path = '/Users/maximekolly/Documents/Devialet/Licencing/Projects/Pony/Validation/210324_FinalFiles/DualValidation';

%% sha1 commit
sha1_ref = 'c574d4338886a2e834d3fcb7db57ce84be18d601';
sha1_new = 'c574d4338886a2e834d3fcb7db57ce84be18d601';

    

%% Compare preset 6dB Sweep
%% Preset validated
%presetDualPod = 11;presetDualL = 1; volume = '_6dB_AVL_'; %
% presetDualPod = 11;presetDualL = 1; volume = '_6dB_'; % OK
% presetDualPod = 12;presetDualL = 2; volume = '_6dB_'; % OK
% presetDualPod = 13;presetDualL = 3; volume = '_6dB_'; % OK
% presetDualPod = 14;presetDualL = 4; volume = '_6dB_'; % OK
% presetDualPod = 14;presetDualL = 4; volume = '_6dB_AVL_'; % OK
% presetDualPod = 15;presetDualL = 5; volume = '_6dB_'; % OK
% presetDualPod = 15;presetDualL = 5; volume = '_6dB_AVL_'; % OK
%presetDualPod = 16;presetDualL = 6; volume = '_6dB_'; % OK


%% Process compare
fileDualPod = strcat('P',num2str(presetDualPod),volume,sha1_ref,'.wav');
fileDualL = strcat('P',num2str(presetDualL),volume,sha1_new,'.wav');

filename_dualPod = strcat(Path,'/',fileDualPod);
filename_dualL = strcat(Path,'/',fileDualL);

%% Compare Ref
diff_ref = compareFiles(filename_dualPod,filename_dualL,1,1,1);


%% Compare Sub
diff_sub = compareFiles(filename_dualPod,filename_dualL,9,9,1,1);

%% Compare DualPod : Left DualL : Front
diff_front = compareFiles(filename_dualPod,filename_dualL,2,4,1);

%% Compare DualPod : High L : Left
diff_left = compareFiles(filename_dualPod,filename_dualL,5,2,1);

%% Compare DualPod : High L : Right
diff_right = compareFiles(filename_dualPod,filename_dualL,5,3,1);
