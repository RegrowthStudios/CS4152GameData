// Uniforms
uniform mat4 unWorld;
uniform mat3 unWorldNorm;
uniform mat4 unVP;

// Input
in vec4 vPosition;
in vec2 vUV;
in vec3 vNormal;

// Output
out vec4 fPos;
out vec3 fNormal;
out vec2 fUV;

void main() {
  fPos = unWorld * vPosition;
  fNormal = unWorldNorm * vNormal;
  gl_Position = unVP * fPos;
  fUV = vUV;
}
