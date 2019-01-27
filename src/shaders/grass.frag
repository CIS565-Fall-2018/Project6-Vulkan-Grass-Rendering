#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec4 debug_col_out;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color with like some sort of lambert or something

    outColor = debug_col_out;
}
