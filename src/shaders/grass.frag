#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec4 pos;
layout(location = 1) in vec2 uv;
layout(location = 2) in vec3 norm;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
	
	float ambientTerm = 0.2;
	vec3 color1 = vec3(0.2, 0.5, 0.1);
	vec3 color2 = vec3(0.6, 0.8, 0.3);
	vec3 color = mix(color1, color2, uv.y);
	vec3 light_pos = vec3(5.f, 5.f, 5.f);
	float light_dist = distance(light_pos, pos.xyz);
	vec3 L = (light_pos - pos.xyz) / light_dist;
	float lambertTerm = dot(L, norm);
	lambertTerm = max(lambertTerm , 0.f);
    outColor = vec4((lambertTerm + ambientTerm) * color, 1.0);
}
