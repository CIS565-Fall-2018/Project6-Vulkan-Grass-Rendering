#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs

layout(location = 0) in vec4 norm;
layout(location = 1) in vec2 f_uv;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
	vec4 l_green = vec4(0.1, 0.9, 0.1, 1.0);
	vec4 d_green = vec4(9.0/255.0, 51.0/255.0, 0.0, 1.0);

	vec4 grey = vec4 (0.75,0.75,0.75,1.0);
	vec4 white = vec4(1.0);

	float v = f_uv.y;
	vec4 c1 = (1-v)*d_green + v * l_green;

	float u = 2 * abs(f_uv.x - 0.5);
	vec4 c2 = (1-u)*grey + u * white;

    outColor = (c1 * c2);
}
