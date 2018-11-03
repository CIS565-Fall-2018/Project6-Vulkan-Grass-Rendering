#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// Declare tessellation control shader inputs and outputs
layout(location = 0) in vec4 i_v0[];
layout(location = 1) in vec4 i_v1[];
layout(location = 2) in vec4 i_v2[];
layout(location = 3) in vec4 i_bladeUp[];

layout(location = 0) out vec4 o_v0[];
layout(location = 1) out vec4 o_v1[];
layout(location = 2) out vec4 o_v2[];

void main() {
  vec4 v0_originModel = gl_in[gl_InvocationID].gl_Position;
  gl_out[gl_InvocationID].gl_Position = v0_originModel; // tesselation doesn't change v0
  
  // write out blade parameters
  o_v0[gl_InvocationID] = i_v0[gl_InvocationID];
  o_v1[gl_InvocationID] = i_v1[gl_InvocationID];
  o_v2[gl_InvocationID] = i_v2[gl_InvocationID];
  vec4 bladeUp = i_bladeUp[gl_InvocationID];

  // tesselation control
  mat4 vp = camera.proj * camera.view;
  vec4 cameraPos = vp * vec4(0.0, 0.0, 1.0, 0.0);
  vec4 v0_originWorld = (vp * v0_originModel);
  v0_originWorld /= v0_originWorld.w;
  vec4 bladeUpWorld = vp * bladeUp;
  bladeUpWorld /= bladeUpWorld.w;
  float d_proj = length(v0_originWorld.xyz - cameraPos.xyz - bladeUpWorld.xyz * dot(v0_originWorld.xyz - cameraPos.xyz, bladeUpWorld.xyz));
  int penalty = 10 - int(d_proj); // the farther away a leaf is, the less detail it will get

  // set tess parameters (levels) based on depth
  int horizontal = min(penalty + 4, 6);
  int vertical = min(penalty + 6, 8);

  // tesselation levels for inner edges
  gl_TessLevelInner[0] = horizontal;
  gl_TessLevelInner[1] = vertical;

  // tesselation levels for outer edges
  gl_TessLevelOuter[0] = vertical;
  gl_TessLevelOuter[1] = horizontal;
  gl_TessLevelOuter[2] = vertical;
  gl_TessLevelOuter[3] = horizontal;
}