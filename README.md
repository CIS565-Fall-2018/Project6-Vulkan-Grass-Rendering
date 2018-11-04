Vulkan Grass Rendering
========================

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 6**

* Xiao Zhang
  * [LinkedIn](https://www.linkedin.com/in/xiao-zhang-674bb8148/)
* Tested on: Windows 10, i7-7700K @ 4.20GHz 16.0GB, GTX 1080 15.96GB (my own PC)

Overview 
======================

![](img/0.gif)

Analysis 
======================
* Compute shader WORKGROUP_SIZE is set to (32, 0, 0).

* Rendering time is measured in fps, so higher is better.

* Maximum distance for distance culling is 50.

* Frustum culling tolerance is 0.9.

* Orientation culling threshold is 0.2.

---

## 1. 2^13 grass blades

### overview

![](img/a.JPG)

### analysis

.

### images

|      distance       |            far          |            mid          |           near           |
|:-------------------:|:-----------------------:|:-----------------------:|:------------------------:|
|    culling off      |![](img/1/1_aoff_far.JPG)|![](img/1/1_aoff_mid.JPG)|![](img/1/1_aoff_near.JPG)|
| orientation culling |![](img/1/1_o_far.JPG)   |![](img/1/1_o_mid.JPG)   |![](img/1/1_o_near.JPG)   |
|   frustum culling   |![](img/1/1_f_far.JPG)   |![](img/1/1_f_mid.JPG)   |![](img/1/1_f_near.JPG)   |
|   distance culling  |![](img/1/1_d_far.JPG)   |![](img/1/1_d_mid.JPG)   |![](img/1/1_d_near.JPG)   |
|   all culling on    |![](img/1/1_aon_far.JPG) |![](img/1/1_aon_mid.JPG) |![](img/1/1_aon_near.JPG) |

---

## 2. 2^17 grass blades

### overview

![](img/b.JPG)

### analysis

.

### images

|      distance       |            far          |            mid          |           near           |
|:-------------------:|:-----------------------:|:-----------------------:|:------------------------:|
|    culling off      |![](img/2/2_aoff_far.JPG)|![](img/2/2_aoff_mid.JPG)|![](img/2/2_aoff_near.JPG)|
| orientation culling |![](img/2/2_o_far.JPG)   |![](img/2/2_o_mid.JPG)   |![](img/2/2_o_near.JPG)   |
|   frustum culling   |![](img/2/2_f_far.JPG)   |![](img/2/2_f_mid.JPG)   |![](img/2/2_f_near.JPG)   |
|   distance culling  |![](img/2/2_d_far.JPG)   |![](img/2/2_d_mid.JPG)   |![](img/2/2_d_near.JPG)   |
|   all culling on    |![](img/2/2_aon_far.JPG) |![](img/2/2_aon_mid.JPG) |![](img/2/2_aon_near.JPG) |

---

## 1. 2^21 grass blades

### overview

![](img/c.JPG)

### analysis

. 

### images

|      distance       |            far          |            mid          |           near           |
|:-------------------:|:-----------------------:|:-----------------------:|:------------------------:|
|    culling off      |![](img/3/3_aoff_far.JPG)|![](img/3/3_aoff_mid.JPG)|![](img/3/3_aoff_near.JPG)|
| orientation culling |![](img/3/3_o_far.JPG)   |![](img/3/3_o_mid.JPG)   |![](img/3/3_o_near.JPG)   |
|   frustum culling   |![](img/3/3_f_far.JPG)   |![](img/3/3_f_mid.JPG)   |![](img/3/3_f_near.JPG)   |
|   distance culling  |![](img/3/3_d_far.JPG)   |![](img/3/3_d_mid.JPG)   |![](img/3/3_d_near.JPG)   |
|   all culling on    |![](img/3/3_aon_far.JPG) |![](img/3/3_aon_mid.JPG) |![](img/3/3_aon_near.JPG) |

---
