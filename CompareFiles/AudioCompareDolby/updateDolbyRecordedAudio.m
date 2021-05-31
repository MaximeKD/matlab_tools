%%
clc;
clearvars;
close all;

%% Open audio files
path_ref = '/Users/maximekolly/Documents/Devialet/Audio/VideoOnly/ATMOS';
path_in = '/Users/maximekolly/Documents/Devialet/Audio/Dolby/AudioExport';

refFileList = {  
                   'Escape/audio_ref/Escape_vlc',...
%                  'AudioSphere/dolby-audiosphere-vlc',...
%                 'Helicopter/Helicopter', ...
%                 'Horizon/Horizon',...
%                 'Amaze/dolby-atmos-trailer_amaze_1080.track_ExportVLC', ...
%                 'Chameleon/Chameleon_VLC', ... 
%                 'CoreUniverse/Core Universe_VLC', ...
%                 'Leaf/dolby-atmos-trailer_leaf_1080_ExportVLC',  ...
%                 'Leviathan/Leviathan_VLC', ...
%                 'Pufferfish/Pufferfish_VLC', ...
%                 'Shattered/shattered-3Mb_ExportVLC', ...
%                 'UniverseFury2/Universe_Fury2_ExportVLC'...
              };
          
inputFileList = { 
                    'Escape_48kHz', ... 
%                   'AudioSphere_48kHz',...
%                  'Helicopter_48kHz', ...
%                   'Horizon_48kHz', ...   
%                  'Amaze_48kHz', ...
%                 'Chameleon_48kHz', ... 
%                 'CoreUniverse_48kHz', ...
%                 'Leaf_48kHz',  ...
%                 'Levianthan_48kHz', ...
%                 'Pufferfish_48kHz', ...
%                 'Shattered_48kHz', ...
%                 'UniverseFury2_48kHz'...
                    };

for k=1:length(refFileList)

    %% Find delay between Ref and Input 
    file_ref = refFileList{k};
    file_in = inputFileList{k};
    file_extension = '.wav';

    configList = {'5.1.0' '5.1.2' '5.1.4' '7.1.2' '7.1.4'};

    for i=1:length(configList)
        config = configList{i};

        %% 
        filepath_ref = strcat(path_ref,'/',file_ref, file_extension);
        filepath_in = strcat(path_in,'/', file_in, '_', config,  '/', file_in, '_', config, file_extension);
        fprintf('Update file %s\n',filepath_in)

        %% Get Ref info
        [audio_ref, Fs_ref] = audioread(filepath_ref);
        [audio_in, Fs_in] = audioread(filepath_in);

        canal_ref = 1;

        nbChannels = length(audio_ref(1,:));
        nbSamples = length(audio_ref(:,canal_ref));
        fprintf('Ref file has length %d\n',nbSamples)

        %% Get Input Info
        nbChannels_in = length(audio_in(1,:));
        canal_in = 1; %nbChannels_in;
        nbSamples_in = length(audio_in(:,canal_in));

        assert(nbSamples_in > nbSamples);
        assert(nbChannels_in > nbChannels);
        assert(Fs_ref == Fs_in);

        %% Extract X sec of audio to find delay
        timeExtract = 10;
        N_ref = min([length(audio_in(:,canal_in)) ...
                 length(audio_ref(:,canal_ref)) ...
                 timeExtract * Fs_ref]);

        assert(N_ref == timeExtract * Fs_ref);
        audio_extract_ref = audio_ref(1:N_ref,canal_ref);
        audio_extract_in = audio_in(1:N_ref,canal_in);

        maxabs_audio_ref = max(abs(audio_extract_ref));
        maxabs_audio_in = max(abs(audio_extract_in));
        assert(maxabs_audio_ref > 0);
        assert(maxabs_audio_in > 0);

        %% Find delay
        delay_sample = f_find_delay(audio_extract_ref,audio_extract_in);

        current_length = 0;
        %% Create Silence if needed, Set sample_extract_start
        if delay_sample < 0
            nb_start_silence = -delay_sample;
            sample_extract_start = 1;
            fprintf('Create Start Silence with length %d\n',nb_start_silence)
        elseif delay_sample == 0
            nb_start_silence = 0;
            sample_extract_start = 1;
        else
            % delay > 0
            nb_start_silence = 0;
            sample_extract_start = delay_sample;
        end
        audio_start_silence = zeros(nb_start_silence,nbChannels_in);

        %% Create End Silence if needed to rech nbSamples   
        nb_samples_needed = nbSamples - nb_start_silence;

        if nb_samples_needed > (nbSamples_in - sample_extract_start)
            % Need additionnal silence
            nb_end_silence = nbSamples - nb_start_silence - nbSamples_in;
            sample_extract_end = nbSamples_in;
            fprintf('Create End Silence with length %d\n',nb_end_silence)
        else
            nb_end_silence = 0;
            sample_extract_end = nbSamples - nb_start_silence;
        end
        audio_end_silence = zeros(nb_end_silence,nbChannels_in);

        %% Create output audio
        audio_output = [audio_start_silence;audio_in(sample_extract_start:sample_extract_end,:);audio_end_silence];
        fprintf('Create Output audio with length %d\n',length(audio_output(:,1)));

        outputfilename = strcat(path_in,'/', file_in, '_', config, '/', file_in, '_', config, '_output', file_extension)
        audiowrite(outputfilename,audio_output,Fs_ref);
    end
end
