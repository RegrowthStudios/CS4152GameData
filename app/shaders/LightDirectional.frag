// Uniforms
uniform sampler2D unTextureNormal;
uniform sampler2D unTextureDepth;
uniform vec3 unLightDirection;
uniform vec3 unLightIntensity;

// Input
in vec2 fUV;

// Output
out vec3 pColor;

void main() {
  // Read normal information
  vec4 texNormal = texture(unTextureNormal, fUV);
  vec3 N = normalize(texNormal.xyz);

  // Diffuse component
  float dotNL = max(0.0, dot(N, unLightDirection));
  
  pColor = unLightIntensity * dotNL;
}
