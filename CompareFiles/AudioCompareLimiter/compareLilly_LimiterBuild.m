%%
clc;
clear all;
close all;

%% Open audio files
path_buildXcode = '/Users/maximekolly/Documents/Devialet/Algos/Limiter/Validation/20210805_XCode_vs_cmake/audio/XCodeBuild';
path_buildCmake = '/Users/maximekolly/Documents/Devialet/Algos/Limiter/Validation/20210805_XCode_vs_cmake/audio/CmakeBuild';


%% Compare audio output Build XCode vs Build Cmake
%filename = 'BobDylan';
%file_xcode = 'P12_V6_XCodeBuild_BobDylan.wav';
%file_cmake = 'P12_V6_CmakeBuild_BobDylan.wav';

filename = 'Lenny';
file_xcode = 'P12_V6_XCodeBuild_Lenny_2.wav';
file_cmake = 'P12_V6_CmakeBuild_Lenny_2.wav';


filename_xcode = strcat(path_buildXcode,'/',file_xcode);
filename_cmake = strcat(path_buildCmake,'/',file_cmake);

% Compare Ref
for k=1:8
    title =  [filename, ' Channel ', int2str(k)];
    diff = compareFiles(filename_xcode,filename_cmake,k,k,1,0,title);
    max(abs(diff))
end



