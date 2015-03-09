// Uniforms
uniform sampler2D unTexture;
uniform samplerCube unTextureEnvironment;
uniform vec3 unEyePosition;

// Input
in vec4 fPos;
in vec3 fNormal;
in vec2 fUV;

// Output
out vec4 pColor;

void main() {
  vec3 V = normalize(unEyePosition - fPos.xyz);
  vec3 N = normalize(fNormal);
  
  vec4 cEnv = textureCube(unTextureEnvironment, reflect(-V, N));
  vec4 cDiffuse = texture(unTexture, fUV);
  
  pColor = mix(cEnv, cDiffuse, 0.8);
}
