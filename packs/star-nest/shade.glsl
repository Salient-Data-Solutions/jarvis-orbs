// Star Nest by Pablo Roman Andrioli (Kali), https://www.shadertoy.com/view/XlfGRj
// MIT License, see THIRD_PARTY.md. Ported to a Jarvis orb pack: the kaliset is marched along a
// short ray through each point of the shell instead of one ray per screen pixel.
vec4 shade(vec3 base) {
  vec3 dir = normalize(vPos + 1e-4);
  float time = uTime * 0.01 + 0.25;
  vec3 from = vec3(1.0, 0.5, 0.5) + vec3(time * 2.0, time, -2.0);
  float s = 0.1, fade = 1.0;
  vec3 v = vec3(0.0);
  for (int r = 0; r < 10; r++) {
    vec3 p = from + s * dir * 0.5;
    p = abs(vec3(0.85) - mod(p, vec3(1.7)));               // tiling fold
    float pa = 0.0, a = 0.0;
    for (int i = 0; i < 15; i++) {
      p = abs(p) / dot(p, p) - 0.53;                       // the magic formula
      a += abs(length(p) - pa);
      pa = length(p);
    }
    float dm = max(0.0, 0.3 - a * a * 0.001);              // dark matter
    a *= a * a;
    if (r > 4) fade *= 1.0 - dm;
    v += fade;
    v += vec3(s, s * s, s * s * s * s) * a * 0.0015 * fade;
    fade *= 0.73;
    s += 0.2;                                               // ten steps cover the original's twenty
  }
  v = mix(vec3(length(v)), v, 0.85) * 0.028 * (1.0 + 0.8 * uAmp);
  vec3 col = mix(v, v * base * 1.6, 0.25);
  return vec4(col * 1.2, clamp(pow(length(col), 2.0), 0.0, 1.0));   // dark space stays see-through
}
