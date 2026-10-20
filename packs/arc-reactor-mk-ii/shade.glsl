// A triangle and ten spokes burn brighter than the rings around them.
vec4 shade(vec3 base) {
  float r = length(vPos.xy);
  float a = atan(vPos.y, vPos.x);
  float tri = 0.0;
  for (int i = 0; i < 3; i++) {
    float ang = 1.5708 + float(i) * 2.0944;
    vec2 n = vec2(cos(ang + 1.0472), sin(ang + 1.0472));
    tri = max(tri, 1.0 - smoothstep(0.0, 0.05, abs(dot(vPos.xy, n) - 0.28)));
  }
  tri *= step(r, 0.62);
  float spokes = 1.0 - smoothstep(0.0, 0.08, abs(fract(a / 6.28318 * 10.0) - 0.5) - 0.42);
  spokes *= step(0.68, r) * step(r, 0.94);
  float glow = 0.7 + 1.4 * tri + 0.8 * spokes + 0.6 * uAmp;
  return vec4(mix(base, vec3(1.0), clamp(tri * 0.6, 0.0, 1.0)) * glow, 0.65 + 0.35 * max(tri, spokes));
}
