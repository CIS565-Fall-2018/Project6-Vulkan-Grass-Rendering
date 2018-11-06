#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODONE: Declare tessellation evaluation shader inputs and outputs
layout(location = 0) patch in vec4 v1;
layout(location = 1) patch in vec4 v2;
layout(location = 2) patch in vec4 up;
layout(location = 3) patch in vec4 bitan;

layout(location = 0) out vec4 f_pos;
layout(location = 1) out vec4 f_nor;
layout(location = 2) out vec2 f_uv;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODONE: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
	vec4 v0 = gl_in[0].gl_Position;
	vec4 a = v0 + v * (v1 - v0);
	vec4 b = v1 + v * (v2 - v1);
	vec4 c = a + v * (b - a);
	vec4 c0 = c - 0.15 * bitan;
	vec4 c1 = c + 0.15 * bitan;
	vec4 t0 = normalize(b - a);

	//float t = 0.5 + (u - 0.5) * (1 - max(v - 0.75, 0) / (1 - 0.75));
	f_pos = camera.proj * camera.view * mix(c0, c1, u + 0.5 * v - (u * v));
	f_nor = vec4(normalize(cross(t0.xyz, bitan.xyz)), 1);
	f_uv = vec2(u,v);
	gl_Position = f_pos;
}
