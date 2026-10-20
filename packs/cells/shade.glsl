// Worley cellular noise: F2 - F1 is the distance to the nearest border, so borders glow.
vec3 cl_hash3(vec3 p) {
  p = vec3(dot(p, vec3(127.1, 311.7, 74.7)), dot(p, vec3(269.5, 183.3, 246.1)), dot(p, vec3(113.5, 271.9, 124.6)));
  return fract(sin(p) * 43758.5453123);
}
vec4 shade(vec3 base) {
  vec3 x = normalize(vPos + 1e-4) * 3.0;
  vec3 i = floor(x), f = fract(x);
  float d1 = 8.0, d2 = 8.0, id = 0.0;
  for (int k = -1; k <= 1; k++) for (int j = -1; j <= 1; j++) for (int m = -1; m <= 1; m++) {
    vec3 g = vec3(float(m), float(j), float(k));
    vec3 o = cl_hash3(i + g);
    float h = o.x;
    o = 0.5 + 0.4 * sin(uTime * 0.6 + 6.2831 * o);
    float d = length(g + o - f);
    if (d < d1) { d2 = d1; d1 = d; id = h; } else if (d < d2) d2 = d;
  }
  float edge = 1.0 - smoothstep(0.0, 0.08 + 0.06 * uAmp, d2 - d1);
  vec3 cell = base * (0.12 + 0.25 * id) * (1.0 - d1 * 0.6);
  vec3 col = cell + mix(base, vec3(1.0), 0.5) * edge * (1.2 + uAmp);
  return vec4(col, clamp(0.35 + edge, 0.0, 1.0));
}
