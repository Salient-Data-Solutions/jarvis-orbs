// Hexagon Plasma by Nemerix, https://www.shadertoy.com/view/3fy3z3
// MIT License, see THIRD_PARTY.md. Ported nearly line for line: each dot of the disc is one pixel
// of the original, and its colour map leans toward your accent.
float hp_sqr(float x) { return x * x; }
float hp_hex(vec2 pos) {
  return max(max(abs(dot(pos, vec2(0.0, 2.0))), abs(dot(pos, vec2(1.732, 1.0)))), abs(dot(pos, vec2(1.732, -1.0))));
}
float hp_smooth(vec2 pos) {
  return mix(hp_sqr(hp_hex(pos)), dot(pos, pos), smoothstep(0.8, 1.5, dot(pos, pos)));
}
vec4 shade(vec3 base) {
  const mat2 R = mat2(0.6, 0.8, -0.8, 0.6);
  vec2 uv = vPos.xy * 1.3;
  float d = sqrt(abs(hp_smooth(uv) - 1.0));
  vec2 samp = uv * d;
  float y = 0.0, scale = 1.0;
  for (int i = 0; i < 4; ++i) {
    samp = sin(R * samp * hp_hex(samp) + vec2(uTime * (1.0 + 1.5 * uAmp)));
    y += scale * samp.x * samp.y;
    scale *= 0.75;
  }
  vec3 cmap = mix(mix(vec3(0.1, 0.6, 0.8), base, 0.5), vec3(0.5), 0.7 * tanh(dot(uv, uv)));
  vec3 col = tanh(0.1 * cmap / max(abs(y), 1e-3));
  return vec4(col * 1.3, clamp(length(col), 0.1, 1.0));
}
