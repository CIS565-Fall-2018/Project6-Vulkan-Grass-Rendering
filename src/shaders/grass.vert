
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// Declare vertex shader inputs and outputs
layout(location = 0) in vec4 i_v0;
layout(location = 1) in vec4 i_v1;
layout(location = 2) in vec4 i_v2;
layout(location = 3) in vec4 i_bladeUp;

layout(location = 0) out vec4 o_v0;
layout(location = 1) out vec4 o_v1;
layout(location = 2) out vec4 o_v2;
layout(location = 3) out vec4 o_bladeUp;

out gl_PerVertex {
    vec4 gl_Position;
};

void main() {
	// Write gl_Position and blade parameters
	o_v0 = 	i_v0;
	o_v1 =	i_v1;
	o_v2 =	i_v2;
	o_bladeUp =	 i_bladeUp;
	gl_Position = vec4(o_v0.xyz, 1.0);
}