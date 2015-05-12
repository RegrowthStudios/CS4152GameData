// Uniforms
uniform sampler2D unTexture;
uniform sampler2D unTextureGaussian;
uniform int unSampleCount;
uniform float unSampleWidth;

// Input
in vec2 fUV;

// Output
out vec4 pColor;

void main() {
    vec2 gaussUV = vec2(0.0, 0.5);
    float accum = texture(unTextureGaussian, gaussUV).x;
    vec3 color = texture(unTexture, fUV).rgb * accum;
    
    for (int i = 1; i <= unSampleCount; i++) {
        gaussUV.x = float(i) / float(unSampleCount);
        vec2 sampleOffset = vec2(gaussUV.x * unSampleWidth, 0);

        float gauss = texture(unTextureGaussian, gaussUV).x;
        color += texture(unTexture, fUV + sampleOffset).rgb * gauss;
        color += texture(unTexture, fUV - sampleOffset).rgb * gauss;
        accum += gauss * 2.0;
    }
    
    pColor = vec4(color / accum, 1.0);
}
