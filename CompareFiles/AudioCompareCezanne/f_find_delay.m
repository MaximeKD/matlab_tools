% This function returns the estimated delay between 2 signals
%
% INPUTS:
% - sig1_v: first signal
% - sig2_v: second signal
%
% OUTPUTS:
% - delay_sample: estimated delay between 2 signals in sample

function delay_sample = f_find_delay(sig1_v, sig2_v, FIG)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                    Function allowing to estimate delay                  %
%                     by Baptiste Vericel, 20/07/2018                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin>3
    error('Wrong number of arguments');
end

if nargin<3
    FIG = 0;
elseif (FIG~=0) && (FIG~=1)
    error('Wrong value for parameter FIG');
end

sig1_v = sig1_v(:);
sig2_v = sig2_v(:);

N = min([length(sig1_v) length(sig2_v)]);

sig1_v = sig1_v(1:N);
sig2_v = sig2_v(1:N);

xcorr_v = xcorr(sig1_v,sig2_v);
[max_val,max_idx] = max(abs(xcorr_v));

delay_sample = max_idx-N;

%% To Trace signals
if FIG == 1
    if delay_sample<0
        delay_sample = -delay_sample;
        sig_del_v = cat(1, zeros(delay_sample,1),sig1_v(1:end-delay_sample));
    elseif delay_sample>0
        sig_del_v = cat(1, zeros(delay_sample,1),sig2_v(1:end-delay_sample));
    else
        sig_del_v = sig_1_v;
    end

    figure;

    plot(sig1_v);
    hold on;
    plot(sig2_v);
    plot(sig_del_v);
    legend('Signal','Reference','Delayed signal');
end

