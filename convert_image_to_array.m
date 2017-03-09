function array = convert_image_to_array(image_rgb, varargin)
% convert color image to an array of column intensity values
% *************************************************************************
% Description: 
% i.)   Convert the color image (rgb) to a grayscale image
% ii.)  Crop to a sub window (around the center)
% iii.) Sum and normalize each pixel column to form a one-dimensional array
% See section III of reference [1] for more details.
%
% References:
% [1]  Milford, Wyeth - Single Camera Vision-Only SLAM on a Suburban Road Network
%
% INPUT:
% ------
% image_rgb ...
%
% OUTPUT:
% -------
% array ...
%
% *************************************************************************

if nargin > 1
    debug_flag = varargin{1};
else
    debug_flag = false;
end

% get parameters
% ---------------------
par        = get_parameters();
crop_rows  = par.crop_rows;
crop_cols  = par.crop_cols;

% convert the color image to a grayscale image
% ---------------------
image_grayscale = rgb2gray(image_rgb);

% crop to a crop_rows?crop_cols pixel sub window (with the same center)
% ---------------------
image_center         = round(size(image_grayscale)/2);
crop_image_row_range = ((image_center(1) - crop_rows/2)+1) : ((image_center(1) + crop_rows/2));
crop_image_col_range = ((image_center(2) - crop_cols/2)+1) : ((image_center(2) + crop_cols/2));
image_grayscale_crop = image_grayscale(crop_image_row_range, crop_image_col_range);

% sum pixel columns to compute 1D intesity array from image
% ---------------------
array = sum(image_grayscale_crop); % sum values in each column
array = array / max(abs(array));   % normalize

% plot debug output if desired
% ---------------------
if debug_flag
    figure(111);
    imshow(image_grayscale);
    
    figure(222);
    imshow(image_grayscale_crop);
    
    figure(333);
    plot(array);
end