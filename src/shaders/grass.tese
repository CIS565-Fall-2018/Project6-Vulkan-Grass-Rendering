#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs

//inputs are from tessellation.control shader
layout(location = 0) patch in vec4 tese_v1;
layout(location = 1) patch in vec4 tese_v2;
layout(location = 2) patch in vec4 tese_up;
layout(location = 3) patch in vec4 tese_forward;

//output to fragment shader for shading
layout(location = 0) out vec4 pos;
layout(location = 1) out vec3 nor;
layout(location = 2) out vec3 forward;
layout(location = 3) out vec2 uv;


void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
	//get bezier curve control points
	vec3 p1 = gl_in[0].gl_Position.xyz;
	vec3 p2 = tese_v1.xyz;
	vec3 p3 = tese_v2.xyz;

	//use casteljau alg to calculate position on curve
	vec3 p11 = p1 + v * (p2 - p1);
	vec3 p21 = p2 + v * (p3 - p2);
	vec3 p = p11 + v * (p21 - p11);

	//expand on width direction
	vec3 width_dir = cross(tese_up.xyz, tese_forward.xyz);
	vec3 width_offset = width_dir * tese_v2.w * 0.5;
	vec3 p_left = p - width_offset;
	vec3 p_right = p + width_offset;

	//interpolate on this left-right line
	float parameter = u + 0.5 * v - u * v;
	pos.xyz = (1.0-t) * c0 + t * c1;
	pos = camera.proj * camera.view * vec4(pos.xyz, 1.0);

	//compose uv
	uv = vec2(u,v);
	
	//calculate new normal
	vec3 grow_dir = normalize(p21 - p11);
	nor = normalize(cross(width_dir, growth_dir));

	//new forward (just pass thru)
	forward = tese_forward.xyz;

	gl_Position = pos;

}
