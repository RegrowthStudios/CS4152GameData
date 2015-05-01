// Uniforms
uniform sampler2D unTextureColor;
uniform sampler2D unTextureLight;
uniform sampler2D unTextureDepth;

// Input
in vec2 fUV;

// Output
out vec4 pColor;

void main() {
  vec2 texDepth = texture(unTextureDepth, fUV).xy;
  if (texDepth.x == 1.0) discard;
  
  vec4 texColor = texture(unTextureColor, fUV);
  vec3 texLight = texture(unTextureLight, fUV).rgb;

  // Scale albedo by color accumulations
  pColor = vec4(texColor.rgb * texLight, 1.0);
  // gl_FragDepth = texDepth.x;
}
