%% 
clc

%% List audio files in folder
path = '/Users/maximekolly/Documents/Devialet/Licencing/Projects/Pony/Validation/210324_FinalFiles/DualValidation';

%% List audio files in folder
fileList = dir(strcat(path,'/*.wav'));


sha1 = 'c574d4338886a2e834d3fcb7db57ce84be18d601';

%% process new order
for k=1:length(fileList)
    fullFilePath = strcat(fileList(k).folder,'/',fileList(k).name)
    
    [path,name,ext] = fileparts(fullFilePath);
    splitID = strsplit(name,'_');
    
    %% Get ID file
    presetID = char(splitID(1));
    volumeID = char(splitID(2));
    date = char(splitID(3));
    
    numberOfsplit = strfind(date,'-');
    if length(numberOfsplit) == 3
        dataFormat, match = strsplit(date,'-')
        
        %%
        outputFileName = strcat(presetID,'_',volumeID,'_',sha1);
        
        %% Copy audio output
        [audio_m, Fs] = audioread(fullFilePath);
        fileName = strcat(path,'/',outputFileName,ext);
        audiowrite(fileName,audio_m,Fs);
    end
    
    %% New Name from ID
    
    
    
end