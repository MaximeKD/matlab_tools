%% List audio files in folder
fileList = dir('/Users/maximekolly/Downloads/OutputMaxMSP/*.wav');


%% process new order
for k=1:length(fileList)
    updateChannelsOrder(strcat(fileList(k).folder,'/',fileList(k).name),'chanelConfigPoulencDemoPOCv1.json');
end


