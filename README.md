# ΩMEGA Engine SDK (2007) — Preservation Archive

> Digital preservation of a Russian 2D game engine by Andru 'aka' Кемка Андрей

[![License: BSD-like](https://img.shields.io/badge/license-BSD--like-blue.svg)](LICENSE)
[![Language: Pascal](https://img.shields.io/badge/language-Pascal-blue.svg)](https://en.wikipedia.org/wiki/Object_Pascal)
[![Language: C++](https://img.shields.io/badge/language-C++-blue.svg)](https://en.wikipedia.org/wiki/C%2B%2B)
[![Platform: Windows](https://img.shields.io/badge/platform-Windows-blue.svg)](https://windows.microsoft.com)

---

## 📜 Overview

**OMEGA Engine** is a lightweight 2D game engine developed by **Andru 'aka' Кемка Андрей** (iSADA Team) between 2005-2006. It features dual-backend rendering (DirectX 8 / OpenGL 1.1), sprite management, bitmap fonts, audio playback, collision detection, and a GUI system.

This repository is a **preservation archive** of the original SDK, recovered from the Internet Archive's Wayback Machine (original source: `isada.mirgames.ru`, captured 2007-02-07).

### Key Features

| Feature | Implementation |
|---------|---------------|
| **Rendering** | DirectX 8 (`d3d8.dll`) / OpenGL 1.1 (`opengl32.dll`, `glu32.dll`) |
| **Languages** | Delphi 3-2006, Free Pascal, C++, C# |
| **Calling Convention** | `stdcall` (Pascal default for exports) |
| **Platform** | Windows (x86) |
| **Texture Formats** | BMP, JPG, GIF (static), TGA, WMF, ICO |
| **Font Format** | Custom `.ofi` (bitmap texture + glyph metrics) |
| **Audio** | DirectSound (Win) / OpenAL (Linux via plugin) |
| **Input** | Keyboard, Mouse, Joystick (DirectInput) |
| **Collision** | AABB, Circle, Line, PolyLine tests |
| **Effects** | Blur, Radial Blur, Color Mix, Vertex Color Alpha, Scaling, Flipping |

---

## ⚠️ Legal & License

### Original License (BSD-Like Custom)

```text
Copyright (c) 2005-2006, Andru 'aka' Кемка Андрей

Redistribution and use permitted under the following conditions:

1. Retain copyright notice, this list of conditions, and disclaimer.
2. Commercial use requires prior written permission from the author.
3. Non-commercial products must include copyright attribution.

THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND.
```

### Archive Preservation Copyright

```text
Copyright (c) 2026, Kostya Karavaytsev (KostyaTheSon) — preservation work
```

### Usage Permissions

| Use Case | Status |
|----------|--------|
| **Personal / Educational** | ✅ Allowed with attribution |
| **Non-Commercial Projects** | ✅ Allowed with attribution |
| **Commercial Projects** | ❌ Requires written permission from original author |
| **Redistribution** | ✅ Allowed with full license text retained |

> **Important**: This is **NOT standard BSD 2-Clause**. Commercial use is restricted. See `LICENSE` for full terms.

---

## 👥 Credits

| Role | Name | Contact |
|------|------|---------|
| **Original Author** | Andru 'aka' Кемка Андрей | `dr.andru@gmail.com`, `Andru_@list.ru` |
| **Team** | iSADA Team | `http://isada.mirgames.ru` (defunct) |
| **Preservation Archive** | Kostya Karavaytsev (KostyaTheSon) | This repository |
| **Demo Contributors** | Шпилько Константин 'aka' Armorer (Color Tetris) | — |

---

## 📦 Archive Contents

```text
omega-engine-sdk/
├── LICENSE                  # Original BSD-like license + preservation notice
├── README.md                # This file
├── bin/                     # Precompiled DLLs (ENG/RUS)
│   ├── ENG/OMEGA.dll        # English locale DLL
│   └── RUS/OMEGA.dll        # Russian locale DLL
├── demos/                   # Example projects
│   ├── C++/                 # 14 C++ demo projects
│   ├── Delphi/              # 15 Delphi demo projects
│   ├── C#/                  # C# binding demo
│   └── готовые мини-игры/   # Ready mini-games (Color Tetris, Invaders Attack)
├── headers/                 # API headers
│   ├── C++/                 # OMEGA_code.cpp, OMEGA_functions.h, OMEGA_types.h
│   ├── Delphi/              # OMEGA.pas, PLUGIN.pas
│   └── C#/                  # OMEGA.cs
├── units/                   # Engine source code (Pascal)
│   ├── Delphi/uSpriteEngine.pas  # Core sprite system
│   └── Delphi/uGUIEngine.pas     # GUI abstraction layer
│   ├── C++/uSpriteEngine.cpp     # C++ sprite wrapper
│   └── C++/uSpriteEngine.h
├── help/                    # Documentation
│   └── OEHelp.chm           # API reference (decompile with 7z/chmcmd)
├── utilities/               # Tools
│   └── FontGen/             # .ofi font generator + format spec
│       ├── FontGen.exe
│       └── OFI-format.txt
├── plugin sample/           # Plugin development example (Vertex Light)
│   ├── VL.dpr
│   ├── VL_Header.pas
│   └── SAMPLE/Project1.dpr
└── media/                   # Assets for demos
    ├── *.tga, *.bmp, *.gif, *.jpg  # Textures
    ├── *.wav, *.mid                # Audio
    └── FontInfo.ofi, consoleFontInfo.ofi  # Font metrics
```

---

## 🛠️ Technical Specifications

### Engine Architecture

```
┌─────────────────────────────────┐
│        Application Code         │
│  (C++ / Delphi / C# demos)      │
└─────────┬───────────────────────┘
          │ calls
┌─────────▼───────────────────────┐
│      OMEGA.dll (Export API)     │
│  • Tex_*  — Texture management  │
│  • Snd_*  — Audio playback      │
│  • Key_*  — Input handling      │
│  • Pr2D_* — 2D primitives       │
│  • Col_*  — Collision tests     │
│  • FX_*   — Visual effects      │
└─────────┬───────────────────────┘
          │ wraps
┌─────────▼───────────────────────┐
│   Backend: DirectX 8 or OpenGL  │
│   • d3d8.dll / opengl32.dll     │
│   • ddraw.dll / glu32.dll       │
│   • winmm.dll (timers)          │
│   • dsound.dll / openal32.dll   │
└─────────────────────────────────┘
```

### Core Data Structures

#### Texture (`TTexture` / `PTexture`)
```c
struct TTexture {
    DWORD ID;              // Internal GPU handle
    int Width, Height;     // Dimensions
    float U, V;            // Texture coordinates
    int Flags;             // TEX_* flags
    WORD FramesX, FramesY; // Animation frame grid
    DWORD Reserved;
};
```

#### Font (`TFont2D` / `PFont2D`)
```c
struct TSymbol {
    WORD X, Y;      // Glyph position in texture atlas
    BYTE Width;     // Glyph advance width
};

struct TFont2D {
    BYTE Height;                // Font height in pixels
    TSymbol Sizes[256];         // Glyph metrics table
    PTexture Texture;           // Bitmap atlas
    DWORD Reserved;
};
```

#### 2D Camera (`TCamera2D` / `PCamera2D`)
```c
struct TCamera2D {
    int X, Y;      // View offset
    bool Active;   // Enable/disable camera transform
    DWORD Reserved;
};
```

#### Collision Shapes
```c
// Axis-Aligned Bounding Box
struct TAABB2D { int X, Y, Width, Height; };

// Circle
struct TCircle2D { int cX, cY, Radius; };

// PolyLine (polygon contour)
struct TPolyLine2D {
    DWORD Count;
    int cX, cY;           // Centroid (cached)
    PPoint2D Points;      // Array of vertices
};
```

---

## 📡 API Reference

### Engine Lifecycle

| Function | Description |
|----------|-------------|
| `OE_Init(zBits, stencilBits)` | Initialize engine with Z-buffer/stencil bits |
| `OE_Init2(hwnd)` | Initialize with external window handle |
| `OE_Quit()` | Shutdown engine and release resources |
| `OE_RegProcedure(type, proc)` | Register system callbacks (`SYS_INIT`, `SYS_DRAW`, etc.) |
| `OE_GetFPS()` | Get current frames per second |

### Texture Management

| Function | Description |
|----------|-------------|
| `Tex_LoadFromFile(path, colorkey, flags)` | Load texture from disk |
| `Tex_LoadFromMemory(mem, type, colorkey, flags)` | Load texture from memory buffer |
| `Tex_Free(tex)` | Free texture resources |
| `Tex_SetFramesSize(tex, fw, fh)` | Define animation frame dimensions |
| `Tex_LoadMaskFromFile(path)` | Load alpha mask texture |
| `Tex_BeginRenderIn(tex, save, realsize)` | Start render-to-texture |
| `Tex_EndRenderIn()` | End render-to-texture |

### Sprite Rendering

| Function | Description |
|----------|-------------|
| `SSprite_Draw(tex, x, y, w, h, alpha, angle, flags)` | Draw static sprite |
| `ASprite_Draw(tex, x, y, w, h, frame, alpha, angle, flags)` | Draw animated sprite (frame index) |
| `CSprite_Draw(tex, x, y, w, h, rect, alpha, angle, flags)` | Draw cropped sprite region |
| `STile_Draw(tex, x, y, w, h, tilesX, tilesY, alpha, flags)` | Draw static tilemap |
| `ATile_Draw(tex, x, y, w, h, tilesX, tilesY, frame, alpha, flags)` | Draw animated tilemap |

### Font Rendering

| Function | Description |
|----------|-------------|
| `Text_LoadFontFromFile(texPath, ofiPath, colorkey, flags)` | Load bitmap font |
| `Text_Draw(font, x, y, text, scale, step, alpha, color)` | Render text string |
| `Text_GetWidth(font, text, scale, step)` | Calculate text width in pixels |

### Input Handling

| Function | Description |
|----------|-------------|
| `Key_Down(keycode)` | Check if key is held |
| `Key_Press(keycode)` | Check if key was pressed this frame |
| `Key_BeginReadText(start)` | Begin text input mode |
| `Key_EndReadText()` | End text input, return string |
| `Mouse_X()`, `Mouse_Y()` | Get cursor position |
| `Mouse_Down(button)`, `Mouse_Click(button)` | Mouse button state |
| `Joy_Down(joy, button)` | Joystick button state |

### 2D Primitives

| Function | Description |
|----------|-------------|
| `Pr2D_Pixel(x, y, color, alpha)` | Draw single pixel |
| `Pr2D_Line(x1, y1, x2, y2, color, alpha, flags)` | Draw line (PR_SMOOTH for anti-alias) |
| `Pr2D_Rect(x, y, w, h, color, alpha, flags)` | Draw rectangle (PR_FILL for filled) |
| `Pr2D_Circle(cx, cy, r, color, alpha, quality, flags)` | Draw circle |
| `Pr2D_Ellipse(cx, cy, rx, ry, color, alpha, quality, flags)` | Draw ellipse |
| `Pr2D_Polygon(points, count, color, alpha, flags)` | Draw convex polygon |

### Visual Effects

| Function | Description |
|----------|-------------|
| `FX_SetColorMix(color)` | Set global color tint |
| `FX_SetBlendMode(mode)` | Set blend mode (`FX_BLEND_ADD`, `FX_BLEND_MASK`, etc.) |
| `FX_SetScale(sx, sy)` | Set sprite scaling factor |
| `FX_Blur_SetTex(tex)`, `FX_Blur_SetParams(count, dx, dy)` | Configure blur effect |
| `FX_Blur_Calc(renderProc, delta, alpha, blend)` | Pre-calculate blur frames |
| `FX_Blur_Draw(color, alpha)` | Render blur overlay |
| `FX_RadBlur_*` | Radial blur variants |

### Collision Detection

| Function | Description |
|----------|-------------|
| `Col_AABB(a, b)` | AABB vs AABB test |
| `Col_Circle(a, b)` | Circle vs Circle test |
| `Col_LineVsAABB(line, aabb)` | Line segment vs AABB |
| `Col_PolyLine(a, b)` | PolyLine vs PolyLine test |
| `ColEx_PolyMove(src, dst, dx, dy)` | Transform PolyLine by translation |
| `ColEx_PolyRotate(src, dst, angle)` | Transform PolyLine by rotation |
| `ColEx_PolyScale(src, sx, sy)` | Transform PolyLine by scaling |

### Utility Functions

| Function | Description |
|----------|-------------|
| `M_Cos(angle)`, `M_Sin(angle)` | Fast trigonometry (fixed-point angles) |
| `M_Round(value)`, `M_Trunc(value)` | Fast float→int conversion |
| `M_Distance(x1, y1, x2, y2)` | Euclidean distance |
| `M_FindAngle(x1, y1, x2, y2)` | Angle between two points |
| `U_GetCPUName()`, `U_GetTotalRAM()` | Hardware info queries |
| `U_IntToStr(num)`, `U_StrToInt(str)` | String conversion |
| `U_GetTime()` | High-resolution timer (milliseconds) |

---

## 🚀 Quick Start (C++)

```cpp
#include "headers/C++/OMEGA_code.cpp"
#include "headers/C++/OMEGA_functions.h"

PTimer gameTimer;
PTexture logoTex;

void Load() { /* Fast init: load loading screen */ }
void Init() {
    logoTex = Tex_LoadFromFile("media/Logo.gif", 0xFFFFFF, TEX_DEFAULT_2D);
}
void Draw() {
    SSprite_Draw(logoTex, 400-64, 300-64, 128, 128, 255, 0, FX_DEFAULT);
}
void Quit() { /* Cleanup */ }
void Timer1() {
    if (Key_Down(K_ESCAPE)) OE_Quit();
}

int main() {
    LoadOMEGA();  // Resolve DLL exports via GetProcAddress
    gameTimer = Timer_Create((void*)Timer1, 16, 0);  // ~60 FPS
    OE_RegProcedure(SYS_FASTINIT, (void*)Load);
    OE_RegProcedure(SYS_INIT, (void*)Init);
    OE_RegProcedure(SYS_DRAW, (void*)Draw);
    OE_RegProcedure(SYS_QUIT, (void*)Quit);
    OE_SetScreenOptions(800, 600, 32, 0, false, true);  // Windowed, vsync
    OE_Init();  // Enter main loop
    return 0;
}
```

### Build Instructions (MinGW)

```bash
# Install toolchain (Arch Linux)
sudo pacman -S mingw-w64-gcc mingw-w64-crt-git

# Compile
i686-w64-mingw32-g++ -I./headers/C++ -L./bin/ENG \
  -l:OMEGA.dll -static-libgcc -static-libstdc++ \
  main.cpp -o demo.exe

# Run under Wine (Linux) or natively (Windows)
wine demo.exe
```

### Build Instructions (Delphi / Free Pascal)

```bash
# Install Free Pascal
sudo pacman -S fpc  # Arch
# or download from https://www.freepascal.org/

# Compile demo
cd demos/Delphi/01-Запуск\ движка/
fpc Demo.dpr -Fu../../headers/Delphi -Fu../../units/Delphi

# Run
./Demo.exe
```

---

## 🎮 Demo Projects

| Demo | Description | Languages |
|------|-------------|-----------|
| `01-Запуск движка` | Basic engine initialization | C++, Delphi, C# |
| `02-Текстуры` | Texture loading, effects, masks | C++, Delphi |
| `03-Текст` | Bitmap font rendering | C++, Delphi |
| `04-Примитивы` | 2D primitives (lines, rects, circles) | C++, Delphi |
| `05-Спрайты` | Static/animated sprites | C++, Delphi |
| `06-Тайлы` | Tilemap rendering | C++, Delphi |
| `07-Эффекты и спрайты` | Blend modes, color mix, scaling | C++, Delphi |
| `08-Устройства ввода` | Keyboard, mouse, joystick input | C++, Delphi |
| `09-2D-Камера` | Camera system with view offset | C++, Delphi |
| `10-2D-Звук` | 2D positional audio | C++, Delphi |
| `11-Медиафайлы` | Video/audio playback via DirectShow | C++, Delphi |
| `12-Консоль` | Debug console with commands | C++, Delphi |
| `13-Collision` | PolyLine collision detection | C++, Delphi |
| `14-Пост & Просто эффекты` | Blur, radial blur, mask effects | C++, Delphi |
| `15-GUI` | GUI system (buttons, labels, edits) | Delphi only |
| `Color Tetris` | Tetris clone (by Шпилько Константин) | C++, Delphi |
| `Invaders Attack` | Space Invaders clone | Delphi |

---

## 📄 Format Specifications

### `.ofi` Font Format

The `.ofi` file contains glyph metrics for a bitmap font texture.

```c
#pragma pack(push, 1)
typedef struct {
    uint16_t GlyphCount;    // Usually 256 (full ASCII/CP1251)
    uint8_t CharWidth;      // Fixed width (0 = variable-width)
    uint8_t CharHeight;     // Font height in pixels
    uint32_t BitmapOffset;  // Offset to pixel data in associated texture
    // Followed by: uint8_t WidthTable[GlyphCount] — advance widths
    // Then: bitmap pixel data (indexed or RGBA, defined by texture)
} OFIHeader;
#pragma pack(pop)
```

**Usage**:
1. Load texture with `Tex_LoadFromFile("font.gif", 0, TEX_DEFAULT_2D)`
2. Load metrics with `Text_LoadFontFromFile("font.gif", "font.ofi", 0, TEX_DEFAULT_2D)`
3. Render with `Text_Draw(font, x, y, "Hello", 1.0, 0, 255, 0xFFFFFF)`

See `utilities/FontGen/OFI-format.txt` for full specification.

---

## 🔌 Plugin System

OMEGA Engine supports runtime plugins via `PLUGIN.pas` / `PLUGIN.h`.

### Plugin API

```pascal
// PLUGIN.pas
function P_GetParams(What: Integer): Pointer; external OMEGA_DLL;
function Tex_PostProcess(var pData: Pointer; var Info: TTexture; 
                         TransparentColor: Integer): PTexture; stdcall; external OMEGA_DLL;
```

### Example: Vertex Light Plugin (`plugin sample/`)

The included `VL.dll` plugin demonstrates:
- Accessing engine internals via `P_GetParams(gCURRENT_CAM2D)`
- Post-processing textures with custom OpenGL effects
- Managing dynamic light sources with collision-aware attenuation

---

## 🔍 Reverse Engineering Notes

### DLL Structure

The provided `OMEGA.dll` binaries contain a runtime unpacker stub:

* **Entry Point**: Performs XOR-based decryption of code segment
* **Protection**: `VirtualProtect` calls to mark memory executable post-decryption
* **API Resolution**: Dynamic loading via `LoadLibraryA` and `GetProcAddress`
* **Imports**: `opengl32.dll`, `glu32.dll`, `d3d8.dll`, `ddraw.dll`, `winmm.dll`, `dsound.dll`

### Decryption Stub (Observed Behavior)

```c
// Pseudocode of unpacker logic
void* entry = DAT_0041b000;  // Encrypted section
for (int i = 0; i < size; i += 4) {
    uint32_t* p = (uint32_t*)(entry + i);
    *p = (*p >> 3) | (*p << 29);  // Rotate right by 3
}
VirtualProtect(entry, size, PAGE_EXECUTE_READ, &old);
((void(*)())entry)();  // Jump to decrypted code
```

The source code in `units/` corresponds to the **decrypted logic** — no need to reverse the stub manually.

---

## 🗂️ Related Projects

| Project | Description | Link |
|---------|-------------|------|
| **ZenGL** | Modern successor by same author (OpenGL ES, cross-platform) | [github.com/goldsmile/zengl](https://github.com/goldsmile/zengl) |
| **Алмазные Бойцы** | Commercial game using OMEGA Engine (MyPlayCity.ru) | — |
| **Color Tetris** | Demo game included in SDK (by Шпилько Константин) | `demos/готовые мини-игры/` |

---

## 📬 Contact

| Purpose | Contact |
|---------|---------|
| **Original Author** | `dr.andru@gmail.com` (may be inactive) |
| **Archive Maintainer** | `KostyaTheSon` (GitHub) |
| **Wayback Source** | [isada.mirgames.ru/files/omega/](https://web.archive.org/web/20070207000000/http://isada.mirgames.ru/files/omega/) |

---

## 🏛️ Preservation Notes

* **Archive Date**: 2026-03-15
* **Source**: Internet Archive Wayback Machine
* **Original Release**: 2007-02-07
* **Development Period**: 2005-2006
* **Status**: Abandonware (author unreachable, domain defunct)

This archive is provided for **historical preservation, education, and research**. All rights to the original engine code remain with Andru 'aka' Кемка Андрей.

---

## 📚 References

* [Internet Archive: OMEGA Engine SDK](https://archive.org/details/omega_engine) (mirror)
* [ZenGL GitHub](https://github.com/goldsmile/zengl) (successor project)
* [Wayback Machine: isada.mirgames.ru](https://web.archive.org/web/20070207000000/http://isada.mirgames.ru/files/omega/)
* [Free Pascal Compiler](https://www.freepascal.org/)
* [DirectX 8 Documentation (archived)](https://docs.microsoft.com/en-us/previous-versions/windows/desktop/directx8)

---

## ⚖️ Disclaimer

This repository contains **preserved historical software**. The original author has not been contacted for this archive. If you are Andru 'aka' Кемка Андрей or represent iSADA Team and wish to request removal or updates, please contact the archive maintainer.

**No game assets from third-party products are included.** Those remain property of their respective copyright holders.

---

> *Preserved for future generations. Keep the cred, keep the code, keep grinding.* 🛠️📦
