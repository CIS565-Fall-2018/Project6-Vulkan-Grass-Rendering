#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout(location = 0) in vec4 v0[];
layout(location = 1) in vec4 v1[];
layout(location = 2) in vec4 v2[];
layout(location = 3) in vec4 up[];

layout(location = 0) out vec4 pos;
layout(location = 1) out vec4 nor;
layout(location = 2) out vec2 uv;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    uv = vec2(u, v);

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
	vec3 base_to_up = v0[0].xyz + v * (v1[0].xyz - v0[0].xyz);
	vec3 up_to_over = v1[0].xyz + v * (v2[0].xyz - v1[0].xyz);
	// base to tip interp function
	vec3 base_to_tip = base_to_up + v * (up_to_over - base_to_up);

	// which way the grass is oriented in x, z
	vec3 orientation = vec3(sin(v0[0].w), 0.0, cos(v0[0].w));
	float width = v2[0].w;

	// thickening the blade along orientation
	vec3 blade_left = base_to_tip - width * orientation;
	vec3 blade_right = base_to_tip + width * orientation;

	// getting the direction normal to the flat portion of the blade
	vec3 width_nor = normalize(up_to_over - base_to_up);
	nor.xyz = normalize(cross(width_nor, orientation));

	float t = u + 0.5 * v - u * v;
	pos.xyz =  (1.0 - t) * blade_left + t * blade_right;
	gl_Position = camera.proj * camera.view * vec4(pos.xyz, 1.0);
}