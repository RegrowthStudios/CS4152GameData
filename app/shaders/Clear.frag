// Output
out vec4 pGBuffer0;
out vec4 pGBuffer1;
out vec4 pGBuffer2;
out vec2 pGBuffer3;

void main() {
  pGBuffer0 = vec4(0, 0, 0, 0);
  pGBuffer1 = vec4(0, 0, 0, 0);
  pGBuffer2 = vec4(0, 0, 0, 0);
  pGBuffer3 = vec2(1.0, 0.0);
  gl_FragDepth = 1.0;
}
