#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs

layout (location = 0) in vec4 v_norm[];
layout (location = 1) in vec4 v_v1[];
layout (location = 2) in vec4 v_v2[];
layout (location = 3) in vec4 v_up[];

layout (location = 0) patch out vec4 t_norm;
layout (location = 1) patch out vec4 t_v1;
layout (location = 2) patch out vec4 t_v2;
layout (location = 3) patch out vec4 t_up;

void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// TODO: Write any shader outputs
	t_norm = v_norm[0];
	t_v1 = v_v1[0];
	t_v2 = v_v2[0];
	t_up = v_up[0];

	// TODO: Set level of tesselation
    gl_TessLevelInner[0] = 1.0;
    gl_TessLevelInner[1] = 5.0;
    gl_TessLevelOuter[0] = 5.0;
    gl_TessLevelOuter[1] = 1.0;
    gl_TessLevelOuter[2] = 5.0;
    gl_TessLevelOuter[3] = 1.0;
}
