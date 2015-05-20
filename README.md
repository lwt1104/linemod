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


====================================================================================
Ork pipeline training and detecting usage guide
Reference link: http://wg-perception.github.io/ork_tutorials/tutorial03/tutorial.html

Environment setup:
	start openni:
		roslaunch openni_launch openni.launch
	register color and depth:
		rosrun rqt_reconfigure rqt_reconfigure
		
		Select /camera/driver from the drop-down menu and enable the depth_registration checkbox. In RViz, change the PointCloud2 topic to /camera/depth_registered/points and set the Color Transformer to RGB8 to see both color and 3D point cloud of your scene. The detailed explanation can be found here: http://wiki.ros.org/openni2_launch.

Add object to database:
	rosrun object_recognition_core object_add.py -n <object_name> -d <object description> --commit
	Example:
		rosrun object_recognition_core object_add.py -n "coke" -d "A universal can of coke" --commit

Add mesh file for object created in the database:
	rosrun object_recognition_core mesh_add.py <YOUR_OBJECT_ID> <path to ork_tutorials/data/coke.stl> --commit

(Commnet: all the object and related entries can be viewed in the database http://localhost:5984/_utils/database.html?object_recognition/_all_docs)

Train linemod template after mesh file has been uploaded to database
	rosrun object_recognition_core training -c `rospack find object_recognition_linemod`/conf/training.ork
	(comment: traning parameters and objects can be specified in "training.ork" file)

Test linemod:
    roslaunch object_recognition_linemod linemod.launch
    (comment: linemod.launch located at ~/ros_ws/src/linemod/launch/ can be configured based on needs.
     detection paramters can be specified in conf/detection.ros.ork file and make sure linemod.launch load the correct version of detection.ork file)

Detect an object if necessary:
	rosrun object_recognition_core object_delete.py <OBJECT_ID> --commit
	(comment: using this command can delete object in the database neatly)

==========================================================================================
Tips about configure file: training.ork/detection.ros.ork
 
These configure files can specifiy paramters for training and detection. e.g.
object_ids: 'all'  means training/detecting all the object in the databse;
object_ids: ['51367d45306f680ad728ee02780021d6'] means training/detecting only object id '51367d45306f680ad728ee02780021d6' in the databse.

You can creaet variable in cpp file and assign value to it through configure file so that you don't need to recompile if you want to change's the varible's value. e.g. You can declare a varialbe in the cpp file:
	params.declare(&Detector::depth_max_, "depth_max", "", 2000); // 2000 is the default value if no value is given in the configure file
Then in the configure file, you can assign a value to depth_max_:
	depth_max: 5000


=================================================================================================
The root node of the hierachy of ORK pipeline tutorial is:
http://wg-perception.github.io/object_recognition_core/