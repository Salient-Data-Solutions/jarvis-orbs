// Eight curved blades, their edges lit.
vec4 shade(vec3 base) {
  float r = length(vPos.xy);
  float a = atan(vPos.y, vPos.x) / 6.28318 + r * 0.35;
  float blade = abs(fract(a * 8.0) - 0.5);
  float edge = 1.0 - smoothstep(0.0, 0.06, abs(blade - 0.45));
  float body = 0.55 + 0.5 * smoothstep(0.5, 0.0, blade);
  return vec4(base * (body + 1.3 * edge), 0.6 + 0.4 * edge);
}
