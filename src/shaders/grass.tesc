#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODONE: Declare tessellation control shader inputs and outputs
layout(location = 0) in vec4 t_v1[];
layout(location = 1) in vec4 t_v2[];
layout(location = 2) in vec4 t_up[];
layout(location = 3) in vec4 t_bitan[];

layout(location = 0) patch out vec4 t2_v1;
layout(location = 1) patch out vec4 t2_v2;
layout(location = 2) patch out vec4 t2_up;
layout(location = 3) patch out vec4 t2_bitan;

void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// TODONE: Write any shader outputs
	t2_v1 = t_v1[gl_InvocationID];
	t2_v2 = t_v2[gl_InvocationID];
	t2_up = t_up[gl_InvocationID];
	t2_bitan = t_bitan[gl_InvocationID];

	// TODONE: Set level of tesselation
    gl_TessLevelInner[0] = 2;
    gl_TessLevelInner[1] = 4;
    gl_TessLevelOuter[0] = 4;
    gl_TessLevelOuter[1] = 2;
    gl_TessLevelOuter[2] = 4;
    gl_TessLevelOuter[3] = 2;
}
