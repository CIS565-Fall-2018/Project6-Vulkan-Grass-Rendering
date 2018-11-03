#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// Declare fragment shader inputs
layout(location = 0) in vec4 i_pos;
layout(location = 1) in vec3 i_normal;
layout(location = 2) in vec2 i_uv;

layout(location = 0) out vec4 o_col;

void main() {
  // Lerp quad color
  vec4 cUpL = vec4(0.2, 1.0, 0.0, 1.0); // reddish
  vec4 cDownL = vec4(0.1, 0.7, 0.2, 1.0); // blueish
  vec4 cUpR = vec4(0.2, 0.9, 0.1, 1.0); // reddish
  vec4 cDownR = vec4(0.5, 0.9, 0.5, 1.0); // purple
  vec4 colHori1 = mix(cUpL, cDownL, i_uv.x);
  vec4 colHori2 = mix(cUpR, cDownR, i_uv.x);
  vec4 col = mix(colHori1, colHori2, i_uv.y);
  
  // Lambert shading
  vec3 light = normalize(vec3(1.0, 1.0, -1.0));
  vec4 ambient = vec4(0.1, 0.1, 0.1, 1.0);
  float lambert = clamp(dot(i_normal, light), 0.2, 1.0);
  o_col = clamp(ambient + col * lambert, 0.1, 1.0);
}