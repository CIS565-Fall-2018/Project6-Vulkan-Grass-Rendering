#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs

layout(location = 0) in vec3 normal_FS_IN;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color

	// half lambert shading
    outColor = vec4(0.2, 0.5, 0.1, 1.0) * ( dot( normal_FS_IN, normalize(vec3(1,1,1)) ) * 0.5 + 0.5 );
}
