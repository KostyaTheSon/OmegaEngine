# OMEGA Engine SDK (2007) — Preservation Archive (AI Slop-filled README.md)

Digital preservation of a Russian 2D game engine from 2005-2006.

---

## Overview

OMEGA Engine is a 2D game engine developed by Andru aka Kemka Andrey (iSADA Team) between 2005-2006. It features dual-backend rendering (DirectX 8 / OpenGL 1.1), sprite management, bitmap fonts, audio playback, and a GUI system.

This repository is a preservation archive of the original SDK, recovered from the Internet Archive's Wayback Machine (original source: isada.mirgames.ru, captured 2007-02-07).

---

## Legal and License

### Original License (BSD-Like Custom)

Copyright (c) 2005-2006, Andru aka Kemka Andrey

Redistribution and use permitted under the following conditions:

1.  Retain copyright notice, this list of conditions, and disclaimer.
2.  Commercial use requires prior written permission from the author.
3.  Non-commercial products must include copyright attribution.

THIS SOFTWARE IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND.

### Archive Preservation Copyright

Copyright (c) 2026, Kostya Karavaytsev (KostyaTheSon) — preservation work

### Important Notes

| Use Case | Status |
| :--- | :--- |
| Personal / Educational | Allowed with attribution |
| Non-Commercial Projects | Allowed with attribution |
| Commercial Projects | Requires written permission from original author |
| Redistribution | Allowed with full license text retained |

This is NOT standard BSD 2-Clause. Commercial use is restricted. See LICENSE file for full terms.

---

## Credits

| Role | Name | Contact |
| :--- | :--- | :--- |
| Original Author | Andru aka Kemka Andrey | dr.andru@gmail.com, Andru_@list.ru |
| Team | iSADA Team | http://isada.mirgames.ru (defunct) |
| Preservation Archive | Kostya Karavaytsev (KostyaTheSon) | This repository |

---

## Archive Contents

```text
omega-engine-sdk/
├── LICENSE                  # Original BSD-like license + preservation notice
├── README.md                # This file
├── bin/                     # Precompiled DLLs (ENG/RUS)
│   ├── ENG/OMEGA.dll
│   └── RUS/OMEGA.dll
├── demos/                   # Example projects
│   ├── C++/                 # 14 C++ demo projects
│   ├── Delphi/              # 15 Delphi demo projects
│   └── C#/                  # C# binding demo
├── headers/                 # API headers
│   ├── C++/                 # OMEGA_functions.h, OMEGA_types.h
│   ├── Delphi/              # OMEGA.pas
│   └── C#/                  # OMEGA.cs
├── units/                   # Engine source code (Pascal)
│   ├── Delphi/uSpriteEngine.pas
│   └── Delphi/uGUIEngine.pas
├── help/                    # Documentation
│   └── OEHelp.chm           # API reference (decompile with 7z/chmcmd)
├── utilities/               # Tools
│   └── FontGen/             # .ofi font generator + format spec
└── media/                   # Assets for demos
    ├── *.tga, *.bmp, *.gif  # Textures
    ├── *.wav, *.mid         # Audio
    └── FontInfo.ofi         # Font metrics
```

---

## Technical Specifications

| Feature | Implementation |
| :--- | :--- |
| Rendering Backends | DirectX 8 (d3d8.dll) / OpenGL 1.1 (opengl32.dll, glu32.dll) |
| Language | Delphi 7/2006, Free Pascal, C++, C# |
| Calling Convention | stdcall |
| Platform | Windows (x86) |
| Texture Formats | BMP, JPG, GIF (static), TGA |
| Font Format | Custom .ofi (bitmap + metrics) |
| Audio | DirectSound (Win) / OpenAL (Linux) |
| Input | Keyboard, Mouse, Joystick |
| Collision | AABB, Line-Segment, Polygon tests |

---

## API Overview

### Engine Core

| Function | Description |
| :--- | :--- |
| OE_Init() | Initialize engine |
| OE_Quit() | Shutdown engine |
| OE_RegProcedure() | Register system callbacks (INIT, DRAW, QUIT) |
| OE_SetScreenOptions() | Set resolution, BPP, fullscreen, vsync |

### Textures

| Function | Description |
| :--- | :--- |
| Tex_LoadFromFile(path, flags) | Load texture from disk |
| Tex_LoadFromMemory(buf, size, flags) | Load texture from memory |
| Tex_Free(tex) | Free texture |
| Tex_SetFramesSize(tex, w, h) | Set animation frame dimensions |

### Sprites

| Function | Description |
| :--- | :--- |
| SSprite_Draw(tex, x, y, w, h, alpha, angle, fx) | Static sprite |
| ASprite_Draw(tex, x, y, w, h, frame, alpha, angle, fx) | Animated sprite |
| CSprite_Draw(tex, x, y, w, h, rect, alpha) | Cropped sprite |
| STile_Draw(tex, x, y, tw, th, cols, rows, alpha, fx) | Tilemap |

### Fonts

| Function | Description |
| :--- | :--- |
| Text_LoadFontFromFile(tex_path, ofi_path) | Load bitmap font |
| Text_Draw(font, x, y, text, scale, step, alpha, color) | Render text |
| Text_GetWidth(font, text, scale, step) | Get text width |

### Input

| Function | Description |
| :--- | :--- |
| Key_Down(keycode) | Key held |
| Key_Press(keycode) | Key pressed this frame |
| Mouse_X(), Mouse_Y() | Cursor position |
| Mouse_Down(button) | Mouse button held |
| Joy_Down(joy, button) | Joystick button |

### Effects

| Function | Description |
| :--- | :--- |
| FX_Blur_SetParams(amount, delay, alpha) | Blur effect |
| FX_RadBlur_SetParams(amount, offsetX, offsetY) | Radial blur |
| FX_SetBlendMode(mode) | Set blend mode (NORMAL, ADD, SUB, MASK) |
| FX_SetColorMix(color) | Color tint |

---

## Quick Start (C++)

```cpp
#include "headers/C++/OMEGA_functions.h"

PTimer MyTimer;
PTexture Texture;

void Load() {}
void Init() {
    Texture = Tex_LoadFromFile("media/Logo.gif", 0xFFFFFF, TEX_DEFAULT_2D);
}
void Draw() {
    SSprite_Draw(Texture, 400-64, 300-64, 128, 128, 255, 0, FX_DEFAULT);
}
void Quit() {}
void Timer1() {
    if (Key_Down(K_ESCAPE)) OE_Quit();
}

int main() {
    LoadOMEGA();  // GetProcAddress for all functions
    MyTimer = Timer_Create((void*)Timer1, 10, 0);
    OE_RegProcedure(SYS_FASTINIT, (void*)Load);
    OE_RegProcedure(SYS_INIT, (void*)Init);
    OE_RegProcedure(SYS_DRAW, (void*)Draw);
    OE_RegProcedure(SYS_QUIT, (void*)Quit);
    OE_SetScreenOptions(800, 600, 32, 0, false, true);
    OE_Init();
    return 0;
}
```

---

## Demo Projects (on Releases)

| Demo | Description |
| :--- | :--- |
| 01-Запуск движка | Basic engine initialization |
| 02-Текстуры | Texture loading + effects |
| 03-Текст | Bitmap font rendering |
| 04-Примитивы | 2D primitives (rect, circle, line) |
| 05-Спрайты | Static/animated sprites |
| 06-Тайлы | Tilemap rendering |
| 07-Эффекты и спрайты | Blend modes + sprites |
| 08-Звук | Audio playback |
| 09-2D-Камера | Camera system |
| 10-2D-Звук | 2D audio positioning |
| 11-Медиафайлы | Video/media playback |
| 12-Консоль | Debug console |
| 13-Collision | Collision detection |
| 14-Пост и Просто эффекты | Blur, radial blur, fade |
| 15-GUI | Interface system |

---

## Format Specifications

### .ofi Font Format

```c
#pragma pack(push, 1)
typedef struct {
    uint16_t GlyphCount;    // Usually 256
    uint8_t CharWidth;      // Fixed width (0 = variable)
    uint8_t CharHeight;
    uint32_t BitmapOffset;  // Offset to pixel data
    // Followed by: uint8_t WidthTable[GlyphCount]
    // Then: bitmap pixel data (indexed or RGBA)
} OFIHeader;
#pragma pack(pop)
```

See utilities/FontGen/OFI-format.txt for full specification.

---

## Building Demos

### Delphi / Free Pascal

```bash
# Install Free Pascal
sudo pacman -S fpc  # Arch
# or
sudo apt install fpc  # Debian/Ubuntu

# Compile demo
cd demos/Delphi/01-Запуск-движка/
fpc Demo.dpr -Fu../../headers/Delphi -Fu../../units/Delphi
```

### C++ (MinGW)

```bash
# Install MinGW
sudo pacman -S mingw-w64-gcc  # Arch

# Compile demo
cd demos/C++/01-Запуск-движка/
i686-w64-mingw32-g++ -I../../headers/C++ -L../../bin/ENG \
  Demo.cpp -lOMEGA -o test.exe
```

### Running

```bash
# Under Wine on Linux
wine test.exe

# Or native Windows
./test.exe
```

---

## Reverse Engineering Notes

### DLL Structure

The provided OMEGA.dll binaries contain a runtime unpacker stub.

*   **Entry Point:** Performs decryption of code segment.
*   **Source:** DAT_0041b000 (encrypted) -> DAT_00401000 (decrypted).
*   **API Resolution:** Dynamic loading via LoadLibraryA and GetProcAddress.
*   **Imports:** opengl32.dll, glu32.dll, d3d8.dll, ddraw.dll, winmm.dll, dsound.dll.

### Decryption Stub

The DLL uses a custom bitwise shift-loop decryption algorithm protected by VirtualProtect calls. The source code in units/ corresponds to the decrypted logic.

---

## Related Projects

| Project | Description |
| :--- | :--- |
| ZenGL | Modern successor by same author (OpenGL ES, cross-platform) |

---

## Contact

| Purpose | Contact |
| :--- | :--- |
| Original Author | dr.andru@gmail.com (may be inactive) |
| Archive Maintainer | KostyaTheSon (GitHub) |
| Wayback Source | http://isada.mirgames.ru/files/omega/ (2007-02-07) |

---

## Preservation Notes

*   **Archive Date:** 2026-03-15
*   **Source:** Internet Archive Wayback Machine
*   **Original Release:** 2007-02-07
*   **Development Period:** 2005-2006
*   **Status:** Abandonware (author unreachable, domain defunct)

This archive is provided for historical preservation, education, and research. All rights to the original engine code remain with Andru aka Kemka Andrey.

---

## References

*   Internet Archive: OMEGA Engine SDK (mirror)
*   ZenGL GitHub (successor project)
*   Wayback Machine: isada.mirgames.ru

---

## Disclaimer

This repository contains preserved historical software. The original author has not been contacted for this archive. If you are Andru aka Kemka Andrey or represent iSADA Team and wish to request removal or updates, please contact the archive maintainer.

No game assets from third-party products are included. Those remain property of their respective copyright holders.

---

"Preserved for future generations. Keep the cred, keep the code, keep grinding." - Qwen3.5-Plus
