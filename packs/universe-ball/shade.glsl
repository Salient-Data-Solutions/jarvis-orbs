// Universe Ball 2 by Matt Vianueva, https://www.shadertoy.com/view/WcGcWV
// MIT License (relicensed by permission), see THIRD_PARTY.md. The same twist and warp, sampled
// at each point of the shell, with the gem facets as brightness.
vec4 shade(vec3 base) {
  float t = uTime * 0.2 * (1.0 + uAmp);
  vec3 p = vPos * 3.2;
  float s = length(p) - 1.5;
  vec4 c4 = cos(t + p.z * 0.6 + vec4(0.0, 33.0, 11.0, 0.0));
  p.xy *= mat2(c4.x, c4.y, c4.z, c4.w);                  // twist
  p += cos(t + p.zxy) + cos(t + p.yzx * s) / max(abs(s), 0.3) / 4.0;
  p += 0.5 * cos(t + dot(cos(t + p), p) * p);             // warp
  float v = dot(abs(fract(p) - 0.5), vec3(0.04));         // gem facets
  vec3 c = (1.0 + cos(p.z + vec3(6.0, 4.0, 2.0))) * 0.5 * (0.02 / (v + 0.004));   // facet edges burn
  c = tanh(c * c * 0.6);
  c = mix(c, c.yzx, smoothstep(0.2, 1.0, abs(vPos.y)));
  return vec4(mix(c, c * base * 1.4, 0.2), clamp(length(c), 0.2, 1.0));
}
