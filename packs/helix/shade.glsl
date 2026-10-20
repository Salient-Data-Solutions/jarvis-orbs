// Packets of light climb the strands; faster and brighter with his voice.
vec4 shade(vec3 base) {
  float climb = fract(vPos.y * 1.5 - uPulse * 0.8);
  float packet = smoothstep(0.85, 1.0, climb);
  return vec4(base * (1.0 + 0.6 * uAmp) + uHot * packet, 0.7 + 0.3 * packet);
}
