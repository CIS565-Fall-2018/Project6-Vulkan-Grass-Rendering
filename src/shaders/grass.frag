#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout (location = 0) in vec3 tese_normal;
layout (location = 1) in vec2 tese_uv;

layout (location = 0) out vec4 outColor;


void main() {
    // TODO: Compute fragment color
    // get the normal, and the uv, do a lambertian shading
    // uv can be used to do a mixed color thing from bottom to tip
    vec4 originalColor = vec4(0, 1, 0, 1);
    vec3 lightDir = normalize(vec3(1));
    
    outColor = originalColor * dot(lightDir, tese_normal);
}
