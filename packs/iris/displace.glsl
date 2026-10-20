// The blades draw back from the centre as he speaks or the mic hears him.
vec3 displace(vec3 p) {
  float r = length(p.xy);
  float open = clamp(uAmp * 0.8 + uMic * 1.5, 0.0, 1.0);
  return p + vec3(normalize(p.xy + 1e-4) * open * (1.0 - r), 0.0);
}
