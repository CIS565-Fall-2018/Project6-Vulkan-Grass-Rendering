#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs
layout (location = 0) in vec4 vertex_v1[];
layout (location = 1) in vec4 vertex_v2[];
layout (location = 2) in vec4 vertex_up[];
layout (location = 3) in vec4 vertex_data[];

layout (location = 0) patch out vec4 tesc_v1;
layout (location = 1) patch out vec4 tesc_v2;
layout (location = 2) patch out vec4 tesc_up;
layout (location = 3) patch out vec4 tesc_data; 

void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// TODO: Write any shader outputs
    tesc_v1 = vertex_v1[0];
    tesc_v2 = vertex_v2[0];
    tesc_up = vertex_up[0];
    tesc_data = vertex_data[0];

	// TODO: Set level of tesselation
    gl_TessLevelInner[0] = 2;
    gl_TessLevelInner[1] = 6;
    gl_TessLevelOuter[0] = 5; // left
    gl_TessLevelOuter[1] = 5; // top
    gl_TessLevelOuter[2] = 5; // right
    gl_TessLevelOuter[3] = 5; // bottom
}
