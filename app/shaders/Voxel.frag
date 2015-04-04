// Uniforms
uniform sampler2D unTexture;
uniform vec4 unTint;

// Input
in vec2 fUV;
in vec4 fColor;

// Output
out vec4 pColor;

void main() {
  pColor = unTint * fColor * texture(unTexture, fUV);
}
