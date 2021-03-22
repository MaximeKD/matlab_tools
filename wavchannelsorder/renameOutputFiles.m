%% List audio files in folder
fileList = dir('/Users/maximekolly/Downloads/OutputMaxMSP/Out/*.wav');

%% Rename Files - Feulle 1.csv must be loaded as data RenameFilesFeuille1
if exist('RenameFilesFeuille1','var') == 0
    error("Load Rename Files - Feulle 1.csv as RenameFilesFeuille1")
end

%% process new order
for k=1:length(fileList)
    fullFilePath = strcat(fileList(k).folder,'/',fileList(k).name)
    
    [path,name,ext] = fileparts(fullFilePath);
    splitID = strsplit(name,'_');
    
    %% Get ID file
    fileID = str2num(char(splitID(2)));
    
    %% New Name from ID
    id = RenameFilesFeuille1.VarName1(fileID);
    namefile = string(RenameFilesFeuille1.DefBassKrewBassBender(fileID));
    vol = string(RenameFilesFeuille1.Nominal(fileID));
    preset = string(RenameFilesFeuille1.Devialet_SPACE(fileID));
    outputFileName = strcat(num2str(id),'_Processed_',namefile,'_',vol,'_',preset)
    
    
    %% Copy audio output
    [audio_m, Fs] = audioread(fullFilePath);
    fileName = strcat(path,'/',outputFileName,ext);
    audiowrite(fileName,audio_m,Fs);
end