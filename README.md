Vulkan Grass Rendering
======================

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 6**

* Eric Chiu
* Tested on: Macbook Pro (Retina, 15-inch, Mid 2015), OS X El Capitan 10.11.6, 2.5 GHz Intel Core i7, AMD Radeon R9 M370X 2048 MB


## Result

![](img/vulkan-grass.gif)

## Description

This project implements different types of GPU rendering using Javascript, WebGL, and GPU hardware. Features include forward rendering, forward plus rendering, clustered deferred rendering, lambert shading, phong shading, toon shading, iridescent shading, and sobel shading.

## Performance Analysis

The following chart shows the frames per second of the rendering as the number of lights increase for forward, forward plus, and clustered deferred rendering. Clearly, clustered deferred rendering is faster than forward and forward plus rendering, and forward plus rendering is faster than forward rendering. This is because forward plus rendering categorizes lights into clusters, and the fragment shader will only need to check lights that influence the cluster the geometry fragment is in. Clustered deferred rendering takes this a step further and introduces extra buffers that store 2D textures of depth, normals, and color information. Lighting will then be applied to the 2D textures instead of every geometry to produce the final render. This means that the lighting loop will only have to be run once rather than every geometry.

![](./img/graph-1.png)

The following chart shows the frames per second of the rendering as the number of lights increase for default clustered deferred rendering, and optimized deferred rendering using 2-component normals. Since normals will always have a magnitude of 1, we can compress the normal's x and y components into two vec4s by multiplying it by the view matrix before packing, and then multiplying these vec4s by the inverse view matrix in the shader to uncompress them. The performance difference is not super significant but using fewer buffers clearly improves performance. I believe that the difference in frames per second between the default and optimized implementations will remain linear as the number of lights increase.

![](./img/graph-2.png)