% This function returns write output wav file with new channels order
%
% INPUTS:
% - sig1_v: first signal
% - sig2_v: second signal
%
% OUTPUTS:
% - delay_sample: estimated delay between 2 signals in sample

function  updateWavChannelsOrder(filepath1, wavConfigfile)


%% Extract Path and audio fileName
[filepath,name,ext] = fileparts(filepath1);

[audio_m, Fs] = audioread(filepath1);
NbChannelsFile = length(audio_m(1,:));
NbSamplesFile = length(audio_m(:,1));

%% Extract wav channels audio config
channelConfig = jsondecode(fileread(wavConfigfile));
channelsNames = fieldnames(channelConfig);

fieldNamePrefix = 'ch';
chOrder = [];

for k=1:numel(channelsNames)
    nameField = char(channelsNames(k));
    [number,matches] = strsplit(nameField,{fieldNamePrefix});
    if (strcmp(char(matches),fieldNamePrefix)) == 1 & (length(number) == 2)
        chOrder = [chOrder str2num(char(number(2)))];
    end
end

minChannel = min(chOrder);
maxChannel = max(chOrder);

if minChannel < 1
    error("Min channel Must be 1")
end

if isequal(minChannel:maxChannel,sort(chOrder)) == 0
    error("Missing channel config")
end

extractOrder = [];
for k=1:maxChannel
   fieldName = strcat(fieldNamePrefix,num2str(k));
   value = getfield(channelConfig,fieldName);
   if isnumeric(value) == 0
    error("Channel must be numeric")
   end
   extractOrder = [extractOrder value];
end

%% Extract Audio data
audioOutput = zeros(NbSamplesFile,maxChannel);

for k=1:length(extractOrder)
    if extractOrder(k) > 0
        audioOutput(:,k) = audio_m(:,extractOrder(k));
    end
end

%% Write output file
fileName = strcat(filepath,'/','Output_',name,ext);
audiowrite(fileName,audioOutput,Fs);
