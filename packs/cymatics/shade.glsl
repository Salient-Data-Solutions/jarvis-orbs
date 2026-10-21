// Crests bright, troughs dim, and the nodal lines, where the surface
// stays still and sand would gather, glowing white.
float cy_one(vec3 n, float k) {
  float th = acos(clamp(n.y, -1.0, 1.0)), ph = atan(n.z, n.x);
  float l = 2.0 + mod(k * 3.0, 5.0), m = 1.0 + mod(k * 2.0, 4.0);
  return cos(l * th) * cos(m * ph) * sin(th);
}
float cy_wave(vec3 n, float t) {
  float k = floor(t / 7.0), w = smoothstep(0.0, 2.0, mod(t, 7.0));
  return mix(cy_one(n, k - 1.0), cy_one(n, k), w);
}
vec4 shade(vec3 base) {
  vec3 n = normalize(vPos + 1e-4);
  float v = cy_wave(n, uTime);
  float node = smoothstep(0.035, 0.0, abs(v));
  float crest = v * sin(uTime * 2.6) > 0.0 ? 1.0 : 0.0;
  vec3 col = mix(base * 0.18, mix(base, uHot, 0.35) * 1.2, crest) * (0.3 + 1.4 * abs(v)) + vec3(1.0) * node;
  return vec4(col, 0.2 + 0.8 * max(node, abs(v) * (0.4 + 0.6 * crest)));
}
