// Event Horizon: the disc warps gently, and the photon ring swells with your voice.
vec3 displace(vec3 p) {
  float r = length(p.xy), a = atan(p.y, p.x);
  float warp = 0.05 * r * sin(2.0 * a + uTime * 0.4);
  float ring = exp(-pow((r - 0.31) / 0.05, 2.0)) * uMax * (0.2 + 0.8 * uAmp);
  return p + vec3(0.0, 0.0, warp + ring);
}
