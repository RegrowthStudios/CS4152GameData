uniform mat4 unWorld;
uniform mat4 unVP;

in vec4 vPosition;
in vec4 vFace;

out vec4 fFace;

void main() {
  fFace = vFace;
  gl_Position = unVP * (unWorld * vPosition);
}
