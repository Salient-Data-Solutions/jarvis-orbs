// Rings breathe outward from the centre with his voice.
vec3 displace(vec3 p) {
  float r = length(p.xy);
  float wave = sin(r * 14.0 - uPulse * 6.0) * 0.5 + 0.5;
  return p + vec3(normalize(p.xy + 1e-4) * wave * uAmp * 0.25, 0.0);
}
