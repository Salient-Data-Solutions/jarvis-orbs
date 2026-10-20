// Topologica by Otavio Good, https://www.shadertoy.com/view/4djXzz, CC0.
// Its Density(): two low-frequency noise fields, lit where both cross one half, so 0.1/|a*a*b|
// spikes into filaments. Sampled at each point of the orb as the fields drift through it.
float tp_hash(vec3 uv) {
  float f = uv.x + uv.y * 37.0 + uv.z * 521.0;
  return fract(cos(f * 3.333) * 100003.9);
}
float tp_mix(float f0, float f1, float a) { return mix(f0, f1, a * a * (3.0 - 2.0 * a)); }
float tp_noise(vec3 uv) {
  const vec2 zo = vec2(0.0, 1.0);
  vec3 fr = fract(uv), fl = floor(uv);
  return tp_mix(
    tp_mix(tp_mix(tp_hash(fl), tp_hash(fl + zo.yxx), fr.x), tp_mix(tp_hash(fl + zo.xyx), tp_hash(fl + zo.yyx), fr.x), fr.y),
    tp_mix(tp_mix(tp_hash(fl + zo.xxy), tp_hash(fl + zo.yxy), fr.x), tp_mix(tp_hash(fl + zo.xyy), tp_hash(fl + zo.yyy), fr.x), fr.y),
    fr.z);
}
vec4 shade(vec3 base) {
  vec3 p = vPos * 3.0 + vec3(uTime * 0.11, uTime * 0.07, -uTime * 0.05);
  float a = tp_noise(p) - 0.5;
  float b = tp_noise(p + 1234.567) - 0.5;
  float density = 0.1 / abs(a * a * b) * 0.0003 * (1.0 + 2.0 * uAmp);
  vec3 col = sqrt(clamp(mix(vec3(0.01, 0.1, 1.0), base, 0.5) * density, 0.0, 1.0));
  return vec4(col * 1.2, clamp(density, 0.05, 1.0));
}
