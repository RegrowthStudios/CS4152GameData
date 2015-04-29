#version 130

in vec3 fragPos;
in vec3 fragNormal;
in vec3 fragUV;

uniform sampler2DArray blockTexture;
//uniform float tint;
uniform float isTurret;

out vec4 position;
out vec4 normal;
out vec4 color;

void main() {
	position = vec4(fragPos, 1.0);
	normal = vec4(fragNormal, 1.0);
	if (isTurret > 0.0) color = vec4(1, 0, 0, 1);
	else color = vec4(vec3(1) * texture(blockTexture, fragUV).xyz, 1.0);
}