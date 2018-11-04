#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// Declare tessellation control shader inputs and outputs
layout(location = 0) in vec4 in_v0[];
layout(location = 1) in vec4 in_v1[];
layout(location = 2) in vec4 in_v2[];
layout(location = 3) in vec4 in_Up[];

layout(location = 0) out vec4 out_v0[];
layout(location = 1) out vec4 out_v1[];
layout(location = 2) out vec4 out_v2[];

void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	out_v0[gl_InvocationID] = in_v0[gl_InvocationID];
	out_v1[gl_InvocationID] = in_v1[gl_InvocationID];
	out_v2[gl_InvocationID] = in_v2[gl_InvocationID];

	mat4 inverseTransform = inverse(camera.view);
	vec3 c = mat3(inverseTransform) * (-camera.view[3].xyz);
	vec3 up = in_Up[gl_InvocationID].xyz;
	vec3 v0 = in_v0[gl_InvocationID].xyz;
	float distanceFromGeom = length(v0 - c - up * (dot(v0 - c, up)));

	float minLevel = 2.0;
	float maxLevel = 15.0;
	
	float mixRatio = distanceFromGeom / 10.0;
	float currLevel = mix(maxLevel, minLevel, clamp(mixRatio, 0.0, 1.0));

	// Test Tesselation
	gl_TessLevelInner[0] = 2.0; // Horizontal
	gl_TessLevelInner[1] = 2.0; // Vertical
	gl_TessLevelOuter[0] = currLevel; // edge 0~3
	gl_TessLevelOuter[1] = 1.0; // edge 3~2
	gl_TessLevelOuter[2] = currLevel; // edge 2~1
	gl_TessLevelOuter[3] = 1.0; // edge 1~0

}
