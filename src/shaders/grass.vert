
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// TODO: Declare vertex shader inputs and outputs
layout(location = 0) in vec4 v0;
layout(location = 1) in vec4 v1;
layout(location = 2) in vec4 v2;
layout(location = 3) in vec4 up;

layout(location = 0) out vec4 out_v0;
layout(location = 1) out vec4 out_v1;
layout(location = 2) out vec4 out_v2;
layout(location = 3) out vec4 out_up;

out gl_PerVertex 
{
    vec4 gl_Position;
};

void main() 
{
	// TODO: Write gl_Position and any other shader outputs
	out_v0 = v0;
	out_v1 = v1;
	out_v2 = v2;
	out_up = up;

	// v0.w holds the orientation
	gl_Position = model * vec4(v0.xyz, 1.0);
	//gl_Position = vec4(v0.xyz, 1.0);
}
