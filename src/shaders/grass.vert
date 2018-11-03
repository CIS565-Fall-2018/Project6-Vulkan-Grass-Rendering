
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// Declare vertex shader inputs and outputs
// inputs
layout(location = 0) in vec4 vs_v0;
layout(location = 1) in vec4 vs_v1;
layout(location = 2) in vec4 vs_v2;
layout(location = 3) in vec4 vs_up;
// outputs
layout(location = 0) out vec4 tesc_v1;
layout(location = 1) out vec4 tesc_v2;
layout(location = 2) out vec4 tesc_up;
layout(location = 3) out vec4 tesc_bitan;

out gl_PerVertex {
    vec4 gl_Position;
};

void main() {
	// Write gl_Position and any other shader outputs
	gl_Position = model * vec4(vec3(vs_v0), 1.0);
	tesc_v1 = model * vec4(vec3(vs_v1), 1.0);
	tesc_v2 = model * vec4(vec3(vs_v2), 1.0);
	tesc_up = normalize(model * vec4(vec3(vs_up), 0.0));


	float PI_DIV_TWO = 1.57079632679;
	float direction = vs_v0.w - PI_DIV_TWO;
	tesc_bitan = vec4(
		vec3(normalize(model * vec4(cos(direction), 0, sin(direction), 0))),
		vs_v2.w
	);
}
