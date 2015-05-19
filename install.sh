#!/bin/sh -e

usage="
Usage: $0  
Install dependencies of Linemod and ork_render

Examples:

./install.sh
"
	
printf "Installing dependencies for linemod and ork_render at /opt/ros/indigo/"

printf "********************************\n"
sudo apt-get install ros-indigo-object-recognition-capture
sudo apt-get install ros-indigo-object-recognition-core
sudo apt-get install ros-indigo-object-recognition-msgs
sudo apt-get install ros-indigo-object-recognition-reconstruction
sudo apt-get install ros-indigo-object-recognition-ros
sudo apt-get install ros-indigo-object-recognition-ros-visualization
sudo apt-get install ros-indigo-object-recognition-tabletop
sudo apt-get install ros-indigo-object-recognition-tod
sudo apt-get install ros-indigo-object-recognition-transparent-objects
printf "********************************\n"
printf "DONE!\n"

