// Granulation: bright cells of rising gas with dark lanes between them, over slow sunspots.
vec4 shade(vec3 base) {
  vec3 n = normalize(vPos + 1e-4);
  float g = 0.6 * (0.5 + 0.5 * snoise(n * 14.0 + vec3(uTime * 0.15)))
          + 0.4 * (0.5 + 0.5 * snoise(n * 31.0 - vec3(uTime * 0.2)));
  float spot = smoothstep(0.68, 0.82, snoise(n * 2.2 + vec3(7.0, uTime * 0.02, 0.0)));
  vec3 hot = vec3(1.0, 0.92, 0.6), cool = vec3(1.0, 0.35, 0.04);
  vec3 col = mix(mix(cool, hot, g), base, 0.2) * (1.0 - 0.8 * spot);
  col = col * (0.75 + 0.4 * uAmp) + hot * vDisp * 0.9;
  return vec4(col * 1.1, 0.8);
}
