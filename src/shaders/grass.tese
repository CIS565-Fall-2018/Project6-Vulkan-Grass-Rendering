#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout(location = 0) in vec4 t_v0[];
layout(location = 1) in vec4 t_v1[];
layout(location = 2) in vec4 t_v2[];

layout(location = 0) out vec4 normal;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	vec3 v0 = t_v0[0].xyz;
	vec3 v1 = t_v1[0].xyz;
	vec3 v2 = t_v2[0].xyz;

	float width = t_v2[0].w;
	float direction = t_v0[0].w;
	vec3 t1 = vec3(cos(direction), 0.0, sin(direction));
	
	float threshold = 0.9;

	//perform the same as described in paper

	vec3 a = v0 + v * (v1 - v0);
	vec3 b = v1 + v * (v2 - v1);
	vec3 c = a + v * (b - a);

	vec3 c0 = c - width * t1;
	vec3 c1 = c + width * t1;

	normal.xyz = normalize(b - a);
	normal.w = v;

	float t = 0.5 + (u - 0.5) * (1.0 - (max(v - threshold, 0.0) / (1.0 - threshold)));
	vec3 position = (1.0 - t) * c0 + t * c1;
	
	//transfer to world space
	gl_Position = camera.proj * camera.view * vec4(position, 1.0);
}
