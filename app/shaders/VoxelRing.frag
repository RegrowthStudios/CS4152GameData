uniform sampler2DArray unTexture;
uniform vec4 unTint;

in vec3 fUV;
in vec4 fColor;
in vec3 fNormal;
in vec4 fPosition;

out vec4 pColor;
out vec4 pNormal;
out vec4 pMaterial;
out vec2 pDepth;

void main() {
    pColor = texture(unTexture, fUV);
    pColor *= unTint * fColor;
    
    pNormal.xyz = normalize(fNormal);
    pNormal.a = 1.0;
    
    pMaterial = vec4(1.0, 0.5, 0.0, 1.0);
    
    pDepth = vec2(fPosition.z / fPosition.w, 0.0);
}
