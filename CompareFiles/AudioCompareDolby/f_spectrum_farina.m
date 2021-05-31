% This function compute spectrum out of sweep measurement (Farina method)
%
% [spectrum_v,freq_v] = f_spectrum_farina(measurement_v, ref_v, Fs)
%
% INPUTS:
% - measurement_v: measured signal
% - ref_v : reference sweep
%
% OUTPUTS:
% - spectrum_v: returned spectrum
% - freq_v: frequency vector

function [spectrum_v,freq_v] =...
    f_spectrum_farina(measurement_v,...
                              ref_v,...
                              Fs)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Function computing spectrum out of sweep measurement (Farina method)   %
%                     by Baptiste Vericel, 14/01/2019                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin<3
    Fs = 48000; % Default Fs is 48000
end

f1 = 1;
f2 = 20000;
nb_harm = 2;
fig = 0;
P = 2^16;
N = 2^16;

% Check measurement legnth vs ref legnth, remove end of measurement signal
% if necessary (Farina method constraint)
if(length(measurement_v)>length(ref_v))
    measurement_v = measurement_v(1:length(ref_v));
end

[IRL,SH,THD,RNB,F,SLc,SLp] =...
    FarinaExtractionAbsoluArray(measurement_v,...
                                ref_v,...
                                f1,f2,nb_harm,fig,Fs,P,N);

freq_v = F;
spectrum_v = SLc;




