%% 
clc

%% List audio files in folder
path = 'audio';

%% List audio files in folder
fileList = dir(strcat(path,'/*.wav'));

%% Audio ref
inputRefFile = 'silence_sweep_Fmin1_Fmax24000_Fs48000_Mono.wav';
[audio_ref, Fs] = audioread(inputRefFile);

%% process new order
for k=1:length(fileList)
    fullFilePath = strcat(fileList(k).folder,'/',fileList(k).name)
    
    [path,name,ext] = fileparts(fullFilePath);
        
    %%
    outputFileName = strcat(name,'_ref');

    %% Copy audio output
    [audio_m, Fs] = audioread(fullFilePath);
    %N = length(audio_m(:,1));
    %NbChanel = length(audio_m(1,:))
    
    [N, NbChannel] = size(audio_m)
    N_ref = length(audio_ref(:,1));
    
    if  N < N_ref
        error('Length')
    end

    ref_audio_length = [zeros(N-N_ref,1);audio_ref(:,1)];
    
    %% Add Ref
    audio_out = zeros(N,NbChannel+1);
    audio_out(:,1) = ref_audio_length(:,1);
    audio_out(:,2:end) = audio_m;
    
    
    %%
    fileName = strcat(path,'/',outputFileName,ext);
    audiowrite(fileName,audio_out,Fs);
    
    
end