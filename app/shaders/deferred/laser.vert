#version 130

in vec3 position;

uniform mat4 world;
uniform mat4 vp;

void main() {
  gl_Position = vp * world * vec4(position, 1.0);
}
