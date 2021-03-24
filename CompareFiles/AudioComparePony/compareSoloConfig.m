%%
clc;
clear all;
close all;

%% Open audio files
Path = '/Users/maximekolly/Documents/Devialet/Licencing/Projects/Pony/Validation/210324_FinalFiles';

%% sha1 commit
sha1_ref = '2d7203783124480d4261a6958896c9c99cfb28f1';
sha1_new = '74d80b1dad574199369364b254202b5be3601a17';

%% Compare preset 6dB Sweep
%% Preset validated
% presetRef = 31;presetNew = 21; % OK
% presetRef = 32; presetNew = 22;  % OK
% presetRef = 33; presetNew = 23;  % OK
% presetRef = 34; presetNew = 24; % OK
% presetRef = 35; presetNew = 25; % OK
presetRef = 36; presetNew = 26; % OK

%% Process compare
file1 = strcat('Ref_P',num2str(presetRef),'_6dB_',sha1_ref,'.wav');
file2 = strcat('P',num2str(presetNew),'_6dB_',sha1_new,'.wav');

filename1 = strcat(Path,'/',file1);
filename2 = strcat(Path,'/',file2);

% Compare Ref
diff_ref = compareFiles(filename1,filename2,1,1,1);

% Compare Sub
diff_sub = compareFiles(filename1,filename2,9,9,1,1);

% Compare Left
diff_left = compareFiles(filename1,filename2,2,2,1);

% Compare Right
diff_right = compareFiles(filename1,filename2,3,3,1);

%% Compare Front
diff_front = compareFiles(filename1,filename2,4,4,1);

