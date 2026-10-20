// The shadow is empty, the photon ring burns, and the gas runs inward along log spirals,
// brighter on the side turning toward you (Doppler beaming) and hotter near the hole.
float eh_fbm(vec3 p) { return 0.6 * snoise(p) + 0.3 * snoise(p * 2.1) + 0.15 * snoise(p * 4.3); }
vec4 shade(vec3 base) {
  float r = length(vPos.xy), a = atan(vPos.y, vPos.x);
  if (r < 0.27) return vec4(0.0);
  float ring = exp(-pow((r - 0.31) / 0.02, 2.0)) * (1.3 + 0.8 * uAmp);
  float u = a + 2.4 * log(r) - uPulse * 1.6;
  float gas = 0.35 + 0.9 * eh_fbm(vec3(cos(u) * 1.6, sin(u) * 1.6, r * 5.0 + uTime * 0.1));
  float disc = smoothstep(0.34, 0.42, r) * smoothstep(1.0, 0.75, r);
  float doppler = 1.0 + 0.5 * cos(a + 0.6);
  gas = max(gas, 0.0);
  float heat = smoothstep(1.0, 0.35, r);
  vec3 col = mix(base, vec3(1.0, 0.93, 0.78), heat * 0.6) * gas * disc * doppler * (2.2 + 2.4 * heat)
           + mix(base, vec3(1.0), 0.75) * ring;
  return vec4(col, clamp(disc * gas * doppler + ring, 0.0, 1.0));
}
