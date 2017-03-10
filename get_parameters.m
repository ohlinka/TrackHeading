function par = get_parameters()
% get and set parameters
% *************************************************************************
% Description: Modify the parameters to change the desired behavior.
%
% *************************************************************************

% calibration
% ---------------------
par.calib_angle = 90; % [deg]
par.calib_time  = 10; % [s]

% conversion of color rgb image to intensity array
% ---------------------
par.crop_rows  = 150; % must be even number!
par.crop_cols  = 500; % must be even number!

% computation of shift
% ---------------------
par.max_abs_shift_perc = 0.8; % max shift to be investigated is max_abs_shift_perc percent of the length of the image array
