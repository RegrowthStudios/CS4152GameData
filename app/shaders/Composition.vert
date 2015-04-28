// Input
in vec4 vPosition;

// Output
out vec2 fUV;

void main() {
  fUV = vPosition.xy * 0.5 + 0.5;
  gl_Position = vPosition;
}
