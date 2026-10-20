// Filaments of hotter colour drift across the surface.
vec4 shade(vec3 base) {
  float f = snoise(vPos * 4.0 + vec3(0.0, uTime * 0.7, 0.0)) * 0.5 + 0.5;
  vec3 hot = mix(base, uHot, smoothstep(0.55, 0.95, f));
  return vec4(hot * (0.6 + 0.8 * f), 0.4 + 0.6 * f);
}
