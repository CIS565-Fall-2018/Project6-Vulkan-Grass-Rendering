#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODONE: Declare fragment shader inputs
layout(location = 0) in vec4 f_pos;
layout(location = 1) in vec4 f_nor;
layout(location = 2) in vec2 f_uv;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
	float lambert = clamp(dot(f_nor.xyz, vec3(0.57735, -0.57735, -0.57735)), 0.15, 1.0);
	outColor = vec4(vec3(0.376471, 0.501961, 0.219608) * lambert, 1.0);
}
