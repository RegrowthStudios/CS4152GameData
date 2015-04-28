uniform mat4 unWorld;
uniform mat4 unVP;

in vec4 vPosition;
in vec3 vUV;
in vec4 vColor;
in vec3 vNormal;

out vec3 fUV;
out vec4 fColor;
out vec3 fNormal;
out vec4 fPosition;

void main() {
    fUV = vUV;
    fColor = vColor;
    fNormal = (unWorld * vec4(vNormal, 0)).xyz;
    fPosition = unVP * (unWorld * vPosition);
    gl_Position = fPosition;
}
