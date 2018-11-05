#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
	mat4 view;
	mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
// 
layout(location = 0) in vec4 pos;
layout(location = 1) in vec4 nor;
layout(location = 2) in vec2 uv;

layout(location = 0) out vec4 outColor;

vec3 cosPalette(  float t,  vec3 a,  vec3 b,  vec3 c, vec3 d ){
	return a + b*cos( 6.28318*(c*t+d) );
}

void main() {
	// TODO: Compute fragment color
	outColor = vec4(cosPalette(uv[1],vec3(0.2,0.5,0.3),vec3(0.0,0.5,0.7),vec3(1.0,1.0,1.0),vec3(0.0,0.3,0.7)), 1.0);
	outColor *= pos/vec4(10.0);

	vec4 topColor = vec4(37, 189, 5, 255) / vec4(255);
	vec4 bottomColor = vec4(107, 169, 73, 255) / vec4(255);
	vec4 lightDir = normalize(vec4(1.0, 0.0, -1.0, 0.0));
	outColor = mix(bottomColor, topColor, uv.y) * max(dot(lightDir, nor), 0.0);


	//outColor = vec4(1.0);
}
