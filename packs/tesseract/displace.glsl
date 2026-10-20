// Straight edges: the whole figure swells with his voice instead of rippling.
vec3 displace(vec3 p) {
  return p * (1.0 + 0.12 * uAmp + 0.08 * uMic);
}
