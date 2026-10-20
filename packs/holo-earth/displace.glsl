// Holo Earth: the land lifts off the globe as you speak.
float he_land(vec3 n) { return 0.6 * snoise(n * 1.3 + 3.1) + 0.3 * snoise(n * 2.9) + 0.12 * snoise(n * 6.0); }
vec3 displace(vec3 p) {
  vec3 n = normalize(p);
  return p + n * uMax * smoothstep(0.08, 0.14, he_land(n)) * (0.1 + 0.6 * uAmp);
}
