# TrackHeading
A simple Matlab program to track heading changes of a rotating camera (e.g. the one on your laptop)

A simple method for tracking the heading of a camera is implemented. The method was proposed in reference [1].

The implementation was optimized for and tested with a built-in laptop camera. When the laptop with the camera is turned around a single axis 
(usually the axis perpendicular to the base of the laptop), the current approximate heading is plotted in a figure and printed to the Matlab command line.

Before using, please execute the calibrate function. Calibration should be re-run every time the camera position relative to the laptop base changes 
(i.e., you change the tilt of the screen of the laptop).

Execute main function to run the program. Turn (say horizontally) the laptop with the camera and observe how the estimated heading changes. Note that it
is assumed that the environment is static. Dynamic objects in the scene lead to errors in heading estimates. Furthermore, rotation around other axis 
as well as translations also disrupt the heading estimation. Please keep in mind that this is just a toy example and a pet project to play a bit with 
some computer vision basics :)

To quit press ctrl-C

References: 
[1]  Milford, Wyeth - Single Camera Vision-Only SLAM on a Suburban Road Network