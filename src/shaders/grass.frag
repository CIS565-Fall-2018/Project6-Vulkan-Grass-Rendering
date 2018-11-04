#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec4 normal;
layout(location = 0) out vec3 outColor;

void main() {
    // TODO: Compute fragment color

	vec3 light_green = vec3(0.0, 0.93, 0.0);
	vec3 dark_green = vec3(0.0, 0.55, 0.20);

    outColor = vec3(normal.w * light_green + (1.0 - normal.w) * dark_green);
}
