// Uniforms
uniform vec2 unOffset;

// Input
in vec2 vPosition;

// Output
out vec2 fUV;

void main() {
  fUV = vPosition * 0.5 + 0.5;
  gl_Position = vec4(vPosition * 0.5 + unOffset, 0.0, 1.0);
}
