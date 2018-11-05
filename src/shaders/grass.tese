#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs

layout (location = 0) patch in vec3 t_w;
layout (location = 1) patch in vec4 t_v1;
layout (location = 2) patch in vec4 t_v2;
layout (location = 3) patch in vec4 t_up;

layout(location = 0) out vec4 norm;
layout(location = 1) out vec2 f_uv;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// Pass uv coordinates for fragment shading
	f_uv = vec2 (u, v);

	// calculate vector tangent to face to get width step vector
	vec3 w = t_w * t_v2.w / 2.0;

	// recover base vertex v0
	vec3 t_v0 = gl_in[0].gl_Position.xyz;

	// interpolate point on Bezier Curve
	vec3 p1 = ((1 - v) * t_v0) + (v * t_v1.xyz);
	vec3 p2 = ((1 - v) * t_v1.xyz) + (v * t_v2.xyz);
	vec3 q = ((1 - v) * p1) + (v * p2);

	// get point along width
	vec3 pos = (q - w*(1-v)) + 2*u*w*(1-v);

	// convert to screen space and pass to fragment shader
	gl_Position = camera.proj * camera.view * vec4(pos, 1.0);
}
