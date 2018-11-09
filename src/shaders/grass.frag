#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0)in vec4 pos;
layout(location = 1)in vec3 nor;
layout(location = 2)in float fs_v;



layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
	vec3 lightDir = normalize(vec3(1, 1, 1));

	vec3 top = vec3(0.0, 1.0, 0.0);
	vec3 bottom = vec3(0.1, 0.2, 0.1);
	outColor = vec4(mix(bottom, top, clamp(fs_v, 0.0, 1.0)), 1);

    // outColor = vec4(0.2, 0.7, 0.2, 1.0);
	// outColor = vec4(1.0);

     //outColor = vec4(0.2, 0.7, 0.2, 1.0) * dot(lightDir, vec3(1, 1, 0));

}
