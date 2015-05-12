// Uniforms
uniform sampler2D unTexture;
uniform float unEntity;

// Input
in vec4 fPosition;
in vec3 fNormal;
in vec2 fUV;

// Output
out vec4 pColor;
out vec4 pNormal;
out vec4 pMaterial;
out vec2 pDepth;

void main() {
    pColor = texture(unTexture, fUV);
  
    pNormal.xyz = normalize(fNormal);
    pNormal.a = 1.0;
    
    pMaterial = vec4(0.0, 0.0, 0.0, 0.0);
    
    pDepth = vec2(fPosition.z / fPosition.w, unEntity);
}
