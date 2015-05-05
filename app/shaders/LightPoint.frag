// Uniforms
uniform mat4 unVPInv;
uniform sampler2D unTextureNormal;
uniform sampler2D unTextureDepth;
uniform vec3 unLightIntensity;
uniform vec3 unLightPosition;
uniform float unLightRadius;

// Input
in vec4 fPosition;

// Output
out vec3 pColor;

void main() {
  // Find correct UV
  vec4 fPos = fPosition / fPosition.w;
  vec2 fUV = fPos.xy * 0.5 + 0.5;

  // Compute recorded position
  fPos.z = texture(unTextureDepth, fUV).x;
  fPos = unVPInv * fPos;
  fPos /= fPos.w;
  
  // Read normal information
  vec4 texNormal = texture(unTextureNormal, fUV);
  vec3 N = normalize(texNormal.xyz);

  // Attenuation
  vec3 L = unLightPosition - fPos.xyz;
  float distance = length(L);
  float attenuation = 1 / (distance * distance);
  attenuation *= step(distance, unLightRadius); 

  // Diffuse component
  L /= distance;
  float dotNL = max(0.0, dot(N, L));
  
  pColor = (attenuation * unLightIntensity) * dotNL;
}
