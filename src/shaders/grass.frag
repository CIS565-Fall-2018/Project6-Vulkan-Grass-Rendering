#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec4 pos;
layout(location = 1) in vec4 nor;
layout(location = 2) in vec2 uv;

layout(location = 0) out vec4 outColor;

void main() 
{
    // TODO: Compute fragment color
	//  give color for the base, color for the tip, lerp in between

	// too green
	//outColor = mix(vec4(0.0, 0.2, 0.0, 1.0), vec4(0.0, 0.4, 0.0, 1.0), uv.y);

	// too brown
	//(76, 23, 8) to (204, 143, 75)
	//outColor = mix(vec4(0.298, 0.09, 0.03, 1.0), vec4(0.80, 0.56, 0.29, 1.0), uv.y);

	// not enough gradient
	// (196, 146, 97) to (229, 178, 128)
	//outColor = mix(vec4(0.768, 0.572, 0.380, 1.0), vec4(0.898, 0.698, 0.502, 1.0), uv.y);

	// too light
	// (212, 144, 79) to (248, 205, 148)
	//outColor = mix(vec4(0.831, 0.565, 0.310, 1.0), vec4(0.973, 0.804, 0.580, 1.0), uv.y);

	// perfect
	// (129, 72, 35) to (222, 170, 115)
	outColor = mix(vec4(0.505, 0.282, 0.137, 1.0), vec4(0.871, 0.667, 0.451, 1.0), uv.y);
}
