// Uniforms
uniform sampler2D unTexture;
uniform float unExposure;
uniform float unGamma;

#if defined(MOTION_BLUR) || defined(DEPTH_OF_FIELD)
uniform sampler2D unTextureDepth;
#endif

#if defined(MOTION_BLUR)
uniform mat4 unVPInv;
#endif

#ifdef MOTION_BLUR
uniform int unNumSamples;
uniform mat4 unVPPrev;
uniform float unBlurIntensity;
#endif

#ifdef DEPTH_OF_FIELD
uniform float unFocalLen;
uniform float unZfocus;
uniform float unLensAmount; // (unFocalLen ^ 2) / area
uniform vec2 unInvTextureSize;
uniform float unBlurScale;
uniform float unSceneRange;
uniform float unMaxCoC;
#endif

// Input
in vec2 fUV;

// Output
out vec4 pColor;

void main() {
    // Original color
    vec3 color = texture(unTexture, fUV).rgb;

#if defined(MOTION_BLUR) || defined(DEPTH_OF_FIELD)
    float accum = 0.0;
    float depth = texture(unTextureDepth, fUV).x;
#endif

#if defined(MOTION_BLUR)
    // Reconstruct position in world space
    vec4 screenPos = vec4(fUV * 2 - 1, depth, 1);
    vec4 worldPos = unVPInv * screenPos;
    worldPos /= worldPos.w;
#endif

#ifdef MOTION_BLUR
    // Construct pixel position of last frame
    vec4 previousPos = unVPPrev * worldPos;
    previousPos /= previousPos.w;

    // Compute pixel velocity
    vec2 velocity = (screenPos.xy - previousPos.xy) * 0.5 * unBlurIntensity;
    vec2 sampleDisplacement = velocity / unNumSamples;

    // Accumulate blur samples
    accum = 1.0;
    vec2 uv = fUV;
    for(int i = 0; i < unNumSamples; i++) {
        float ratio = exp(-(i / unNumSamples) * unBlurIntensity);
        accum += ratio;
        uv -= sampleDisplacement;
        color += texture(unTexture, uv).rgb * ratio;
    }
    color /= accum;
#endif

#ifdef DEPTH_OF_FIELD
    // Special thanks to Isaque Dutra

    // Poisson disc distribution
    vec2 filterTaps[12];
    filterTaps[0]  = vec2(-0.326212, -0.405810) * unInvTextureSize;
    filterTaps[1]  = vec2(-0.840144, -0.073580) * unInvTextureSize;
    filterTaps[2]  = vec2(-0.695914,  0.457137) * unInvTextureSize;
    filterTaps[3]  = vec2(-0.203345,  0.620716) * unInvTextureSize;
    filterTaps[4]  = vec2( 0.962340, -0.194983) * unInvTextureSize;
    filterTaps[5]  = vec2( 0.473434, -0.480026) * unInvTextureSize;
    filterTaps[6]  = vec2( 0.519456,  0.767022) * unInvTextureSize;
    filterTaps[7]  = vec2( 0.185461, -0.893124) * unInvTextureSize;
    filterTaps[8]  = vec2( 0.507431,  0.064425) * unInvTextureSize;
    filterTaps[9]  = vec2( 0.896420,  0.412458) * unInvTextureSize;
    filterTaps[10] = vec2(-0.321940, -0.932615) * unInvTextureSize;
    filterTaps[11] = vec2(-0.791559, -0.597710) * unInvTextureSize;

    float pixCoC = abs(unLensAmount * (unZfocus - depth) / (unZfocus * (depth - unFocalLen)));
    float blur = clamp(pixCoC * unBlurScale / unMaxCoC, 0.0, 1.0);
    vec2 centerDepthBlur = vec2(depth / unSceneRange, blur);
    float sizeCoC = centerDepthBlur.y * unMaxCoC;

    // Accumulates blur samples
    vec3 colorSum = color.rgb;
    accum = 1.0;
    for(int i = 0; i < 12; i++) {
        vec2 tapCoord = fUV + filterTaps[i] * sizeCoC;
        vec3 tapColor = texture(unTexture, tapCoord).rgb;
        float tapDepth = texture(unTextureDepth, tapCoord).x;
        float tapPixCoC = abs(unLensAmount * (unZfocus - tapDepth) / (unZfocus * (tapDepth - unFocalLen)));
        float tapBlur = clamp(tapPixCoC * unBlurScale / unMaxCoC, 0.0, 1.0);

        vec4 tapDofDepth = vec4(tapDepth / unSceneRange, tapBlur, 0, 0);
        vec2 tapDepthBlur = tapDofDepth.xy;
        float tapContribution = (tapDepthBlur.x > centerDepthBlur.x) ? 1.0 : tapDepthBlur.y;
        colorSum += tapColor * tapContribution;
        accum += tapContribution;
    }

    color = colorSum / accum;
#endif

    color = 1.0 - exp(color * -unExposure); // Add exposure
    color = pow(color, vec3(unGamma)); // Gamma correction
    pColor = vec4(color, 1.0);
}
