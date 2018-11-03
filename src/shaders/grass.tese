#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// Declare tessellation evaluation shader inputs and outputs
layout(location = 0) in vec4 i_v0[];
layout(location = 1) in vec4 i_v1[];
layout(location = 2) in vec4 i_v2[];

layout(location = 0) out vec4 o_pos;
layout(location = 1) out vec3 o_normal;
layout(location = 2) out vec2 o_tex;

void main() {
  float u = gl_TessCoord.x;
  float v = gl_TessCoord.y;
  o_tex = vec2(u, v);

  vec4 v0 = i_v0[0];
  vec4 v1 = i_v1[0];
  vec4 v2 = i_v2[0];
  float orient = v0.w;
  float width = v2.w;

  // Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
  // Source: tutorial
  vec3 a = mix(v0.xyz, v1.xyz, v);
  vec3 b = mix(v1.xyz, v2.xyz, v);
  vec3 c = mix(a, b, v);

  // Compute normal
  vec3 hypothenuse = vec3(sin(orient), 0.0, cos(orient));
  vec3 verticalGrass = normalize(b - a);
  o_normal = normalize(cross(verticalGrass, hypothenuse)); // lerped normal along face

 
  vec3 c0 = c - width * hypothenuse;
  vec3 c1 = c + width * hypothenuse;
  float t = u - u * v + 0.5 * v;
  vec3 pos = mix(c0, c1, t);
  o_pos = camera.proj * camera.view * vec4(pos, 1.0);
  gl_Position = o_pos;
}