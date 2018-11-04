
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

layout (location = 0) out vec4 vertex_v1;
layout (location = 1) out vec4 vertex_v2;
layout (location = 2) out vec4 vertex_up;


out gl_PerVertex {
    vec4 gl_Position;
};

void main() {
	// TODO: Write gl_Position and any other shader outputs
    vec4 temp_v0 = model * vec4(v0.xyz, 1);
    gl_Position = vec4(temp_v0.xyz, v0.w);

    vec4 temp_v1 = model * vec4(v1.xyz, 1);
    vertex_v1 = vec4(temp_v1.xyz, v1.w);

    vec4 temp_v2 = model * vec4(v2.xyz, 1);
    vertex_v2 = vec4(temp_v2.xyz, v2.w);

    vertex_up = normalize(up);
}
