%%
clc;
clear all;
close all;

%% Open audio files
path_base = '/Users/maximekolly/Documents/Devialet/Audio/Dolby/AudioExport/';

%% Base filename
filename_base = 'Piste audio';
filename_ext= '.wav';

%% 
configList = {'5.1.0' '5.1.2' '5.1.4' '7.1.2' '7.1.4'};
%configList = {'5.1.0' '5.1.2' '5.1.4' '7.1.0' '7.1.2' '7.1.4'};
%videoList = {'Amaze_48kHz', 'Leaf_48kHz', 'Shattered_48kHz', 'UniverseFury2_48kHz'};
%videoList = {'Chameleon_48kHz', 'CoreUniverse_48kHz', 'Levianthan_48kHz', 'Pufferfish_48kHz'};
%videoList = {'Helicopter_48kHz'};
%videoList = {'Horizon_48kHz'};
videoList = {'Escape_48kHz'};

for m = 1:length(videoList)
    % Process video : 
    videoName = videoList{m}
    
    %% Loop config
    for i = 1:length(configList)
        config = configList{i}
        splited = split(config,'.');
        nbchannel = 0;
        for j= 1:length(splited)
            nbchannel = nbchannel + str2num(splited{j}); 
        end

        % path file 1
        path = strcat(path_base, videoName, '_', config, '/', filename_base, filename_ext);
        [audio_m, Fs1] = audioread(path);
        nbChannelsFile1 = length(audio_m(1,:));
        nbSamplesFile1 = length(audio_m(:,1));

        assert(nbChannelsFile1 == 1);

        % Create output audio
        audio_output = zeros(nbSamplesFile1, nbChannelsFile1);

        % copy channel 1
        audio_output(:,1) = audio_m(:,1);

        % Copy other channels
        for j= 2:nbchannel
            path = strcat(path_base, videoName, '_', config, '/', filename_base, '-', num2str(j), filename_ext);

            % Open 
            [audio_m, Fs] = audioread(path);
            nbChannelsFile = length(audio_m(1,:));
            nbSamplesFile = length(audio_m(:,1));

            % Check data
            assert(Fs == Fs1);
            assert(nbChannelsFile == 1);
            assert(nbSamplesFile == nbSamplesFile1);

            % Copy output
            audio_output(:,j) = audio_m(:,1);
        end

        outputfilename = strcat(path_base, videoName, '_', config, '/', videoName, '_', config, filename_ext)
        audiowrite(outputfilename,audio_output,Fs);
    end
end