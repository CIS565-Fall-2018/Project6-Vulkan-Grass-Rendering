
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// TODONE: Declare vertex shader inputs and outputs
layout(location = 0) in vec4 v0;
layout(location = 1) in vec4 v1;
layout(location = 2) in vec4 v2;
layout(location = 3) in vec4 up;

layout(location = 0) out vec4 t_v1;
layout(location = 1) out vec4 t_v2;
layout(location = 2) out vec4 t_up;
layout(location = 3) out vec4 t_bitan;

out gl_PerVertex {
    vec4 gl_Position;
};

void main() {
	// TODONE: Write gl_Position and any other shader outputs
	gl_Position = model * vec4(v0.xyz, 1.0);
	t_v1 = model * vec4(v1.xyz, 1.0);
	t_v2 = model * vec4(v2.xyz, 1.0);
	t_up = model * vec4(up.xyz, 1.0);
	t_bitan = normalize(model * vec4(cos(v0.w - 1.570796), 0, sin(v0.w - 1.570796), 0));
	t_bitan.w = v2.w;
}
