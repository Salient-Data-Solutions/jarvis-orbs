// Cymatics: standing waves on a sphere. A new mode every seven seconds, blended in over two.
float cy_one(vec3 n, float k) {
  float th = acos(clamp(n.y, -1.0, 1.0)), ph = atan(n.z, n.x);
  float l = 2.0 + mod(k * 3.0, 5.0), m = 1.0 + mod(k * 2.0, 4.0);
  return cos(l * th) * cos(m * ph) * sin(th);
}
float cy_wave(vec3 n, float t) {
  float k = floor(t / 7.0), w = smoothstep(0.0, 2.0, mod(t, 7.0));
  return mix(cy_one(n, k - 1.0), cy_one(n, k), w);
}
vec3 displace(vec3 p) {
  vec3 n = normalize(p);
  return p + n * cy_wave(n, uTime) * sin(uTime * 2.6) * uMax * (0.3 + 0.7 * uAmp);
}
