// Uniforms
uniform sampler2D unTexture;

// Input
in vec2 fUV;

// Output
out vec4 pColor;

void main() {
  pColor = texture(unTexture, fUV);
}
