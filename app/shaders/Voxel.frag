// Uniforms
uniform sampler2DArray unTexture;
uniform vec4 unTint;

// Input
in vec3 fNormal;
in vec3 fUV;
in vec4 fColor;

// Output
out vec4 pColor;

void main() {
  pColor = unTint * fColor * texture(unTexture, fUV);
}
