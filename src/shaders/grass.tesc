#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs
// Blade info in and out
layout(location = 0) in vec4 v0[];
layout(location = 1) in vec4 v1[];
layout(location = 2) in vec4 v2[];
layout(location = 3) in vec4 up[];

layout(location = 0) out vec4 v0_out[];
layout(location = 1) out vec4 v1_out[];
layout(location = 2) out vec4 v2_out[];
layout(location = 3) out vec4 up_out[];

void main() {
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// TODO: Write any shader outputs
	v0_out[gl_InvocationID] = v0[gl_InvocationID];
	v1_out[gl_InvocationID] = v1[gl_InvocationID];
	v2_out[gl_InvocationID] = v2[gl_InvocationID];
	up_out[gl_InvocationID] = up[gl_InvocationID];

	// TODO: Set level of tesselation
	// Tesselation parameters for creating natural-looking grass
	gl_TessLevelInner[0] = 2.0;
	gl_TessLevelInner[1] = 5.0;
	gl_TessLevelOuter[0] = 5.0;
	gl_TessLevelOuter[1] = 2.0;
	gl_TessLevelOuter[2] = 5.0;
	gl_TessLevelOuter[3] = 2.0;
}