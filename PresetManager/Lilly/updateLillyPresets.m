clc;
clear;

%%
addpath('/Users/maximekolly/Documents/Devialet/Dev/dsp_algo/dsp_dive_tools/Simulink')
lilly_preset_path = '/Users/maximekolly/Documents/Devialet/Dev/pipeline/dsp_dive_lilly/MaxMsp/DIVE/data/Lilly_preset.json'

%%
P = PresetManager(); %create object instance
P.load(lilly_preset_path); %load the .json file
P.compare_lines('"' + "LIMITERS::",18,15)
% P.compare_presets(18,1)
% P.view_preset(1); %view preset informations
% P.compare_presets(preset_number_1, preset_number_2); %view differences between 2 presets
%