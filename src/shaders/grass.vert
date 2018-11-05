
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

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
	out_v0 = v0;
	out_v1 = v1;
	out_v2 = v2;
	out_up = up;

	// v0.w holds the orientation
	gl_Position = model * vec4(v0.xyz, 1.0);
}
