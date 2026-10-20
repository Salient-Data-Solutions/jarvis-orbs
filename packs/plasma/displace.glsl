// Turbulence: two layers of noise, the second only when he is loud.
vec3 displace(vec3 p) {
  vec3 n = normalize(p);
  float t = uTime * (0.5 + uAmp);
  float d = snoise(n * 2.5 + t) + 0.5 * uAmp * snoise(n * 6.0 - t * 1.7);
  return p + n * d * uMax * (0.6 + uAmp * 1.6);
}
