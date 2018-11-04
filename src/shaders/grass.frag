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
	vec3 grassColor = vec3(0.0, 1.0, 0.0);
    
	// need light pos to do lamberts
	outColor = vec4(grassColor, 1.0);
}
