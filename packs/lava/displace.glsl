// Lava: the crust heaves slowly, and with your voice.
vec3 displace(vec3 p) {
  vec3 n = normalize(p);
  return p + n * snoise(n * 3.0 + vec3(0.0, uTime * 0.15, 0.0)) * uMax * (0.25 + 0.75 * uAmp);
}
