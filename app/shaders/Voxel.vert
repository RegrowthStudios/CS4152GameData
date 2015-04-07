// Uniforms
uniform mat4 unWorld;
uniform mat4 unVP;

// Input
in vec4 vPosition;
in vec3 vNormal;
in vec3 vUV;
in vec4 vColor;

// Output
out vec3 fNormal;
out vec3 fUV;
out vec4 fColor;

void main() {
  vec4 worldPos = unWorld * vPosition;
  gl_Position = unVP * worldPos;

  fNormal = vNormal;
  fUV = vUV;
  fColor = vColor;
}
