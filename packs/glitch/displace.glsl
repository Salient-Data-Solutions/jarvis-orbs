// Glitch: horizontal slices jump sideways for one tick at a time, more of them while you speak.
float gt_hash(vec2 p) { return fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453); }
vec3 displace(vec3 p) {
  float slice = floor(p.y * 14.0), tick = floor(uTime * 9.0);
  float torn = step(0.82 - 0.3 * min(uAmp, 1.0), gt_hash(vec2(slice, tick)));
  float shove = (gt_hash(vec2(tick, slice + 3.0)) - 0.5) * 2.0 * uMax;
  return p + vec3(shove * torn, 0.0, 0.0) + normalize(p) * uMax * 0.2 * uAmp;
}
