// Data Rain: each column has a bright head falling at its own speed, a fading trail of flickering
// glyphs behind it, and glyphs made of a 3 by 5 grid of random bits.
float dr_hash(vec2 p) { return fract(sin(dot(p, vec2(41.3, 289.1))) * 45758.5453); }
vec4 shade(vec3 base) {
  vec3 n = normalize(vPos + 1e-4);
  float lon = atan(n.z, n.x) / 6.2831853 + 0.5, down = acos(clamp(n.y, -1.0, 1.0)) / 3.1415927;
  vec2 g = vec2(lon * 72.0, down * 44.0), id = floor(g), f = fract(g);
  float speed = 0.35 + 0.65 * dr_hash(vec2(id.x, 1.0));
  float head = fract(dr_hash(vec2(id.x, 7.0)) + uPulse * speed * 0.55);
  float behind = fract(head - (id.y + 0.5) / 44.0);
  float trail = exp(-behind * 4.5) * step(0.25, dr_hash(vec2(id.x, 3.0)));
  vec2 bit = floor(f * vec2(3.0, 5.0));
  float shape = step(0.45, dr_hash(id * 7.1 + bit * 13.7 + floor(uTime * 4.0 + 9.0 * dr_hash(id))));
  float inset = step(0.12, f.x) * step(f.x, 0.88) * step(0.08, f.y) * step(f.y, 0.92);
  float glyph = shape * inset;
  float isHead = step(behind, 1.2 / 44.0);
  vec3 col = base * glyph * trail * 1.3 + vec3(0.85, 1.0, 0.9) * glyph * isHead;
  return vec4(col, clamp(glyph * (trail + isHead), 0.0, 1.0));
}
