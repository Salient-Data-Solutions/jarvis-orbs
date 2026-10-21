// Made-up continents from noise, drawn as a dot grid; faint oceans; a 30-degree graticule;
// and a scan line that brightens what it passes.
float he_land(vec3 n) { return 0.6 * snoise(n * 1.3 + 3.1) + 0.3 * snoise(n * 2.9) + 0.12 * snoise(n * 6.0); }
vec4 shade(vec3 base) {
  const float PI = 3.14159265;
  vec3 n = normalize(vPos + 1e-4);
  float lat = asin(clamp(n.y, -1.0, 1.0)), lon = atan(n.z, n.x);
  float land = smoothstep(0.08, 0.14, he_land(n));
  vec2 cell = vec2(lon * cos(lat), lat) * 44.0 / PI;
  float dots = smoothstep(0.34, 0.16, length(fract(cell) - 0.5));
  float gl = max(smoothstep(0.03, 0.0, abs(fract(lat * 6.0 / PI + 0.5) - 0.5)),
                 smoothstep(0.03, 0.0, abs(fract(lon * 6.0 / PI + 0.5) - 0.5)));
  float scan = exp(-pow((n.y - (1.0 - 2.4 * fract(uPulse * 0.3)) + 0.2) / 0.04, 2.0));
  float lit = land * dots * (0.9 + 0.6 * scan) + (1.0 - land) * 0.05 + gl * 0.22 + scan * 0.35;
  vec3 col = base * lit + vec3(1.0) * scan * land * dots * 0.5;
  return vec4(col * 0.8, clamp(lit, 0.0, 1.0));
}
