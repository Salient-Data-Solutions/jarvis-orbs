// Nox Fire's colouring: the same noise loop as heat, squared and pushed through tanh.
vec4 shade(vec3 base) {
  float t = uTime;
  vec3 p = vPos * 3.0 + vec3(0.0, 0.0, t * 2.0);
  p += cos(p.z + t + p.yzx * 0.5) * 0.6;
  float s = 1.1 - length(vPos);
  for (float n = 1.6; n < 32.0; n += n)
    s -= abs(dot(sin(p.z + t + p * n), vec3(1.12))) / n * 0.35;
  float heat = 1.0 / (0.06 + abs(s));
  vec3 col = tanh(vec3(5.0, 2.0, 1.0) * heat * heat * (0.004 + 0.004 * uAmp));
  col = mix(col, col * base * 1.5, 0.2);
  return vec4(col * 1.4, clamp(heat * 0.12, 0.15, 1.0));
}
