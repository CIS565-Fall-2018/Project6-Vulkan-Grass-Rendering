#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

layout(location = 0) in vec4 tescV1[];
layout(location = 1) in vec4 tescV2[];
layout(location = 2) in vec4 tescUp[];
layout(location = 3) in vec4 tescBitangent[];

layout(location = 0) patch out vec4 teseV1;
layout(location = 1) patch out vec4 teseV2;
layout(location = 2) patch out vec4 teseUp;
layout(location = 3) patch out vec4 teseBitangent;

// TODO: Declare tessellation control shader inputs and outputs

void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	teseV1 = tescV1[0];
	teseV2 = tescV2[0];
	teseUp = tescUp[0];
	teseBitangent = tescBitangent[0];
	// TODO: Write any shader outputs

	// TODO: Set level of tesselation
    gl_TessLevelInner[0] = 2.0;
    gl_TessLevelInner[1] = 20.0;
    gl_TessLevelOuter[0] = 20.0;
    gl_TessLevelOuter[1] = 2.0;
	gl_TessLevelOuter[2] = 20.0;
    gl_TessLevelOuter[3] = 2.0;
}
