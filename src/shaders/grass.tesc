#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs
layout(location = 0) in vec4 tescV1[];
layout(location = 1) in vec4 tescV2[];
layout(location = 2) in vec4 tescUp[];
layout(location = 3) in vec3 tescTangent[];

layout(location = 0) out vec4 teseV1[];
layout(location = 1) out vec4 teseV2[];
layout(location = 2) out vec4 teseUp[];
layout(location = 3) out vec3 teseTangent[];


void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// TODO: Write any shader output
	teseV1[gl_InvocationID] = tescV1[gl_InvocationID];
	teseV2[gl_InvocationID] = tescV2[gl_InvocationID];
	teseUp[gl_InvocationID] = tescUp[gl_InvocationID];
    teseTangent[gl_InvocationID] = tescTangent[gl_InvocationID];

	// TODO: Set level of tesselation
    gl_TessLevelInner[0] = 3.0f;
	gl_TessLevelInner[1] = 3.0f;

    gl_TessLevelOuter[0] = 3.0f;
    gl_TessLevelOuter[1] = 3.0f;
    gl_TessLevelOuter[2] = 3.0f;
	gl_TessLevelOuter[3] = 3.0f;
}