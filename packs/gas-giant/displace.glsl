// Gas Giant: the belts ripple outward, pole to pole, while you speak.
vec3 displace(vec3 p) {
  vec3 n = normalize(p);
  float wave = sin(n.y * 22.0 - uTime * 3.0) * 0.5 + 0.5;
  return p + n * uMax * uAmp * 0.6 * wave;
}
