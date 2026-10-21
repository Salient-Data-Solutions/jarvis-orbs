// Rows of tiles, fewer toward the poles like a real ball. Each tile is lit by its own centre's
// facing toward a light circling the ball, and a few random tiles flash each tick.
float mb_hash(vec2 p) { return fract(sin(dot(p, vec2(27.17, 113.9))) * 43758.5453); }
vec4 shade(vec3 base) {
  const float PI = 3.14159265, ROWS = 26.0;
  vec3 n = normalize(vPos + 1e-4);
  float v = (asin(clamp(n.y, -1.0, 1.0)) / PI + 0.5) * ROWS, row = floor(v);
  float rl = (row + 0.5) / ROWS * PI - PI * 0.5;
  float per = max(4.0, floor(ROWS * 2.0 * cos(rl)));
  float u = (atan(n.z, n.x) / (2.0 * PI) + 0.5) * per, col = floor(u);
  vec2 f = vec2(fract(u), fract(v));
  float tile = step(0.09, f.x) * step(f.x, 0.91) * step(0.09, f.y) * step(f.y, 0.91);
  float tl = (col + 0.5) / per * 2.0 * PI - PI;
  vec3 tn = vec3(cos(rl) * cos(tl), sin(rl), cos(rl) * sin(tl));
  vec3 L = normalize(vec3(cos(uTime * 0.6), 0.45, sin(uTime * 0.6)));
  float spec = pow(max(dot(tn, L), 0.0), 36.0);
  float glint = step(0.985 - 0.05 * min(uAmp, 1.0), mb_hash(vec2(row * 31.0 + col, floor(uTime * 5.0))));
  vec3 c = base * (0.1 + 0.18 * mb_hash(vec2(row, col))) + mix(base, vec3(1.0), 0.6) * spec * 1.8 + vec3(1.0) * glint * 1.4;
  return vec4(c * tile, tile * 0.85);
}
