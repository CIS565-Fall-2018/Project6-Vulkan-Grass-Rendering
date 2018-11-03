#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// DONE: Declare fragment shader inputs
layout(location = 0) in vec2 fs_uv;
layout(location = 1) in vec3 fs_pos;
layout(location = 2) in vec3 fs_nor;

layout(location = 0) out vec4 outColor;

void main() {
    // DONE: Compute fragment color

	// lambert
	vec3 LIGHT_DIRECTION = vec3(0.5, -0.5, -0.5);
	float lambert_effect = clamp(dot(fs_nor, LIGHT_DIRECTION), 0.2, 1.0);
	vec4 color_by_lambert = vec4(vec3(0.1, 0.9, 0.2) * lambert_effect, 1.0);

	// uvs
	vec4 color_by_uv = vec4(fs_uv.x, fs_uv.y, 0, 1);

    outColor = mix(color_by_uv, color_by_lambert, 1);
}
