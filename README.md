README - Vulkan Grass Rendering
========================

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 6**

* Zach Corse
  * LinkedIn: https://www.linkedin.com/in/wzcorse/
  * Personal Website: https://wzcorse.com
  * Twitter: @ZachCorse
* Tested on: Windows 10, i7-6700HQ @ 2.60GHz 32GB, NVIDIA GeForce GTX 970M (personal computer)

Introduction
------------
In this project, I use Vulkan to implement a grass simulator and renderer. I use compute shaders to perform physics calculations on Bezier curves that represent individual grass blades. Since rendering every grass blade on every frame is fairly inefficient, I also use compute shaders to cull grass blades that don't contribute to a given frame.

![](img/grass_forces.gif)

Features
------------
1. Gravity, Wind, and Recovery Forces Calculated in Compute Shader
2. Updated Tesselation Shaders
3. Grass Blade Culling
   * Distance
   * Frustum
   * Orientation

## Grass Rendering

This project is an implementation of the paper, [Responsive Real-Time Grass Rendering for General 3D Scenes](https://www.cg.tuwien.ac.at/research/publications/2017/JAHRMANN-2017-RRTG/JAHRMANN-2017-RRTG-draft.pdf).

### Representing Grass as Bezier Curves

Grass blades are represented as Bezier curves while performing physics calculations and culling operations. 
Each Bezier curve has three control points.
* `v0`: the position of the grass blade on the geomtry
* `v1`: a Bezier curve guide that is always "above" `v0` with respect to the grass blade's up vector (explained soon)
* `v2`: a physical guide for which we simulate forces on

We also store per-blade characteristics that will help us simulate and tessellate our grass blades correctly.
* `up`: the blade's up vector, which corresponds to the normal of the geometry that the grass blade resides on at `v0`
* Orientation: the orientation of the grass blade's face
* Height: the height of the grass blade
* Width: the width of the grass blade's face
* Stiffness coefficient: the stiffness of our grass blade, which will affect the force computations on our blade

We can pack all this data into four `vec4`s, such that `v0.w` holds orientation, `v1.w` holds height, `v2.w` holds width, and 
`up.w` holds the stiffness coefficient.

![](img/blade_model.jpg)

### Tesselation Shader and Rendering Basic Grass

Without physics calculations in the compute shader, grass is rendered as straight blades after tesselation and fragment shading.

![](img/grass_straight.gif)

### Simulating Forces in Compute Shader

* Gravity

Gravity is added in the usual way: `gE = vec3(0, -9.8, 0)`

We determine the contribution of gravity with respect to the front facing direction of the blade, `f`, 
as a term called the "front gravity". Front gravity is computed as `gF = (1/4) * ||gE|| * f`.

The total gravity on the grass blade is `g = gE + gF`.

* Recovery

Recovery corresponds to the counter-force that brings our grass blade back into equilibrium. This is derived in the paper using Hooke's law.

In order to determine the recovery force, we compare the current position of `v2` to its original position before the
simulation started, `iv2`. At the beginning of our simulation, `v1` and `v2` are initialized to be a distance of the blade height along the `up` vector.

Once we have `iv2`, we can compute the recovery forces as `r = (iv2 - v2) * stiffness`.

* Wind

Wind is calculated as `vec(v_x, 0, v_z) * sin(time)` (a sinusoidal force along a particular wind direction).

* Total Force

Total force is calculated as `tF = (gravity + recovery + wind) * deltaTime`. 

* Positional Corrections

I followed section 5.2 of the paper referenced to determine the corrected final positions for `v1` and `v2` (these corrections ensure that grass doesn't pass below ground plane and maintains a proper length).

### Culling tests

* Orientation: Blades whose normals are perpendicular to the look vector are culled. We can't see these!
* Frustum: Blades that are outside the viewing frustum are culled.
* Distance: Blades that are sufficiently far from the camera (less than a pixel in size) are culled. Additionally, more blades are culled as function of distance from the camera (blades are binned into discrete intervals).

Performance
------------

## FPS Performance as a function of number of grass blades


## FPS Performance improvements using culling

Links
------------

* [Responsive Real-Time Grass Grass Rendering for General 3D Scenes](https://www.cg.tuwien.ac.at/research/publications/2017/JAHRMANN-2017-RRTG/JAHRMANN-2017-RRTG-draft.pdf)
* [CIS565 Vulkan samples](https://github.com/CIS565-Fall-2018/Vulkan-Samples)
* [Official Vulkan documentation](https://www.khronos.org/registry/vulkan/)
* [Vulkan tutorial](https://vulkan-tutorial.com/)
* [RenderDoc blog on Vulkan](https://renderdoc.org/vulkan-in-30-minutes.html)
* [Tessellation tutorial](http://in2gpu.com/2014/07/12/tessellation-tutorial-opengl-4-3/)
