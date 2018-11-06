#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs

layout (location = 0) in vec4 tesc_v1[];
layout (location = 1) in vec4 tesc_v2[];
layout (location = 2) in vec4 tesc_up[];
layout (location = 3) in vec4 tesc_f[];

layout(location = 0) patch out vec4 tese_v1;
layout(location = 1) patch out vec4 tese_v2;
layout(location = 2) patch out vec4 tese_up;
layout(location = 3) patch out vec4 tese_f;

void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// TODO: Write any shader outputs
	tese_v1 = tesc_v1[0];
	tese_v2 = tesc_v2[0];
	tese_up = tesc_up[0];
	tese_f = tesc_f[0];

	// TODO: Set level of tesselation
     gl_TessLevelInner[0] = 1.0;
     gl_TessLevelInner[1] = 8.0;
     gl_TessLevelOuter[0] = 8.0;
     gl_TessLevelOuter[1] = 1.0;
     gl_TessLevelOuter[2] = 8.0;
     gl_TessLevelOuter[3] = 1.0;
}
