clc;
clear all;

%% List m4a audio files in folder and sub folders
fileList =  dir('/Users/maximekolly/download/**/*.m4a');
outputFolder = '/Users/maximekolly/Documents/Devialet/Audio/Dolby/DolbyAtmosMusic/Playlist';

%% process new order
audio_list = {};
for k=1:length(fileList)
    fullFilePath = strcat(fileList(k).folder,'/',fileList(k).name);
    
    [path,name,ext] = fileparts(fullFilePath);
    
    splitID = strsplit(name,'-');
    fileName = strcat(name(6:end),ext);
 
    outputFullFileName = fullfile(outputFolder, fileName);
    
    copyfile(fullFilePath, outputFullFileName);
    
end