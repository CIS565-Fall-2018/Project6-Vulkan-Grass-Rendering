#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec2 fs_uv;
layout(location = 1) in vec3 fs_pos;
layout(location = 2) in vec3 fs_nor;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color

    outColor = vec4(fs_uv.x, fs_uv.y, 0, 1);
}
