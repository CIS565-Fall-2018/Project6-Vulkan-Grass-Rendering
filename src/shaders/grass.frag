#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec3 pos;
layout(location = 1) in vec3 nor;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
	const vec3 lightPosition = vec3(1.0f, 3.0f, -1.0f);
	vec3 lightDirection = normalize(pos - lightPosition);

	vec3 ambientColor = vec3(1.0f, 1.0f, 1.0f);
	vec3 specColor = vec3(1.0f, 1.0f, 1.0f);
	vec3 grassColor = vec3(0.01f, 0.325f, 0.01f);

	vec3 L = -lightDirection;   
    vec3 E = normalize(-pos);
	vec3 N = normalize(nor);
	vec3 R = normalize(-reflect(L, N));
	float specIntensity = pow(max(dot(R, E), 0.0f), 32.0f);

	float ambientIntensity = 0.15f;
	float diffuseIntensity = clamp(dot(nor, lightDirection), 0.3f, 1.0f);

	vec3 accumulatedColor = ambientIntensity * ambientColor + diffuseIntensity * grassColor + specIntensity * specColor;
	accumulatedColor = clamp(accumulatedColor, 0.0f, 1.0f);
    outColor = vec4(accumulatedColor, 1.0f);
}