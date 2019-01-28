#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

layout(location = 0) in float lightIntensity;

layout(location = 0) out vec4 outColor;

void main() {
    outColor = lightIntensity * vec4(34.0 / 255.0, 139.0 / 255.0, 34.0 / 255.0, 0.0);
}
