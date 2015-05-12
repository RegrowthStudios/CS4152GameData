// Uniforms
uniform sampler2D unTextureColor;
uniform sampler2D unTextureLight;
uniform sampler2D unTextureDepth;

#ifdef SSAO
#define SSAO_MAX_SAMPLES 40
uniform mat4 unVP;
uniform mat4 unVPInv;
uniform vec4 unSSAOPoisson[SSAO_MAX_SAMPLES]; // XYZ direction, W length of vector
uniform int unSSAOSampleCount;
uniform float unSSAORadius;
uniform float unSSAODepthBias;
uniform sampler2D unTextureNormal;
#endif

// Input
in vec2 fUV;

// Output
out vec4 pColor;

void main() {
    vec2 texDepth = texture(unTextureDepth, fUV).xy;
    if (texDepth.x == 1.0) discard;

    vec4 texColor = texture(unTextureColor, fUV);
    vec3 texLight = texture(unTextureLight, fUV).rgb;
    
#ifdef SSAO
    // Reconstruct position in world space
    vec4 screenPos = vec4(fUV * 2.0 - 1.0, texDepth.x, 1.0);
    vec4 worldPos = unVPInv * screenPos;
    worldPos /= worldPos.w;

    // Construct the normal basis
    vec3 texNormal = normalize(texture(unTextureNormal, fUV).xyz);
    float usePosY = step(abs(texNormal.y), 0.9);
    vec3 bitangent = vec3(0, usePosY, 1.0 - usePosY);
    vec3 tangent = normalize(cross(bitangent, texNormal));
    bitangent = cross(texNormal, tangent);
    mat3 normalBasis = mat3(tangent, bitangent, texNormal);

    float accum = 0.0;
    float amountLit = 0.0;
    for(int i = 0; i < unSSAOSampleCount; i++) {
        // Find the sampling offset vector
        vec3 sampleOffset = normalBasis * (unSSAOPoisson[i].xyz * unSSAORadius);
        float multiplier = max(0.0, unSSAOPoisson[i].z) * (1.0 - min(1.0, unSSAOPoisson[i].w)); // Dot product with normal * length

        // Retrieve a 2D sample
        vec4 ssaoSample = vec4(worldPos.xyz + sampleOffset, 1.0);
        ssaoSample = unVP * ssaoSample;
        ssaoSample /= ssaoSample.w;
        
        // Perform depth comparison
        float depth = texture(unTextureDepth, (ssaoSample.xy * 0.5) + 0.5).x;
        amountLit += step(ssaoSample.z, depth + unSSAODepthBias) * multiplier;
        accum += multiplier;
    }
    
    // Scale lighting by ambient occlusion
    texLight *= (amountLit / accum);
#endif

    // Scale albedo by color accumulations
    pColor = vec4(texColor.rgb * texLight, 1.0);
}
