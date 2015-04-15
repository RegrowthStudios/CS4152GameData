uniform sampler2DArray unTexture;
uniform vec4 unTint;

in vec3 fUV;
in vec4 fColor;
in vec3 fNormal;

out vec4 pColor;

void main() {
    vec3 N = normalize(fNormal);
    pColor = texture(unTexture, fUV);
    pColor *= unTint * fColor;
}
