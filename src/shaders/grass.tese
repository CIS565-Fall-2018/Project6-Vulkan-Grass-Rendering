#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout(location = 0) in vec4 in_v0[];
layout(location = 1) in vec4 in_v1[];
layout(location = 2) in vec4 in_v2[];

layout(location = 0) out vec4 out_pos;
layout(location = 1) out vec3 out_normal;
layout(location = 2) out vec2 out_tex;

void main() 
{
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	vec4 v0 = in_v0[0];
	vec4 v1 = in_v1[0];
	vec4 v2 = in_v2[0];

	float orientation = v0.w;
	float width = v2.w;

	vec4 a = v0 + v * (v1 - v0);
	vec4 b = v1 + v * (v2 - v1);
	vec4 c = a + v * (b - a);

	// tangent
	vec4 t0 = normalize(b - a);

	// bitangent - i am assuming it is perpendicular to grass plane
	float z = cos(orientation); // sin(90 - orientation)
	float x = sin(orientation); // cos(90 - orientation)
	float y = 0.0;// ???
	vec4 t1 = vec4(x, 0.0, z);

	vec4 c0 = c - width * t1;
	vec4 c1 = c + width * t1;

	vec4 normal = normalize(cross(t0, t1));

	// TODO: Which one to use?
	float t = u; // quad
	//float t = u + 0.5 * v - u * v; // Triangle interpolation
	//float t = u - u * v * v; // QUadratic

	vec4 pos = (1 - t) * c0 + t * c1;

	out_pos = camera.proj * camera.view * vec4(pos, 1.0);
	out_normal = normal;
	out_tex = vec3(u, v);

	gl_Position = camera.out_pos;
}
