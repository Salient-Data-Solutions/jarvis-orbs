// Each ring ripples around its own circumference.
vec3 displace(vec3 p) {
  float a = atan(p.z, p.x) + atan(p.y, length(p.xz));
  return p * (1.0 + uAmp * 0.12 * sin(a * 7.0 + uPulse * 5.0));
}
