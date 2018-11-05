#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec4 normal;
layout(location = 1) in vec3 pos;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
	 vec3 color1 = vec3( 72/255.0,  86/255.0, 0/255.0);
    vec3 color2 = vec3(157/255.0, 193/255.0, 0/255.0);
    
    outColor = vec4(mix(color1, color2, normal.x), 1.0);
}
