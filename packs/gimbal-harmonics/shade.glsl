// Gimbal Harmonics by Otavio Good, https://www.shadertoy.com/view/llS3zd, CC0.
// The original nests 15 discs, each 0.84 the size of the last and turned by the same harmonic
// angle again, with half of every disc cut away. Here each ring of the disc is one of those
// levels: its visible half turns at (level + 1) times the base rate, and a ring tilted edge-on
// to you dims, as the 3D discs do.
vec4 shade(vec3 base) {
  const float thick = 0.85, space = 0.84;
  float r = length(vPos.xy);
  float level = floor(log(max(r, 1e-3)) / log(space));
  float outer = pow(space, level);
  float band = smoothstep(thick * outer - 0.004, thick * outer + 0.012, r);   // the inner cut-out
  float harmonic = uTime * 0.25 * (1.0 + uAmp);
  float ang = harmonic * (level + 1.0);
  vec2 cut = vec2(cos(ang), sin(ang));
  float half_ = smoothstep(-0.05, 0.12, dot(normalize(vPos.xy + 1e-4), cut));  // half the disc cut off
  float tilt = 0.35 + 0.65 * abs(cos(harmonic * level * 0.5));
  float centre = 1.0 - smoothstep(0.08, 0.14, r);                              // the ball in the middle
  vec3 col = mix(base, vec3(1.0), 0.15 + 0.35 * centre) * (band * half_ * tilt + centre * 1.5);
  return vec4(col * 1.3, clamp(band * half_ * tilt + centre, 0.0, 1.0));
}
