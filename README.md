============================================================================
Installation of linemod and ork_render:

Intall dependency:
	./install.sh 

Download linemod and ork_render package:
	cd ~/ros_ws/src
	git clone https://github.com/lwt1104/linemod.git
	git clone https://github.com/lwt1104/ork_renderer.git 
Install linemod and ork_render
	cd ~/ros_ws
	catkin_make

If any problems appears, refer to discussion "Object recognition kitchen linemod installation and test" in BaseCamp for debugging.


============================================================================
Ork pipeline training and detecting usage guide
Reference link: http://wg-perception.github.io/ork_tutorials/tutorial03/tutorial.html

Environment setup:
	roslaunch openni_launch openni.launch
	
	rosrun rqt_reconfigure rqt_reconfigure
	
	Select /camera/driver from the drop-down menu and enable the depth_registration checkbox. In RViz, change the PointCloud2 topic to /camera/depth_registered/points and set the Color Transformer to RGB8 to see both color and 3D point cloud of your scene. The detailed explanation can be found here: http://wiki.ros.org/openni2_launch.

Add object to database:
	rosrun object_recognition_core object_add.py -n <object_name> -d <object description> --commit
	Example:
		rosrun object_recognition_core object_add.py -n "coke" -d "A universal can of coke" --commit
Add mesh file for object created in the database:
	rosrun object_recognition_core mesh_add.py <YOUR_OBJECT_ID> <path to ork_tutorials/data/coke.stl> --commit

Train linemod template after mesh file has been uploaded to database
	rosrun object_recognition_core training -c `rospack find object_recognition_linemod`/conf/training.ork
	(comment: traning parameters and objects can be specified in "training.ork" file)

Test linemod:
    roslaunch object_recognition_linemod linemod.launch
    (comment: linemod.launch located at ~/ros_ws/src/linemod/launch/ can be configured based on needs.
     )


