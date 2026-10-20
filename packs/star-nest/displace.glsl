// Star Nest: the surface barely breathes; the light inside is the show.
vec3 displace(vec3 p) {
  return p + normalize(p) * snoise(normalize(p) * 2.0 + uTime * 0.2) * uMax * 0.5 * uAmp;
}
