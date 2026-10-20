// Edges flare with his voice; a light runs along each one.
vec4 shade(vec3 base) {
  float run = fract(length(vPos) * 3.0 - uTime * 0.6);
  float spark = smoothstep(0.92, 1.0, run);
  return vec4(base * (1.3 + 0.8 * uAmp) + vec3(spark * 0.8), 0.8 + 0.2 * spark);
}
