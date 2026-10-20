// Cells: each cell bulges outward from its border, more as you speak.
vec3 cl_hash(vec3 p) {
  p = vec3(dot(p, vec3(127.1, 311.7, 74.7)), dot(p, vec3(269.5, 183.3, 246.1)), dot(p, vec3(113.5, 271.9, 124.6)));
  return fract(sin(p) * 43758.5453123);
}
vec2 cl_cells(vec3 x) {
  vec3 i = floor(x), f = fract(x);
  float d1 = 8.0, d2 = 8.0;
  for (int k = -1; k <= 1; k++) for (int j = -1; j <= 1; j++) for (int m = -1; m <= 1; m++) {
    vec3 g = vec3(float(m), float(j), float(k));
    vec3 o = cl_hash(i + g);
    o = 0.5 + 0.4 * sin(uTime * 0.6 + 6.2831 * o);        // cells drift
    float d = length(g + o - f);
    if (d < d1) { d2 = d1; d1 = d; } else if (d < d2) d2 = d;
  }
  return vec2(d1, d2);
}
vec3 displace(vec3 p) {
  vec2 c = cl_cells(normalize(p) * 3.0);
  return p + normalize(p) * smoothstep(0.0, 0.4, c.y - c.x) * uMax * (0.3 + 0.7 * uAmp);
}
