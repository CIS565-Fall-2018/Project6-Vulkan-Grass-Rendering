
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// TODO: Declare vertex shader inputs and outputs

layout(location = 0) in vec4 vsV0;
layout(location = 1) in vec4 vsV1;
layout(location = 2) in vec4 vsV2;
layout(location = 3) in vec4 vsUp;

layout(location = 0) out vec4 tescV1;
layout(location = 1) out vec4 tescV2;
layout(location = 2) out vec4 tescUp;
layout(location = 3) out vec4 tescBitangent;

out gl_PerVertex {
    vec4 gl_Position;
};

void main() {
	gl_Position = model*vsV0;
	vec4 world_v1 = model * vec4(vsV1.xyz,1.0);
	world_v1 /= world_v1.w;
	vec4 world_v2 = model * vec4(vsV2.xyz,1.0);
	world_v2 /= world_v2.w;
 	tescV1 = vec4(world_v1.xyz, vsV1.w);
	tescV2 = vec4(world_v2.xyz, vsV2.w);
	tescUp.xyz = normalize(vsUp.xyz);
 	float sin_theta = sin(vsV0.w), cos_theta = cos(vsV0.w);
	tescBitangent.xyz = normalize(vec3(sin_theta, 0, cos_theta)); 
	tescBitangent.w = vsUp.w;

}
