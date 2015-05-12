// Uniforms
uniform sampler2D unTexture;
uniform sampler2D unTextureGaussian;
uniform sampler2D unTextureBlurred;
uniform int unSampleCount;
uniform float unSampleHeight;
uniform float unPower;

// Input
in vec2 fUV;

// Output
out vec4 pColor;

void main() {
    vec2 gaussUV = vec2(0.0, 0.5);
    float accum = texture(unTextureGaussian, gaussUV).x;
    vec3 color = texture(unTextureBlurred, fUV).rgb * accum;
    
    for (int i = 1; i <= unSampleCount; i++) {
        gaussUV.x = float(i) / float(unSampleCount);
        vec2 sampleOffset = vec2(0, gaussUV.x * unSampleHeight);

        float gauss = texture(unTextureGaussian, gaussUV).x;
        color += texture(unTextureBlurred, fUV + sampleOffset).rgb * gauss;
        color += texture(unTextureBlurred, fUV - sampleOffset).rgb * gauss;
        accum += gauss * 2.0;
    }
    
    pColor = texture(unTexture, fUV) + vec4(color * (unPower / accum), 0.0);
}
