#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs

layout(location = 0) in vec4 v0_CS_IN[];
layout(location = 1) in vec4 v1_CS_IN[];
layout(location = 2) in vec4 v2_CS_IN[];
layout(location = 3) in vec4 up_CS_IN[];

layout(location = 0) out vec4 v0_ES_IN[];
layout(location = 1) out vec4 v1_ES_IN[];
layout(location = 2) out vec4 v2_ES_IN[];
layout(location = 3) out vec4 up_ES_IN[];

void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// TODO: Write any shader outputs
	// v0_ES_IN[0] = v0_CS_IN[0];
	// v1_ES_IN[0] = v1_CS_IN[0];
	// v2_ES_IN[0] = v2_CS_IN[0];
	// up_ES_IN[0] = up_CS_IN[0];
	//  '[]' : tessellation-control per-vertex output l-value must be indexed with gl_InvocationID
	v0_ES_IN[gl_InvocationID] = v0_CS_IN[gl_InvocationID];
	v1_ES_IN[gl_InvocationID] = v1_CS_IN[gl_InvocationID];
	v2_ES_IN[gl_InvocationID] = v2_CS_IN[gl_InvocationID];
	up_ES_IN[gl_InvocationID] = up_CS_IN[gl_InvocationID];

	// TODO: Set level of tesselation
    gl_TessLevelInner[0] = 4;
    gl_TessLevelInner[1] = 4;
    gl_TessLevelOuter[0] = 4;
    gl_TessLevelOuter[1] = 4;
    gl_TessLevelOuter[2] = 4;
    gl_TessLevelOuter[3] = 4;
}
