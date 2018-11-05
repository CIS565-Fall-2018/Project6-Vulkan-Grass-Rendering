#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs

//inputs are from grass.vert
layout (location = 0) in vec4 tesc_v1[];
layout (location = 1) in vec4 tesc_v2[];
layout (location = 2) in vec4 tesc_up[];
layout (location = 3) in vec4 tesc_forward[];

//output to tessellation.evaluation stage

layout (location = 0) patch out vec4 tese_v1;
layout (location = 1) patch out vec4 tese_v2;
layout (location = 2) patch out vec4 tese_up;
layout (location = 3) patch out vec4 tese_forward;


void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// TODO: Write any shader outputs
	//test: pass thru
	tese_v1 = tesc_v1[0];
	tese_v2 = tesc_v2[0];
	tese_up = tesc_up[0];
	tese_forward = tesc_forward[0];


	// TODO: Set level of tesselation
    
	//tessellation on different levels depending on distance:
	//need to get the distance in projection space

	vec4 posWorld = gl_in[gl_InvocationID].gl_Position;
	posWorld.w = 1.0;
	//projection space
	posWorld = camera.proj * camera.view * posWorld;
	//projection division
	posWorld /= posWorld.w;
	//get depth in normalized z-space
	float depth = clamp(-posWorld.z, 0.0, 1.0);

	float tessLevelmin = 3.0;
	float tessLevelmax = 10.0;

	float tessLevel = mix(tessLevelmax, tessLevelmin, 0.25 * (depth * 5.0));

	gl_TessLevelInner[0] = 1.0;
	gl_TessLevelInner[1] = tessLevel;

	gl_TessLevelOuter[0] = tessLevel;
	gl_TessLevelOuter[1] = 1.0;
	gl_TessLevelOuter[2] = tessLevel;
	gl_TessLevelOuter[3] = 1.0;
}
