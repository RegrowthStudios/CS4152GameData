// Uniforms
uniform sampler2D unTextureNormal;
uniform sampler2D unTextureDepth;
uniform sampler2D unTextureBRDF;
uniform vec3 unLightIntensity;
uniform vec3 unLightPosition;
uniform float unLightRadius;
uniform vec3 unEyePosition;
uniform mat4 unVPInv;

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
    float diffuseFactor = max(0.0, dot(N, L));

    // Specular component
    vec3 E = normalize(unEyePosition - fPos.xyz);
    vec3 H = normalize(E + L);
    float specularFactor = max(0.0, dot(H, N));
    
    pColor = (attenuation * unLightIntensity) * texture(unTextureBRDF, vec2(diffuseFactor, specularFactor)).rgb * 2;
}
