uniform sampler2DArray unTexture;
uniform vec4 unTint;

in vec3 fUV;
in vec4 fColor;

out vec4 pColor;

void main() {
  pColor = texture(unTexture, fUV);
  pColor *= unTint * fColor;
}
