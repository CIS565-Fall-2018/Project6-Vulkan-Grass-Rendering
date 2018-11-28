#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs

layout(location = 0) in vec4 v0_ES_IN[];
layout(location = 1) in vec4 v1_ES_IN[];
layout(location = 2) in vec4 v2_ES_IN[];
layout(location = 3) in vec4 up_ES_IN[];

layout(location = 0) out vec3 normal_FS_IN;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
	
	float direction = v0_ES_IN[0].w;
	float height = v1_ES_IN[0].w;
	float width = v2_ES_IN[0].w;
	float stiffness = up_ES_IN[0].w;

	vec3 front = vec3(cos(direction), 0, sin(direction));
	vec3 frontInCameraSpace = normalize((camera.view * vec4(front, 0.0)).xyz);
	float normalFlip = sign(frontInCameraSpace.z);
	vec3 bitangent = cross(front, up_ES_IN[0].xyz);//perpendicular to front

	vec3 a = v0_ES_IN[0].xyz + v * (v1_ES_IN[0].xyz - v0_ES_IN[0].xyz);
	vec3 b = v1_ES_IN[0].xyz + v * (v2_ES_IN[0].xyz - v1_ES_IN[0].xyz);
	vec3 c = a + v * (b - a);
	vec3 c0 = c - width * bitangent;
	vec3 c1 = c + width * bitangent;
	vec3 tangent = normalize(b - a);
	vec3 n = normalize(cross(tangent, bitangent));//in front direction

	float t = u - u * v * v;

	vec3 pos = (1 - t) * c0 + t * c1;

	normal_FS_IN = normalFlip * n;

	gl_Position = camera.proj * camera.view * vec4(pos, 1.0);

}
