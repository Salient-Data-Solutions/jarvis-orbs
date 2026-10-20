# Jarvis orb packs

New looks for the orb in Jarvis, the macOS voice assistant.

## Install one

1. Open Jarvis, then **Settings → Look → Orb packs**.
2. Copy a pack's install link from the table below, paste it into the link box, and press **Install**.
   Or download the `.zip` from [`dist/`](dist) and use **Install from file…**.
3. Press **Use** on the new card.

| Pack | What it looks like | Based on | Install link |
|---|---|---|---|
| **Arc Reactor Mk II** | A face-on reactor: a bright triangle, ten spokes and rings that pulse outward as you speak. | original | `https://raw.githubusercontent.com/Salient-Data-Solutions/jarvis-orbs/main/dist/arc-reactor-mk-ii.zip` |
| **Cells** | Living Voronoi cells with glowing borders that swell and divide as you speak. | [A Cellular Texture Basis Function (SIGGRAPH 1996)](https://dl.acm.org/doi/10.1145/237170.237267) by Steven Worley (algorithm) | `https://raw.githubusercontent.com/Salient-Data-Solutions/jarvis-orbs/main/dist/cells.zip` |
| **Gimbal Harmonics** | Fifteen nested half-rings, each turning at its own harmonic of the one outside it. | [Gimbal Harmonics](https://www.shadertoy.com/view/llS3zd) by Otavio Good (CC0) | `https://raw.githubusercontent.com/Salient-Data-Solutions/jarvis-orbs/main/dist/gimbal-harmonics.zip` |
| **Helix** | A twin data stream spiralling upward, pulses climbing it while you talk. | original | `https://raw.githubusercontent.com/Salient-Data-Solutions/jarvis-orbs/main/dist/helix.zip` |
| **Hexagon Plasma** | A hexagonal lens of interference plasma, rippling faster as you speak. | [Hexagon Plasma](https://www.shadertoy.com/view/3fy3z3) by Nemerix (MIT) | `https://raw.githubusercontent.com/Salient-Data-Solutions/jarvis-orbs/main/dist/hex-plasma.zip` |
| **Iris** | A mechanical aperture: eight blades that open as your voice rises. | original | `https://raw.githubusercontent.com/Salient-Data-Solutions/jarvis-orbs/main/dist/iris.zip` |
| **Lava** | The classic three.js lava shader wrapped around a sphere: molten crust that flows faster as you speak. | [webgl_shader_lava](https://github.com/mrdoob/three.js/blob/dev/examples/webgl_shader_lava.html) by three.js authors (MIT) | `https://raw.githubusercontent.com/Salient-Data-Solutions/jarvis-orbs/main/dist/lava.zip` |
| **Nox Fire** | A ball of turbulent flame: layered sine noise that roars hotter when you speak. | [Nox Fire](https://www.shadertoy.com/view/wfG3Dz) by Matt Vianueva (MIT) | `https://raw.githubusercontent.com/Salient-Data-Solutions/jarvis-orbs/main/dist/nox-fire.zip` |
| **Plasma** | A churning ball of charged gas, hotter and faster when you speak. | original | `https://raw.githubusercontent.com/Salient-Data-Solutions/jarvis-orbs/main/dist/plasma.zip` |
| **Ringworld** | Gyroscope rings at every angle, rippling like plucked strings when you speak. | original | `https://raw.githubusercontent.com/Salient-Data-Solutions/jarvis-orbs/main/dist/ringworld.zip` |
| **Star Nest** | Kali's famous volumetric star field, folded inside the orb and brightening as you speak. | [Star Nest](https://www.shadertoy.com/view/XlfGRj) by Pablo Roman Andrioli (Kali) (MIT) | `https://raw.githubusercontent.com/Salient-Data-Solutions/jarvis-orbs/main/dist/star-nest.zip` |
| **Tesseract** | A four-dimensional cube turning through itself, its edges flaring when you talk. | original | `https://raw.githubusercontent.com/Salient-Data-Solutions/jarvis-orbs/main/dist/tesseract.zip` |
| **Topologica** | Electric filaments where two slow noise fields cross, crackling brighter when you speak. | [Topologica](https://www.shadertoy.com/view/4djXzz) by Otavio Good (CC0) | `https://raw.githubusercontent.com/Salient-Data-Solutions/jarvis-orbs/main/dist/topologica.zip` |
| **Universe Ball** | A gem-faceted cosmos that folds and twists through itself, its colours cycling as you talk. | [Universe Ball 2](https://www.shadertoy.com/view/WcGcWV) by Matt Vianueva (MIT) | `https://raw.githubusercontent.com/Salient-Data-Solutions/jarvis-orbs/main/dist/universe-ball.zip` |

Packs ported from other people's shaders credit them in `orb.json` (`credit`) and at the top of
each shader. Only code under a licence that allows it (MIT, CC0) is ported; the full notices are in
[THIRD_PARTY.md](THIRD_PARTY.md).

## Why a pack is safe to install

A pack is **data, not a program**: a manifest and up to two small GLSL shaders that run on the graphics card. Jarvis
refuses anything else.
- A pack can't run JavaScript, so it can't reach the page, the network, your files or your terminals.
- Jarvis writes its own `main()` around your shaders and clamps every displacement, so a pack can't push the orb
  out of frame.
- If a shader fails to compile, Jarvis falls back to the default orb and shows the compiler message.

## Make one

A pack is a folder in `packs/` holding only these files, each at most 64 KB:

| File | Required | What it is |
|---|---|---|
| `orb.json` | yes | name, author, version, description, base shape, parameters, colours |
| `displace.glsl` | no | `vec3 displace(vec3 p)`: where each point of the base shape moves to |
| `shade.glsl` | no | `vec4 shade(vec3 base)`: the colour and alpha of each point |

```json
{
  "name": "Iris",
  "author": "Jarvis",
  "version": "1",
  "description": "A mechanical aperture: eight blades that open as your voice rises.",
  "base": "disc",
  "params": { "density": 30, "spinZ": -0.05, "wobble": 0.1, "alpha": 1.0, "size": 2.6 },
  "colors": { "accent": "#59ffd0", "thinking": "#ffd166" }
}
```

- **`base`**: `points`, `shell`, `wire`, `disc`, `orbits`, `helix` or `hypercube`.
- **`params`** (each clamped to its range): `density` 6–40, `spin` 0–3, `spinY` −2–2, `spinZ` −2–2,
  `ripple` 0.3–1.8, `wobble` 0–1, `pointSize` 0.5–2.2, `size` 0.5–4, `alpha` 0.05–1, `core` 0–1.6.
- **`colors`**: `accent` and `thinking` as `#rrggbb`.

What your shaders can read:

| Name | What it is |
|---|---|
| `uTime` | seconds, for motion |
| `uAmp` | how loudly Jarvis is speaking, 0 to about 1.4 |
| `uMic` | the microphone level while you talk, 0–1 |
| `uPulse` | a phase that runs faster while Jarvis speaks; use `fract(uPulse)` for outward rings |
| `uMax` | the largest displacement allowed (Jarvis clamps to it anyway) |
| `uTint`, `uHot` | the accent and highlight colours |
| `vPos` | the point's position, in `shade` |
| `snoise(vec3)` | 3D simplex noise |

Example, from Plasma:

```glsl
vec3 displace(vec3 p) {
  vec3 n = normalize(p);
  float t = uTime * (0.5 + uAmp);
  float d = snoise(n * 2.5 + t) + 0.5 * uAmp * snoise(n * 6.0 - t * 1.7);
  return p + n * d * uMax * (0.6 + uAmp * 1.6);
}
```

## Share one

**Settings → Look → Share this look** saves your current look as a pack in Downloads. To add it here:
1. Fork this repo.
2. Unzip your pack into `packs/<name>/`, using lowercase letters, digits and dashes for the name.
3. Run `python3 build.py`, which checks the pack and writes `dist/<name>.zip`.
4. Open a pull request with both, and add a row to the table above.

Porting someone else's shader? Check its licence first (Shadertoy's default, CC BY-NC-SA, does not allow it
here), add a `credit` to `orb.json`, and add its notice to THIRD_PARTY.md.
