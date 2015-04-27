#version 130

in vec3 position;

uniform mat4 projection;
uniform mat4 mView;

void main() {
	gl_Position = projection * mView * vec4(position, 1.0);
}