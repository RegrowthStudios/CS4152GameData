#version 130

in vec2 position;

uniform mat4 inverseVP;

out vec3 fragPos;

void main() {
  vec4 temp = inverseVP * vec4(position * 0.5 + 0.5, 1.0, 1.0);
  gl_Position = temp;
  fragPos = temp.xyz / temp.w;
}
