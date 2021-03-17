%% Open audio files
Path = '/Users/maximekolly/Documents/Devialet/Licencing/Projects/Pony/Validation/20210317_Dual_DualL/';

filename_dualPod = strcat(Path,'PresetDual3.wav');
filename_dualL = strcat(Path,'PresetLeft3.wav');

%% Compare Sub
diff_sub = compareFiles(filename_dualPod,filename_dualL,9,9,1);


%% Compare DualPod : Left DualL : Front
diff_front = compareFiles(filename_dualPod,filename_dualL,2,4,1);


%% Compare DualPod : High L : Left
diff_left = compareFiles(filename_dualPod,filename_dualL,5,2,1);

%% Compare DualPod : High L : Right
diff_right = compareFiles(filename_dualPod,filename_dualL,5,3,1);
