
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// TODO: Declare vertex shader inputs and outputs

layout(location = 0) in vec4 i_v0;
layout(location = 1) in vec4 i_v1;
layout(location = 2) in vec4 i_v2;

layout(location = 0) out vec4 o_v0;
layout(location = 1) out vec4 o_v1;
layout(location = 2) out vec4 o_v2;

out gl_PerVertex {
    vec4 gl_Position;
};

void main() {
	// TODO: Write gl_Position and any other shader outputs

	o_v0 = i_v0;
	o_v1 = i_v1;
	o_v2 = i_v2;

	gl_Position = vec4(i_v0.x, i_v0.y, i_v0.z, 1.0);
}
