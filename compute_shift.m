function min_shift = compute_shift(img_array_1, img_array_2, varargin)
% compute relative shift that leads to min intensity difference between the
% two input image intesity arrays
% *************************************************************************
% Description: TODO
% The comparison between images is performed by calculating
% the average absolute intensity difference between the two
% image arrays, f(s), as they are shifted relative to each other
%
%
%
% References:
% [1]  Milford, Wyeth - Single Camera Vision-Only SLAM on a Suburban Road Network
%
% *************************************************************************

if nargin > 2
    debug_flag = varargin{1};
else
    debug_flag = false;
end

% get parameters
% ---------------------
par                = get_parameters();
max_abs_shift_perc = par.max_abs_shift_perc; % max shift to be investigated is max_abs_shift_perc percent of the length of the image array

max_abs_shift = round(length(img_array_1) * max_abs_shift_perc);

% init debug data
% ---------------------
if debug_flag
    shifts  = zeros(2*max_abs_shift + 1, 1);
    diffs   = zeros(2*max_abs_shift + 1, 1);
    deb_idx = 1;
end

% compute the average absolute intensity difference between the two
% image arrays (see eq. (4) in [1]) and search for the shift that minimizes it
% ---------------------
min_shift                  = 0; % shift that minimizes intensity difference
min_avg_abs_intensity_diff = Inf;
for cur_shift = -max_abs_shift:max_abs_shift % check out every shift from allowed range
    % compute the average absolute intensity difference for current shift
    % ---------------------
    avg_abs_intensity_diff = 0;
    w_minus_s              = (length(img_array_1) - abs(cur_shift));
    max_s_0                = max(cur_shift, 0);
    min_s_0                = min(cur_shift, 0);
    for idx = 1:w_minus_s
        avg_abs_intensity_diff = avg_abs_intensity_diff + abs(img_array_2(idx + max_s_0) - img_array_1(idx - min_s_0));
    end
    avg_abs_intensity_diff = avg_abs_intensity_diff / w_minus_s;
    
    if avg_abs_intensity_diff < min_avg_abs_intensity_diff
        min_avg_abs_intensity_diff = avg_abs_intensity_diff;
        min_shift                  = cur_shift;
    end
    
    % store debug data
    % ---------------------
    if debug_flag
        shifts(deb_idx) = cur_shift;
        diffs(deb_idx)  = avg_abs_intensity_diff;
        deb_idx         = deb_idx + 1;
    end
end

% plot debug output if desired
% ---------------------
if debug_flag
    figure(444);
    subplot(3, 1, 1);
    plot(img_array_1);
    legend('image intensity array 1')
    subplot(3, 1, 2);
    plot(img_array_2);
    legend('image intensity array 2')
    subplot(3, 1, 3);
    plot(shifts, diffs);
    legend('average absolute intensity difference')
end