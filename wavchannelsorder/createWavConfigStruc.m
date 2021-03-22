
%% Create struc of wav config to order the wav channels in updateWavChannelsOrder


%data = '{"channelConfig":[{0:2},{1:3}]}'
%jsondecode(data)

chanelConfig.ch1 = 6;
chanelConfig.ch2 = 5;
chanelConfig.ch3 = 4;
chanelConfig.ch4 = -1;
chanelConfig.ch5 = 2;
chanelConfig.ch6 = 3;
data = jsonencode(chanelConfig,'PrettyPrint',true)


%% Write config file
fileID = fopen('chanelConfigPoulencDemoPOCv1.json','w');
fwrite(fileID,data);
fclose(fileID);
