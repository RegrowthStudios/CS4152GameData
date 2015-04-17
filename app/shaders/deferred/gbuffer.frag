#version 130

in vec3 fragPos;
in vec3 fragNormal;
in vec4 fragColor;
in vec3 fragUV;

uniform vec3 diffuse;
uniform float specular;

uniform sampler2DArray blockTexture;
//uniform vec4 tint;

out vec4 position;
out vec4 normal;
out vec4 color;

void main() {
	position = vec4(fragPos, 1.0);
	normal = vec4(fragNormal, specular);
	//normal = vec4(fragNormal * 0.5 + 0.5, specular);
	color = vec4(vec3(1) * texture(blockTexture, fragUV).xyz, 1.0);
	//color = vec4(diffuse, 1);
}