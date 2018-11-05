#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec4 position;
layout(location = 1) in vec3 normal;
layout(location = 2) in vec2 uv;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
	vec3 lightdir = vec3(1.0, 1.0, 1.0);

	vec3 col1 = vec3(0.0, 1.0, 0.0);
	vec3 col2 = vec3(0.1, 0.2, 0.1);
	vec3 col = mix(col2, col1, uv.y);

    outColor = vec4(col , 1.0);
}
