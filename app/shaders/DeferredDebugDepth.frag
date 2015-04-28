// Uniforms
uniform sampler2D unTexture;

// Input
in vec2 fUV;

// Output
out vec4 pColor;

void main() {
  float depth = texture(unTexture, fUV).x;
  pColor = vec4(depth, depth, depth, 1.0);
}
