#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec4 pos;
layout(location = 1) in vec4 nor;
layout(location = 2) in vec2 uv;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
	vec3 lightDir = normalize(vec3(1,1,1));

	vec3 bottomColor = (1.0/255.0) * vec3(18, 181, 83); 
	vec3 topColor    = (1.0/255.0) * vec3(66, 244, 137);

    outColor = vec4(mix(bottomColor, topColor, uv.y), 1.0);
}
