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

mat4 rotationMatrix(vec3 axis, float angle)
{
    axis = normalize(axis);
    float s = sin(angle);
    float c = cos(angle);
    float oc = 1.0 - c;
    
    return mat4(oc * axis.x * axis.x + c,           oc * axis.x * axis.y - axis.z * s,  oc * axis.z * axis.x + axis.y * s,  0.0,
                oc * axis.x * axis.y + axis.z * s,  oc * axis.y * axis.y + c,           oc * axis.y * axis.z - axis.x * s,  0.0,
                oc * axis.z * axis.x - axis.y * s,  oc * axis.y * axis.z + axis.x * s,  oc * axis.z * axis.z + c,           0.0,
                0.0,                                0.0,                                0.0,                                1.0);
}

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
	float w = 0.14;
	vec3 t1 = vec3(rotationMatrix(vec3(0,1,0), v0[0].x) * vec4(1,0,0,0));
	vec3 a = v0[0].xyz + v * (v1[0].xyz - v0[0].xyz);
	vec3 b = v1[0].xyz + v * (v2[0].xyz - v1[0].xyz);
	vec3 c = a + v * (b - a);
	vec3 c0 = c - w * t1;
	vec3 c1 = c + w * t1;
	vec3 t0 = normalize(b - a);
	vec3 n = normalize(cross(vec3(t0), vec3(t1)));

	nor = vec4(n, 0.0);

	float tau = 0.5;
	float t = 0.5 + (u - 0.5) * (1 - (max(v - tau, 0) / (1 - tau)));

	vec3 p = (1 - t) * c0 + t * c1;

	pos = vec4(p, 1.0);
	uv = vec2(u, v);

	gl_Position = camera.proj * camera.view * vec4(p, 1.0);
}
