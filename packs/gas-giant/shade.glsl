// Belts and zones by latitude, warped by noise so they shear past each other, plus a great storm
// in the thinking colour.
vec4 shade(vec3 base) {
  vec3 n = normalize(vPos + 1e-4);
  float lat = n.y + 0.05 * snoise(n * vec3(2.0, 9.0, 2.0) + vec3(uTime * 0.08, 0.0, 0.0))
                  + 0.015 * snoise(n * 14.0 - vec3(uTime * 0.1));
  float belts = 0.5 + 0.5 * sin(lat * 24.0), zones = 0.5 + 0.5 * sin(lat * 7.0 + 1.3);
  vec3 cream = vec3(0.98, 0.9, 0.78);
  vec3 col = mix(base * 0.45, mix(base, cream, 0.65), belts * 0.65 + zones * 0.35);
  vec3 c = normalize(vec3(0.8, -0.32, 0.5));
  float d = distance(n, c);
  float storm = smoothstep(0.2, 0.05, d) * (0.75 + 0.25 * sin(d * 60.0 - uTime * 2.0));
  col = mix(col, uHot * 0.9, storm);
  col += cream * smoothstep(0.23, 0.2, d) * smoothstep(0.17, 0.2, d) * 0.4;
  return vec4(col * (0.5 + 0.15 * uAmp), 0.7);
}
