
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// TODO: Declare vertex shader inputs and outputs

layout (location = 0) in vec4 v0;
layout (location = 1) in vec4 v1;
layout (location = 2) in vec4 v2;
layout (location = 3) in vec4 up;

layout (location = 0) out vec3 v_w;
layout (location = 1) out vec4 v_v1;
layout (location = 2) out vec4 v_v2;
layout (location = 3) out vec4 v_up;



out gl_PerVertex {
    vec4 gl_Position;
};

void main() {
	// Write gl_Position and any other shader outputs

	vec4 v = model * vec4(v1.xyz, 1.0);
	v_v1 = vec4(v.xyz, v1.w);

	v = model * vec4(v2.xyz, 1.0);
	v_v2 = vec4(v.xyz, v2.w);

	v_up = up;

	// use direction to get normal vector of face
	float o = v0.w;
	float x = cos(o);
	float z = sin(o);
	float y = -(up.x * x + up.z * z) / up.y;

	vec3 v_norm = normalize(vec3(x,y,z));

	// get vector along width of blade
	v_w = normalize(cross(normalize(up.xyz), v_norm));

	// save v0 to the position
	gl_Position = model * vec4(v0.xyz, 1.0);
}
