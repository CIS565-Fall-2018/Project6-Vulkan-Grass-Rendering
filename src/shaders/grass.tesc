#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// Declare tessellation control shader inputs and outputs
layout(location = 0) in vec4 outv1[];
layout(location = 1) in vec4 outv2[];
layout(location = 2) in vec4 outup[];

layout(location = 0) out vec4 v1_ES_in[];
layout(location = 1) out vec4 v2_ES_in[];
layout(location = 2) out vec4 v3_ES_in[];

void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[0].gl_Position;

	v1_ES_in[gl_InvocationID] = outv1[gl_InvocationID];
	v2_ES_in[gl_InvocationID] = outv2[gl_InvocationID];
	v3_ES_in[gl_InvocationID] = outup[gl_InvocationID];

	// Set level of tessellation based on distance away
	float LOD = 2.0 + ((40.0 - length(camera.view * vec4(gl_in[0].gl_Position.xyz, 1.0))) / 10.0);

    gl_TessLevelInner[0] = LOD;
    gl_TessLevelInner[1] = LOD;
    gl_TessLevelOuter[0] = LOD;
    gl_TessLevelOuter[1] = LOD;
    gl_TessLevelOuter[2] = LOD;
    gl_TessLevelOuter[3] = LOD;
}
