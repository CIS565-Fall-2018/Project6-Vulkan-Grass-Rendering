#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
//inputs
layout(location = 0) patch in vec4 tese_v1;
layout(location = 1) patch in vec4 tese_v2;
layout(location = 2) patch in vec4 tese_up;
layout(location = 3) patch in vec4 tese_bitan;
// outputs
layout(location = 0) out vec2 fs_uv;
layout(location = 1) out vec4 fs_pos;
layout(location = 2) out vec4 fs_nor;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
	// 6.3 of old.
	vec3 input_pos = vec3(gl_in[0].gl_Position);

	// bezier - deCasteljau
	vec3 a = input_pos + v * (vec3(tese_v1) - input_pos);
	vec3 b = vec3(tese_v1) + v * (vec3(tese_v2) - input_pos);
	vec3 c = a + v * (b - a);

	// update normal
	vec3 bitan3 = tese_bitan.xyz;
	vec3 c0 = c - tese_v2.w * bitan3;
	vec3 c1 = c + tese_v2.w * bitan3;
	vec3 t0 = normalize(b - a);
	fs_nor = vec4(normalize(cross(t0, bitan3)), 0);

	// interpolate for position
	fs_pos = camera.proj * camera.view * vec4(mix(c0, c1, u - (u * v * v)), 1.0);
	gl_Position = fs_pos;

	// update uv
	fs_uv = vec2(u, v);
}
