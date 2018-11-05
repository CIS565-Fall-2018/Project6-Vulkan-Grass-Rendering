#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec4 in_pos;
layout(location = 1) in vec3 in_normal;
layout(location = 2) in vec2 in_tex;

layout(location = 0) out vec4 outColor;

void main() 
{
    // TODO: Compute fragment color
	vec3 grassColor = vec3(0.23, 0.8, 0.47);
    
	// need light pos to do lamberts
	vec3 lightVec = vec3(0.0, 1.0, -1.0);
	vec3 ambient = vec3(0.1, 0.1, 0.1);
	float lambert = clamp(dot(lightVec, in_normal), 0.3, 1.0);

	vec3 shadedColor = grassColor * lambert + ambient;
	outColor = vec4(shadedColor, 1.0);
}
