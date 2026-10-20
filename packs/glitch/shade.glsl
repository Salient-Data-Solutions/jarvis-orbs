// Scan lines roll down, the whole thing flickers, and torn slices split into magenta.
float gt_hash(vec2 p) { return fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453); }
vec4 shade(vec3 base) {
  float slice = floor(vPos.y * 14.0), tick = floor(uTime * 9.0);
  float torn = step(0.82 - 0.3 * min(uAmp, 1.0), gt_hash(vec2(slice, tick)));
  float scan = 0.35 + 0.65 * sin(vPos.y * 150.0 - uTime * 12.0);
  float flick = 0.8 + 0.2 * gt_hash(vec2(tick, 0.0));
  vec3 col = mix(base, vec3(1.0, 0.25, 0.85), torn * 0.85) * scan * flick * (1.0 + 0.8 * vDisp);
  return vec4(col, 0.9);
}
