% This function returns the estimated delay between 2 signals
%
% INPUTS:
% - sig1_v: first signal
% - sig2_v: second signal
%
% OUTPUTS:
% - delay_sample: estimated delay between 2 signals in sample

function diff_channel = compareFiles(filepath1, filepath2, channelfile1, channelfile2, fig)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                    Function allowing to apply delay                     %
%                     by Baptiste Vericel, 20/07/2018                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin < 3 || isempty(channelfile1)
    channelfile1 = 2;
else  
    if ischar(channelfile1)
        channelfile1 = str2num(channelfile1);
    end
end

if nargin < 4 || isempty(channelfile2)
    channelfile2 = 2;
else  
    if ischar(channelfile2)
        channelfile2 = str2num(channelfile2);
    end
end

if nargin < 5 || isempty(fig)
    fig = 0;
else
    if ischar(fig)
        fig = str2num(fig);
    end 
end

% Convert input arguments if needed
if ischar(channelfile2)
    channelfile2 = str2num(channelfile2);
end

[audio1_m, Fs] = audioread(filepath1);
[audio2_m, Fs] = audioread(filepath2);

% Test 2 channels : 1 = ref, 2 = signal
NbChannels1 = length(audio1_m(1,:));
NbChannels2 = length(audio2_m(1,:));
if length(audio1_m(1,:)) < 2 || length(audio2_m(1,:)) < 2
    error('Number of channels must be > 2');
end

if NbChannels1 < channelfile1 
    errorLabel = sprintf('File1 nb channel is %d and asked channel compare is %d',NbChannels1, channelfile1);
    error(errorLabel)
end

% Extract Audio Ref on channel 1
channel1_ref = 1;
channel2_ref = 1;
N_ref = min([length(audio1_m(:,channel1_ref)) ...
         length(audio2_m(:,channel2_ref))]);

audio_ref1 = audio1_m(1:N_ref,channel1_ref);
audio_ref2 = audio2_m(1:N_ref,channel2_ref);

audio1_channel = audio1_m(1:N_ref,channelfile1);
audio2_channel = audio2_m(1:N_ref,channelfile2);

% Extract delay
delay_sample_f1 = f_find_delay(audio_ref1,audio1_channel);
delay_sample_f2 = f_find_delay(audio_ref2,audio2_channel);
delay_sample_ref = f_find_delay(audio_ref1,audio_ref2);
delay_sample_channels = f_find_delay(audio1_channel,audio2_channel);

if delay_sample_f1 ~= delay_sample_f2
   disp('Delay found for channels is different is file 1 and file 2')
   delay_sample_f1
   delay_sample_f2
end

if delay_sample_ref ~= delay_sample_channels
   disp('Delay found for channels ref is different than channel')
   delay_sample_ref
   delay_sample_channels
end

% delay_sample = delay_sample_f2 - delay_sample_f1;
% delay_sample = delay_sample_files
delay_sample = delay_sample_channels

if delay_sample<0
    delay_to_apply = -delay_sample;
    audio1_m = f_apply_delay(audio1_m,delay_to_apply);
    audio2_m = f_apply_delay(audio2_m,0);
else
    audio1_m = f_apply_delay(audio1_m,0);
    audio2_m = f_apply_delay(audio2_m,delay_sample);
end

% Add constant delay to avoid frequency response unexpected behavior
delay_sample_offset = round(0.1 * Fs);
audio1_m = f_apply_delay(audio1_m,delay_sample_offset);
audio2_m = f_apply_delay(audio2_m,delay_sample_offset);

% Extract same length
N = min([length(audio1_m(:,channelfile1)) ...
         length(audio2_m(:,channelfile2))]);
time_v = (0:N-1)/Fs;
     
audio1_channel = audio1_m(1:N,channelfile1);
audio2_channel = audio2_m(1:N,channelfile2);

diff_channel = audio1_channel - audio2_channel;

if fig == 1
    figure;
    s1 = subplot(2,1,1);
    plot(time_v,audio1_channel);
    hold on;
    plot(time_v,audio2_channel);
    grid on;
    label = sprintf('Audio signals channel');
    ylabel(label);
    labeltitle = sprintf('Delay %d',delay_sample);
    title(labeltitle);
    legend('File 1', 'File 2');

    s2 = subplot(2,1,2);
    plot(time_v,diff_channel);
    grid on;
    ylabel('Difference');
    xlabel('Time (s)');

    linkaxes([s1 s2], 'x');
end
