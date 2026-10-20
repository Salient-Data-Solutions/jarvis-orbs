// three.js examples/webgl_shader_lava.html, (c) three.js authors, MIT License, see THIRD_PARTY.md.
// Ported to a sphere: the two texture lookups (a noise texture and a lava tile) are replaced by
// simplex noise in 3D, and the original's colour arithmetic is kept as is.
vec4 shade(vec3 base) {
  float time = uTime * (1.0 + 2.0 * uAmp);
  vec3 q = vPos * 1.5;
  vec3 noise = vec3(snoise(q), snoise(q + 17.0), snoise(q + 31.0)) * 0.5 + 0.5;
  vec3 T1 = q + vec3(1.5, -1.5, 0.0) * time * 0.02;
  vec3 T2 = q + vec3(-0.5, 2.0, 0.0) * time * 0.01;
  T1.xy += noise.xy * 2.0;
  T2.xy += vec2(-noise.y, noise.z) * 0.2;
  float p = snoise(T1 * 2.0) * 0.5 + 0.5;
  float k = snoise(T2 * 2.0) * 0.5 + 0.5;
  vec4 color = vec4(mix(vec3(0.35, 0.03, 0.0), mix(vec3(1.0, 0.35, 0.05), base, 0.3), k), 1.0);
  vec4 temp = color * (vec4(p) * 2.0) + (color * color - 0.1);
  if (temp.r > 1.0) temp.bg += clamp(temp.r - 2.0, 0.0, 100.0);
  if (temp.g > 1.0) temp.rb += temp.g - 1.0;
  if (temp.b > 1.0) temp.rg += temp.b - 1.0;
  return vec4(temp.rgb, 1.0);
}
