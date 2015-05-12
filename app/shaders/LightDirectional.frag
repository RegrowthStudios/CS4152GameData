// Uniforms
uniform sampler2D unTextureNormal;
uniform sampler2D unTextureDepth;
uniform sampler2D unTextureBRDF;
uniform vec3 unLightDirection;
uniform vec3 unLightIntensity;
uniform vec3 unEyePosition;
uniform mat4 unVPInv;

// Input
in vec2 fUV;

// Output
out vec3 pColor;

void main() {
    // Reconstruct position in world-space
    float depth = texture(unTextureDepth, fUV).x;
    vec4 worldPos = unVPInv * vec4(fUV, depth, 1.0);
    worldPos /= worldPos.w;
    
    // Read normal information
    vec4 texNormal = texture(unTextureNormal, fUV);
    vec3 N = normalize(texNormal.xyz);

    // Diffuse component
    float diffuseFactor = max(0.0, -dot(N, unLightDirection));

    // Specular component
    vec3 E = normalize(unEyePosition - worldPos.xyz);
    vec3 H = normalize(E - unLightDirection);
    float specularFactor = max(0.0, dot(H, N));
    
    pColor = unLightIntensity * texture(unTextureBRDF, vec2(diffuseFactor, specularFactor)).rgb * 2;
}
