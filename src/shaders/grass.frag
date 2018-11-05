#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs

layout(location = 0) in vec4 pos;
layout(location = 1) in vec3 nor;
layout(location = 2) in vec3 forward;
layout(location = 3) in vec2 uv;


layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color

	vec3 topCol = vec3(0.50, 0.99, 0.43);
	vec3 botCol = vec3(0.60, 0.99, 0.60);
	//interpolate between bottom color and top color
	vec3 inter_Col = mix(botCol, topCol, uv.y);

	//sun direction
	vec3 lightDir = vec3(-4.0, 9.0, 3.0);
	lightDir = normalize(lightDir);
	float lambertian = dot(nor, lightDir);
	lambertian = clamp(lambertian, 0.0,1.0) + 0.40;

    outColor = vec4(inter_Col * lambertian, 1.0);
}
