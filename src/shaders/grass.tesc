#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs
layout(location = 0) in vec4 o_v0[];
layout(location = 1) in vec4 o_v1[];
layout(location = 2) in vec4 o_v2[];

layout(location = 0) out vec4 t_v0[];
layout(location = 1) out vec4 t_v1[];
layout(location = 2) out vec4 t_v2[];

void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// TODO: Write any shader outputs
	t_v0[gl_InvocationID] = o_v0[gl_InvocationID];
	t_v1[gl_InvocationID] = o_v1[gl_InvocationID];
	t_v2[gl_InvocationID] = o_v2[gl_InvocationID];

	// TODO: Set level of tesselation
    gl_TessLevelInner[0] = 5;
    gl_TessLevelInner[1] = 5;
    gl_TessLevelOuter[0] = 5;
    gl_TessLevelOuter[1] = 5;
    gl_TessLevelOuter[2] = 5;
    gl_TessLevelOuter[3] = 5;
}
