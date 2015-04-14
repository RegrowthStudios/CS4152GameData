#version 130 core

in vec3 fragPos;
in vec3 fragNormal;
in vec3 fragColor;

uniform vec3 diffuse;
uniform float specular;

out vec4 position;
out vec4 normal;
out vec4 color;

void main() {
	position = vec4(fragPos, 1.0);
	normal = vec4(fragNormal, specular);
	//normal = vec4(fragNormal * 0.5 + 0.5, specular);
	color = vec4(diffuse, 1.0);
}