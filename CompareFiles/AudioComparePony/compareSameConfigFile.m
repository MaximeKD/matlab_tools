%% Open audio files
Path = '/Users/maximekolly/Documents/Devialet/Licencing/Projects/Pony/Validation/20210317_Dual_DualL/';

%filename_dualPod = strcat(Path,'DualPod_Vol0_Test1.wav');
%filename_dualL = strcat(Path,'DualPod_Vol0_Test2.wav');

%filename_dualPod = strcat(Path,'DualPod_Vol0_Init1.wav');
%filename_dualL = strcat(Path,'DualPod_Vol0_Init2.wav');

filename_dualPod = strcat(Path,'PresetLeft3.wav');
filename_dualL = strcat(Path,'PresetLeft2.wav');

% Compare Ref
diff_ref = compareFiles(filename_dualPod,filename_dualL,1,1,1);


% Compare Sub
diff_sub = compareFiles(filename_dualPod,filename_dualL,9,9,1);


% Compare Left
diff_left = compareFiles(filename_dualPod,filename_dualL,2,2,1);


% Compare Right
diff_right = compareFiles(filename_dualPod,filename_dualL,3,3,1);

%% Compare Front
diff_front = compareFiles(filename_dualPod,filename_dualL,4,4,1);

% %% Compare high L
% diff_hl = compareFiles(filename_dualPod,filename_dualL,5,5,1);
% 
% %% Compare high R
% diff_hr = compareFiles(filename_dualPod,filename_dualL,6,6,1);
