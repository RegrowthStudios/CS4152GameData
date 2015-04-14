uniform mat4 unWorld;
uniform mat4 unVP;

in vec4 vPosition;
in vec3 vUV;
in vec4 vColor;

out vec3 fUV;
out vec4 fColor;

void main() {
  fUV = vUV;
  fColor = vColor;
  gl_Position = unVP * (unWorld * vPosition);
}
