#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs
layout(location = 0) in vec4 outv1[];
layout(location = 1) in vec4 outv2[];
layout(location = 2) in vec4 outup[];

layout(location = 0) out vec4 v1_ES_in[];
layout(location = 1) out vec4 v2_ES_in[];
layout(location = 2) out vec4 v3_ES_in[];

void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// TODO: Write any shader outputs
	v1_ES_in[gl_InvocationID] = outv1[gl_InvocationID];
	v2_ES_in[gl_InvocationID] = outv2[gl_InvocationID];
	v3_ES_in[gl_InvocationID] = outup[gl_InvocationID];

	//gl_Position = camera.view * camera.proj * out;

	// TODO: Set level of tesselation
    gl_TessLevelInner[0] = 7.0;
    gl_TessLevelInner[1] = 2.0;
    gl_TessLevelOuter[0] = 2.0;
    gl_TessLevelOuter[1] = 3.0;
    gl_TessLevelOuter[2] = 7.0;
    gl_TessLevelOuter[3] = 2.0;
}
