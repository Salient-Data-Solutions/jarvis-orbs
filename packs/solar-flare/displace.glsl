// Solar Flare: the surface boils, and flares lift off the hottest patches as you speak.
vec3 displace(vec3 p) {
  vec3 n = normalize(p);
  float boil = snoise(n * 3.0 + vec3(0.0, uTime * 0.25, 0.0));
  float flare = smoothstep(0.45, 0.9, snoise(n * 1.6 - vec3(uTime * 0.08)));
  return p + n * uMax * (0.12 * boil + flare * (0.25 + 0.75 * uAmp));
}
