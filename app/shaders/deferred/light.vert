#version 130

in vec3 position;

uniform mat4 vp;

uniform vec3 worldPos;
uniform float radius;

void main() {
	vec3 wPos = (position * radius) + worldPos;
	gl_Position = vp * vec4(wPos, 1.0);
}