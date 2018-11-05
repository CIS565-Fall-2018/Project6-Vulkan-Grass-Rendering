
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// TODO: Declare vertex shader inputs and outputs
layout (location = 0) in vec4 v0;
layout (location = 1) in vec4 v1;
layout (location = 2) in vec4 v2;
layout (location = 3) in vec4 up;

layout(location = 0) out vec4 tescV1;
layout(location = 1) out vec4 tescV2;
layout(location = 2) out vec4 tescUp;
layout(location = 3) out vec3 tescTangent;

out gl_PerVertex {
    vec4 gl_Position;
};


void main() {
	// TODO: Write gl_Position and any other shader outputs
    float direction = v0.w;
	float height = v1.w;
	float width = v2.w;

	vec3 rootPosition = vec3(v0.xyz);

	float cosTheta = cos(direction);
	float sinTheta = sin(direction);

	float tangentX = width * 0.5 * cosTheta;
	float tangentZ = width * 0.5 * sinTheta;

	vec3 rootLeft = rootPosition + vec3(tangentX, 0.0f, -tangentZ);
	vec3 tangentGround = rootLeft - rootPosition;
	tescTangent = normalize(tangentGround);

	tescV1 = model * vec4(v1.xyz, 1.0f);
	tescV2 = model * vec4(v2.xyz, 1.0f);

	tescUp = model * vec4(up.xyz, 0.0f);
	tescUp.w = width;

	gl_Position = model * vec4(v0.xyz, 1.0f);
}