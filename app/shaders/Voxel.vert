// Uniforms
uniform mat4 unWorld;
uniform mat4 unVP;

// Input
in vec4 vPosition;
in vec2 vUV;
in vec4 vColor;

// Output
out vec2 fUV;
out vec4 fColor;

void main() {
  vec4 worldPos = unWorld * vPosition;
  gl_Position = unVP * worldPos;

  fUV = vUV;
  fColor = vColor;
}
