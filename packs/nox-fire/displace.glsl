// Nox Fire by Matt Vianueva, https://www.shadertoy.com/view/wfG3Dz
// MIT License (relicensed by permission), see THIRD_PARTY.md. The tunnel's turbulence and
// noise loop now push the flame outward instead of carving a tunnel.
vec3 displace(vec3 p) {
  vec3 n = normalize(p);
  float t = uTime;
  vec3 q = p * 3.0 + vec3(0.0, 0.0, t * 1.5);
  q += cos(q.z + t + q.yzx * 0.5) * 0.6;                  // turbulence
  float s = 0.0;
  for (float k = 1.6; k < 16.0; k += k)
    s += abs(dot(sin(q.z + t + q * k), vec3(1.12))) / k;  // noise loop
  return p + n * (s - 0.9) * uMax * (0.5 + 1.2 * uAmp);
}
