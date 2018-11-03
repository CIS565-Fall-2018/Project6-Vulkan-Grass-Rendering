#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// Declare tessellation control shader inputs and outputs
// inputs
layout(location = 0) in vec4 tesc_v1[];
layout(location = 1) in vec4 tesc_v2[];
layout(location = 2) in vec4 tesc_up[];
layout(location = 3) in vec4 tesc_bitan[];
// outputs
layout(location = 0) patch out vec4 tese_v1;
layout(location = 1) patch out vec4 tese_v2;
layout(location = 2) patch out vec4 tese_up;
layout(location = 3) patch out vec4 tese_bitan;

void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// Write any shader outputs
	tese_v1 = tesc_v1[gl_InvocationID];
	tese_v2 = tesc_v2[gl_InvocationID];
	tese_up = tesc_up[gl_InvocationID];
	tese_bitan = tesc_bitan[gl_InvocationID];

	// Set level of tesselation
    gl_TessLevelInner[0] = 1; // num horizontal slices
    gl_TessLevelInner[1] = 2; // num vertical slices
    gl_TessLevelOuter[0] = 2; // num left edge slices
    gl_TessLevelOuter[1] = 1; // num top edge slices
    gl_TessLevelOuter[2] = 2; // num right edge slices
    gl_TessLevelOuter[3] = 1; // num bottom edge slices
}
