%%
close all
clc

%% Open audio files
Path = '/Users/maximekolly/Documents/Devialet/Licencing/Projects/Cezanne/210323_AudioFileValidation';

%filename1 = 'P2_V0_Cezanne_NRT_2.wav'
%filename2 = 'P2_V0_Cezanne_NRT_1.wav'

filename1 = 'P2_V20_Cezanne_NRT_2.wav'
filename2 = 'P2_V20_Cezanne_NRT_1.wav'

%filename1 = 'P2_V0_Cezanne_NRT_1.wav'
%filename2 = 'P2_V0_Cezanne_NoEQ_Delay3ms.wav'




filenamePath1 = strcat(Path,'/',filename1)
filenamePath2 = strcat(Path,'/',filename2);

% Compare Ref
diff_ref = compareFiles(filenamePath1,filenamePath2,1,1,1);

% Compare Left
diff_sub = compareFiles(filenamePath1,filenamePath2,2,2,1,1);

% Compare Right
diff_left = compareFiles(filenamePath1,filenamePath2,3,3,1,1);