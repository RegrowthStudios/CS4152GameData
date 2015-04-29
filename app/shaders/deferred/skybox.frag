#version 130

in vec3 fragPos;

uniform samplerCube skybox;

out vec4 fragColor;

void main() {
  fragColor = textureCube(skybox, fragPos);
}