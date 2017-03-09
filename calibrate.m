function calibrate
% calibrate the camera for tracking its heading
% *************************************************************************
% Description: 
%
% *************************************************************************

% get parameters
% ---------------------
par         = get_parameters();
calib_angle = par.calib_angle;
calib_time  = par.calib_time;

% connect to the webcam
% ---------------------
cam = webcam(1);

% the user has to rotate the camera by calib_anle
% ---------------------
disp(['Rotate the camera horizontaly by ' num2str(calib_angle) ' degrees within ' num2str(calib_time) ' seconds.']);
disp('Press any key to start calibration');
pause;

% acquire an image and convert to intensity array
% ---------------------
image_rgb  = snapshot(cam);
array_prev = convert_image_to_array(image_rgb);

shot_cnt    = 1;
cumul_shift = 0;
start_time  = tic();
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
    
    shot_cnt = shot_cnt + 1;
    disp(shot_cnt);
    
    elapsed_time = toc(start_time);
    if elapsed_time > calib_time
        break;
    end
end

calib_angle
cumul_shift

lambda = calib_angle / cumul_shift

save lambda lambda

% once the connection to web cam is no longer needed, clear the associated variable
% ---------------------
clear cam