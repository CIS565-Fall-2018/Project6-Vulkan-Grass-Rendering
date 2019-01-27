#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout(location = 0) in vec4 v1_ES_in[];
layout(location = 1) in vec4 v2_ES_in[];
layout(location = 2) in vec4 v3_ES_in[];

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	vec3 v0 = gl_in[0].gl_Position.xyz;
	vec3 v1 = v1_ES_in[0].xyz;
	vec3 v2 = v2_ES_in[0].xyz;
	vec3 t1 = v3_ES_in[0].xyz;

	vec3 a = v0 + v * (v1 - v0);
	vec3 b = v1 + v * (v2 - v1);
	vec3 c = a + v * (b - a);
	vec3 c0 = c - t1;
	vec3 c1 = c + t1;
	vec3 t0 = (b - a) / (length(b - a));
	vec3 n = cross(t0, t1) / (length(cross(t0, t1)));

	// calculate interpolation parameter for triangle tip
	float t = 0.5 + (u - 0.5) * (1 - (max(v - 0.75, 0)/(1-0.75)));

    gl_Position = camera.proj * camera.view * vec4(mix(c0, c1, t), 1.0);
}
