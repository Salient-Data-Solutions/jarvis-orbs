# Jarvis orb packs

New looks for the orb in Jarvis, the macOS voice assistant.

## Install one

1. Open Jarvis, then **Settings → Look → Orb packs**.
2. Copy a pack's install link from the table below, paste it into the link box, and press **Install**.
   Or download the `.zip` from [`dist/`](dist) and use **Install from file…**.
3. Press **Use** on the new card.

| Pack | What it looks like | Base | Install link |
|---|---|---|---|
| **Arc Reactor Mk II** | A face-on reactor: a bright triangle, ten spokes and rings that pulse outward as you speak. | `disc` | `https://raw.githubusercontent.com/Salient-Data-Solutions/jarvis-orbs/main/dist/arc-reactor-mk-ii.zip` |
| **Helix** | A twin data stream spiralling upward, pulses climbing it while you talk. | `helix` | `https://raw.githubusercontent.com/Salient-Data-Solutions/jarvis-orbs/main/dist/helix.zip` |
| **Iris** | A mechanical aperture: eight blades that open as your voice rises. | `disc` | `https://raw.githubusercontent.com/Salient-Data-Solutions/jarvis-orbs/main/dist/iris.zip` |
| **Plasma** | A churning ball of charged gas, hotter and faster when you speak. | `points` | `https://raw.githubusercontent.com/Salient-Data-Solutions/jarvis-orbs/main/dist/plasma.zip` |
| **Ringworld** | Gyroscope rings at every angle, rippling like plucked strings when you speak. | `orbits` | `https://raw.githubusercontent.com/Salient-Data-Solutions/jarvis-orbs/main/dist/ringworld.zip` |
| **Tesseract** | A four-dimensional cube turning through itself, its edges flaring when you talk. | `hypercube` | `https://raw.githubusercontent.com/Salient-Data-Solutions/jarvis-orbs/main/dist/tesseract.zip` |

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
