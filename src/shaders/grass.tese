#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
	vec4 p1 = mix(gl_in[1].gl_Position, gl_in[0].gl_Position, u);
	vec4 p2 = mix(gl_in[2].gl_Position,gl_in[3].gl_Position, u);
    gl_Position = mix(p1, p2, v);
}
