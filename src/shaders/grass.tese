#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout(location = 0) patch in vec4 inV0;
layout(location = 1) patch in vec4 inV1;
layout(location = 2) patch in vec4 inV2;
layout(location = 3) patch in vec4 inUp;

layout(location = 0) out vec4 pos;
layout(location = 1) out vec2 uv;
layout(location = 2) out vec3 norm;


void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
	vec3 v0 = gl_in[0].gl_Position.xyz;
	vec3 v1 = inV1.xyz;
	vec3 v2 = inV2.xyz;

	vec3 a = v0 + v * (v1 - v0);
	vec3 b = v1 + v * (v2 - v1);
	vec3 c = a + v * (b - a);

	float o = inV0.w;
	float h = inV1.w;
	float w = inV2.w;
	float s = inUp.w;

	vec3 t1 = vec3(cos(o), 0, sin(o));
	vec3 dc =  t1 * w;
	vec3 c0 = c - dc;
	vec3 c1 = c + dc;

	vec3 t0 = normalize(b - a);

	norm = normalize(cross(t0, t1));

	// basic shapes, triangle interpolation
	float t = u + 0.5 * v - u * v;
	vec3 pxyz = (1.0 - t) * c0 + t * c1;
	pos = camera.proj * camera.view * vec4(pxyz, 1.0);

	uv = vec2(u, v);

	gl_Position = pos;
}
