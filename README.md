Vulkan Grass Rendering
======================

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 6**

* Ziad Ben Hadj-Alouane
  * [LinkedIn](https://www.linkedin.com/in/ziadbha/), [personal website](https://www.seas.upenn.edu/~ziadb/)
* Tested on: Windows 10, i7-8750H @ 2.20GHz, 16GB, GTX 1060


<p align="center"><img width="700" height="500" src="https://github.com/ziedbha/Project6-Vulkan-Grass-Rendering/blob/master/img/top.gif"/></p>


## Grass Rendering
In this project, I implemented a grass simulator and renderer using Vulkan. The main paper referenced is [Responsive Real-Time Grass Rendering for General 3D Scenes](https://www.cg.tuwien.ac.at/research/publications/2017/JAHRMANN-2017-RRTG/JAHRMANN-2017-RRTG-draft.pdf).

<p align="center"><img width="700" height="500" src="https://github.com/ziedbha/Project6-Vulkan-Grass-Rendering/blob/master/img/blade_model.jpg"/></p>


### Compute 
I use a compute shader to perform physics calculations (gravity, wind, etc..) on Bezier curves that represent individual grass blades. I also use this to perform culling optimizations: based on distance, orientation, and the view-frustum.

### Tesselation
To generate grass vertices, I tesselate the grass blade using a quad based on how far it is from the camera. **A blade is more detailed the closer it is**. 

### Rendering
After a grass is tesselated, I compute a fragments lerped values in the evaluation tesselation phase. After that, I perform simple lambert shading on each fragment.

### Contents

* `src/` C++/Vulkan source files.
  * `shaders/` glsl shader source files
  * `images/` images used as textures within graphics pipelines
* `external/` Includes and static libraries for 3rd party libraries.

## Culling Optimizations

Here are some heuristics I used to cull blades that won't contribute positively to a given frame.

#### Orientation culling

Consider the scenario in which the front face direction of the grass blade is perpendicular to the view vector. Since our grass blades
won't have width, we will end up trying to render parts of the grass that are actually smaller than the size of a pixel. This could
lead to aliasing artifacts. We remove this blades from the rendering phase

<p align="center"><img width="700" height="500" src="https://github.com/ziedbha/Project6-Vulkan-Grass-Rendering/blob/master/img/orient_cull.gif"/></p>

#### View-frustum culling

We also want to cull blades that are outside of the view-frustum, considering they won't show up in the frame anyway. The paper describes an algorithm to determine if a blade needs to be culled.

#### Distance culling

Similarly to orientation culling, we can end up with grass blades that at large distances are smaller than the size of a pixel. This could lead to additional artifacts in our renders. In this case, we can cull grass blades as a function of their distance from the camera.

<p align="center"><img width="700" height="500" src="https://github.com/ziedbha/Project6-Vulkan-Grass-Rendering/blob/master/img/dist_cull.gif"/></p>


## Performance Analysis

The performance analysis is where you will investigate how...
* Your renderer handles varying numbers of grass blades
* The improvement you get by culling using each of the three culling tests

## Credits

The following resources were useful in implementing this project

* [Responsive Real-Time Grass Grass Rendering for General 3D Scenes](https://www.cg.tuwien.ac.at/research/publications/2017/JAHRMANN-2017-RRTG/JAHRMANN-2017-RRTG-draft.pdf)
* [CIS565 Vulkan samples](https://github.com/CIS565-Fall-2018/Vulkan-Samples)
* [Official Vulkan documentation](https://www.khronos.org/registry/vulkan/)
* [Vulkan tutorial](https://vulkan-tutorial.com/)
* [RenderDoc blog on Vulkan](https://renderdoc.org/vulkan-in-30-minutes.html)
* [Tessellation tutorial](http://in2gpu.com/2014/07/12/tessellation-tutorial-opengl-4-3/)

