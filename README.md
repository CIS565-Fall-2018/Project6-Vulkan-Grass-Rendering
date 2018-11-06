Vulkan Grass Rendering
========================

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 5**

* Yuru Wang
* Tested on: Windows 10, i7-7700HQ @ 2.5GHz 128GB, GTX 1050 Ti 8GB (personal computer)

### Demo GIF

![](img/demo.gif)

## Project Description ##
This project implements a grass simmulator and renderer using Vulkan. The compute shader is used to perform phusics calculation on Bezier curves that represents individual grass baldes in the application. Culling is done in the compute shader as well because rendering every grass blade on every frame is quite expensive. Three types of culling techniques are used: View frustum culling, distance culling, and orientation culling. The remaining blades are passed to a graphics pipe line consisting of vertex shader, tessellation shaders, and fragment shader to transform Bezier curves into grass geometry and shade them.

A list of features implemented in this project is as follows:
* Compute shader (shaders/compute.comp): perform physics calculation and culling
* Vertex shader (shaders/grass.vert): transform Bezier curve points transformation
* Tessellation control shader (shaders/grass.tesc)
* Tessellation evaluation shader (shaders/grass.tese)
* Fragment shader (shaders/grass.frag): shade the grass geometry

## Results ##

**Distance Culling**

![](img/distance_culling.gif)

**View-frustum Culling**

![](img/view-frustum.gif)

**Orientation Culling**

![](img/orientation-culling.gif)

## Performance Analysis ##

![](img/performance.png)

It can be observed from the figure above that view-frustum culling and orientation culling improve the performance a lot because they eliminate a lot of unnecessary physics and tessellation computation. But the performance improvement of these two culling methods also depends on the camera position. The more Bezier curves are outside view, the better performance can be obtained. As the number of blades increases, the performance of all 5 scenarios drops because there are more calculations going on. With all three culling added, the overall performance could be quite good.
