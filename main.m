function main

% load calibration data
% ---------------------
load lambda

% connect to the webcam
% ---------------------
cam = webcam(1);

% acquire an image and convert to intensity array
% ---------------------
image_rgb  = snapshot(cam);
array_prev = convert_image_to_array(image_rgb);

% accumulate shift over time; use calibration data to convert
% shift to heading
% ---------------------
cumul_shift     = 0; % zero shift = zero heading (initial condition)
cumul_angle_arr = []; % used to plot
while 1
    % acquire an image and convert to intensity array
    % ---------------------
    image_rgb = snapshot(cam);
    array_cur = convert_image_to_array(image_rgb);
    
    % compute shift between the consecutive intensity arrays
    % ---------------------
    cur_shift = compute_shift(array_cur, array_prev);
    
    array_prev = array_cur;
    
    cumul_shift = cumul_shift + cur_shift;
    
    % convert cumulative shift to angle (in degrees)
    % ---------------------
    cumul_angle = lambda * cumul_shift;
    
    cumul_angle_arr(end+1) = cumul_angle;
    
    % display and plot angle
    % ---------------------
    disp(cumul_angle)
    figure(1234);
    plot(cumul_angle_arr);
    xlabel('sample');
    ylabel('heading [deg]');
end

% once the connection to web cam is no longer needed, clear the associated variable
% ---------------------
clear cam

end

