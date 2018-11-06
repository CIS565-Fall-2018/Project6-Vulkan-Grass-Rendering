#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec3 nor;
layout(location = 1) in vec2 uv;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
	vec3 lightDir = normalize(vec3(1.0, 0.0, 1.0));

	vec3 tipColor = vec3(0.8, 0.8, 0.3);
	vec3 baseColor = vec3(0.2, 0.6, 0.2);
	vec3 color = mix(baseColor, tipColor, uv.y);
	outColor = vec4(color * max(dot(lightDir, nor),0.0), 1.0);
}
