// Uniforms
uniform mat4 unWorld;
uniform mat4 unVP;

// Input
in vec4 vPosition;

void main() {
  vec4 worldPos = unWorld * vPosition;
  gl_Position = unVP * worldPos;
}
