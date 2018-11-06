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
    vec3 topColor = vec3(155, 219, 87) / 255;
    vec3 botColor = vec3(57, 130, 28) / 255;
    vec3 interpolatedColor = mix(botColor, topColor, tese_uv.y);

    vec3 lightPos = vec3(1);
    vec3 lightDir = normalize(lightPos);
    float lambertian = clamp(dot(lightDir, tese_normal), 0.6, 1); // lower bound at 0.6 to make grass color look more uniform
    
    outColor = vec4(interpolatedColor * lambertian, 1);
}
