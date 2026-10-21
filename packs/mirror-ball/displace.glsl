// Mirror Ball: the ball thumps outward on each of your words.
vec3 displace(vec3 p) { return p * (1.0 + uMax * 0.35 * uAmp); }
