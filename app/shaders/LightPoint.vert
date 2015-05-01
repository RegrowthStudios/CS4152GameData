// Uniforms
uniform mat4 unWorld;
uniform mat4 unVP;
uniform float unLightRadius;

// Input
in vec3 vPosition;

// Output
out vec4 fPosition;

void main() {
  vec4 worldPosition = unWorld * vec4(vPosition * unLightRadius, 1.0);
  fPosition = unVP * worldPosition;
  gl_Position = fPosition;
}
