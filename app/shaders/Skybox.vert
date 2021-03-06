// Uniforms
uniform mat4 unVP;

// Input
in vec3 vPosition;

// Output
out vec3 fDirection;

void main() {
  vec3 worldPos = vPosition;
  fDirection = vPosition;
  gl_Position = unVP * vec4(vPosition, 1.0);
}
