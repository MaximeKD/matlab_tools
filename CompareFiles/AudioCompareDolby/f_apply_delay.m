% This function apply a delay in samples to a signal
%
% INPUTS:
% - sig_m: input signal
% - delay_sample: delay to be applied in sample
%
% OUTPUTS:
% - out_m

function out_m = f_apply_delay(sig_m, delay_sample)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                    Function allowing to apply delay                     %
%                     by Baptiste Vericel, 20/07/2018                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin>2
    error('Wrong number of arguments');
end

nb_channel = length(sig_m(1,:));

if delay_sample > 0
    out_m = cat(1,...
                zeros(delay_sample,nb_channel),...
                sig_m(1:end-delay_sample,:));
elseif delay_sample < 0
    out_m = cat(1,...
        sig_m(-delay_sample+1:end,:),...
        zeros(-delay_sample,nb_channel));
elseif delay_sample == 0
    out_m = sig_m;
end
