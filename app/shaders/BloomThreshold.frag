// Uniforms
uniform sampler2D unTexture;
uniform float unThreshold;

// Input
in vec2 fUV;

// Output
out vec4 pColor;

void main() {
    vec4 texColor = texture(unTexture, fUV);
    float luminance = dot(texColor.rgb, vec3(0.2, 0.7, 0.1));
    pColor = step(unThreshold, luminance) * texColor;
}
