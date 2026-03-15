////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////                                                                        ////
////                          C# header beta 2                              ////
////                           дата: 7.01.07                                ////
////                      работоспособность: ~90%                           ////
////                                                                        ////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////                                                                        ////
////     01010101   010        010   0101010101   0101010101      0110      ////
////    01      01  01010    10101   01           01             01  10     ////
////   01        01 01 010  101 01   01           01             01  10     ////
////   01        01 01  010010  01   0101010101   01            01    10    ////
////    01      01  01    00    01   01           01    0101    01010110    ////
////     01    01   01          01   01           01      01   01      10   ////
////   0101    0101 01          01   0101010101   0101010101   01      10   ////
////                                                                        ////
////                                                                        ////
////   0101010101   010     01   0101010101   01   010     01   0101010101  ////
////   01           010     01   01           01   010     01   01          ////
////   01           01 01   01   01           01   01 01   01   01          ////
////   0101010101   01  01  01   01           01   01  01  01   0101010101  ////
////   01           01   01 01   01    0101   01   01   01 01   01          ////
////   01           01    0101   01      01   01   01    0101   01          ////
////   0101010101   01     001   0101010101   01   01     011   0101010101  ////
////                                                                        ////
////   Версия    : 0.86                                                     ////
////   Дата      : 05.02.07                                                 ////
////   eСтраничка: http://www.isada.mirgames.ru/omega.php                   ////
////                                                                        ////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////                                                                        ////
////  АВТОР: Andru 'aka' КЕМКА АНДРЕЙ                                       ////
////  Mail: Andru_@list.ru                                                  ////
////  Site: http://isada.mirgames.ru                                        ////
////                                                                        ////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////                                                                        ////
////             Л И Ц Е Н З И О Н Н О Е  С О Г Л А Ш Е Н И Е :             ////
////                                                                        ////
////    Всё лицензионное соглашение приведено в соответствующих файлах      ////
////  и в справке к движку. Там же указаны все авторские права.             ////
////                                                             (С)2007    ////
////                                                                        ////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
using System;
using System.Runtime.InteropServices;

public class Omega
{

unsafe public struct TMemory
{
  public void* Ptr;
  public uint Size;
};
//----------------------------------------------------------------------------//
//-----------------------------  E N G I N E  --------------------------------//
//----------------------------------------------------------------------------//

public delegate void ProcAddr();

// S T A R T
[DllImport("OMEGA.dll",EntryPoint="OE_Init")] public static extern
void Init(int zBits, int StencilBits);

[DllImport("OMEGA.dll",EntryPoint="OE_Init2")] public static extern
void Init2( uint hwnd );

[DllImport("OMEGA.dll",EntryPoint="OE_Quit")] public static extern
void Quit();

// M A I N
public const int SYS_DRAW     = 0x0;
public const int SYS_INIT     = 0x1;
public const int SYS_QUIT     = 0x2;
public const int SYS_FASTINIT = 0x3;

[DllImport("OMEGA.dll",EntryPoint="OE_RegProcedure")] public static extern
void RegProcedure( byte PType, ProcAddr Proc );

[DllImport("OMEGA.dll",EntryPoint="OE_UnRegProcedure")] public static extern
void UnRegProcedure( ProcAddr Proc );

[DllImport("OMEGA.dll",EntryPoint="OE_UnRegProcedureT")] public static extern
void UnRegProcedureT( bool Draw, bool Init, bool Quit, bool FastInit);

public struct TTimer
{
  public bool Active;
  public uint Interval;
  public uint LastTime;
  public int  Precision;
  public uint OnTimer;
  public uint Reserved;
}

[DllImport("OMEGA.dll")] public static extern
uint Timer_Create( ProcAddr OnTimer, int Interval, int Precision);

[DllImport("OMEGA.dll")] unsafe public static extern
void Timer_Free( uint Timer );

// O P T I O N S
//FLAGS
public const int FLAG_COLOR_BUFFER_CLEAR = 0x000001;
public const int FLAG_CROP_UNVISIBLE_OBJ = 0x000002;
public const int FLAG_RESOLUTION_CORRECT = 0x000004;

[DllImport("OMEGA.dll",EntryPoint="OE_Enable")] public static extern
void Enable( int What );

[DllImport("OMEGA.dll",EntryPoint="OE_Disable")] public static extern
void Disable( int What );

//WINDOW
[DllImport("OMEGA.dll",EntryPoint="OE_SetWndTop")] public static extern
void SetWndOnTop( bool Enable );

[DllImport("OMEGA.dll",EntryPoint="OE_SetWndPosition")] public static extern
void SetWndPosition( int X, int Y );

[DllImport("OMEGA.dll",EntryPoint="OE_SetWndName" )] public static extern
void SetWndName( char[] NewName );

[DllImport("OMEGA.dll",EntryPoint="OE_ShowCursor")] public static extern
void ShowCursor( bool Show );

[DllImport("OMEGA.dll",EntryPoint="OE_ResizeWindow")] public static extern
void ResizeWindow( int Width, int Height );

//SCREEN
[DllImport("OMEGA.dll",EntryPoint="OE_SetScreenOptions")] public static extern
void SetScreenOptions( int Width, int Height, int BPP, int Refresh, bool FullScreen, bool WaitVSync );

[DllImport("OMEGA.dll",EntryPoint="OE_ChangeScreenOptions")] public static extern
void ChangeScreenOptions( int Width, int Height, int BPP, int Refresh, bool FullScreen, bool WaitVSync );

[DllImport("OMEGA.dll",EntryPoint="OE_SetResolutionDependence")] public static extern
void SetResolutionDependence( int NormalResX, int NormalResY );

[DllImport("OMEGA.dll",EntryPoint="OE_SetVSync")] public static extern
void SetVSync( bool WaitvSync );

//GET
[StructLayout(LayoutKind.Sequential)]
public class TOptions
{
  public bool app_FullScreen;
  public int  wnd_X;
  public int  wnd_Y;
  public int  wnd_Width;
  public int  wnd_Height;
  public int  scr_Width;
  public int  scr_Height;
  public int  scr_BPP;
  public byte scr_Refresh;
  public bool scr_VSync;
  public bool Reserved;
};

[DllImport("OMEGA.dll",EntryPoint="OE_GetOptions")] public static extern
TOptions GetOptions();

// A D D I T I O N A L
[DllImport("OMEGA.dll",EntryPoint="OE_SetAdvancedOptions")] public static extern
void SetAdvancedOptions( bool UseLog, bool AppCanClose, bool HaltOnExit);

[DllImport("OMEGA.dll",EntryPoint="OE_GetFPS")] public static extern
int GetFPS();

//----------------------------------------------------------------------------//
//-----------------------------  H T M L  L O G  -----------------------------//
//----------------------------------------------------------------------------//

public const byte LOGT_ERROR   = 0x0;
public const byte LOGT_WARNING = 0x1;
public const byte LOGT_APP     = 0x2;
public const byte LOGT_CONSOLE = 0x3;

public class Log
{
[DllImport("OMEGA.dll", EntryPoint = "LOG_SetOptions")] public static extern
void SetOptions( string clrBODY,   //= "808080"
				 string clrTIME,   //= "yellowgreen"
				 string clrENGINE, //= "00ff00"
				 string clrAPP,    //= "blue"
				 string clrCONSOLE,//= "blue"
				 string clrMESS,   //= "black"
				 string clrWARNING,//= "orange"
				 string clrERROR,  //= "red"
				 byte  sTIME,//    = 2,
				 byte  sENGINE,//  = 3,
				 byte  sAPP,//     = 4,
				 byte  sCONSOLE,// = 4,
				 byte  sMESS,//    = 3,
				 byte  sWARNING,// = 4,
				 byte  sERROR);//   = 4 );

[DllImport("OMEGA.dll", EntryPoint = "LOG_Init")] public static extern
void Init( string FileName, bool Create );

[DllImport("OMEGA.dll", EntryPoint = "LOG_AddMessage")] public static extern
void AddMessage( byte MessageType, string Text );

[DllImport("OMEGA.dll", EntryPoint = "LOG_AddLine")] public static extern
void AddLine( int Size, string Line );
}

//----------------------------------------------------------------------------//
//------------------------------  I N P U T  ---------------------------------//
//----------------------------------------------------------------------------//

// K E Y B O A R D
public const string K_LAYOUT_ENG = "00000409";
public const string K_LAYOUT_RUS = "00000419";

public const byte K_BACKSPACE = 0x8;
public const byte K_TAB       = 0x9;
public const byte K_ENTER     = 0xd;
public const byte K_SHIFT     = 0x10;
public const byte K_CONTROL   = 0x11;
public const byte K_ALT       = 0x12;
public const byte K_ESCAPE    = 0x1b;
public const byte K_SPACE     = 0x20;
public const byte K_PAGEUP    = 0x21;
public const byte K_PAGEDOWN  = 0x22;
public const byte K_END       = 0x23;
public const byte K_HOME      = 0x24;
public const byte K_SNAPSHOT  = 0x2C;
public const byte K_INSERT    = 0x2D;
public const byte K_DELETE    = 0x2E;
public const byte K_LEFT      = 0x25;
public const byte K_UP        = 0x26;
public const byte K_RIGHT     = 0x27;
public const byte K_DOWN      = 0x28;
public const byte K_0         = 0x30;
public const byte K_1         = 0x31;
public const byte K_2         = 0x32;
public const byte K_3         = 0x33;
public const byte K_4         = 0x34;
public const byte K_5         = 0x35;
public const byte K_6         = 0x36;
public const byte K_7         = 0x37;
public const byte K_8         = 0x38;
public const byte K_9         = 0x39;
public const byte K_NUMPAD0   = 0x60;
public const byte K_NUMPAD1   = 0x61;
public const byte K_NUMPAD2   = 0x62;
public const byte K_NUMPAD3   = 0x63;
public const byte K_NUMPAD4   = 0x64;
public const byte K_NUMPAD5   = 0x65;
public const byte K_NUMPAD6   = 0x66;
public const byte K_NUMPAD7   = 0x67;
public const byte K_NUMPAD8   = 0x68;
public const byte K_NUMPAD9   = 0x69;
public const byte K_MULTIPLY  = 0x6A;
public const byte K_ADD       = 0x6B;
public const byte K_SEPARATOR = 0x6C;
public const byte K_SUBTRACT  = 0x6D;
public const byte K_DECIMAL   = 0x6E;
public const byte K_DIVIDE    = 0x6F;
public const byte K_A         = 0x41;
public const byte K_B         = 0x42;
public const byte K_C         = 0x43;
public const byte K_D         = 0x44;
public const byte K_E         = 0x45;
public const byte K_F         = 0x46;
public const byte K_G         = 0x47;
public const byte K_H         = 0x48;
public const byte K_I         = 0x49;
public const byte K_J         = 0x4a;
public const byte K_K         = 0x4b;
public const byte K_L         = 0x4c;
public const byte K_M         = 0x4d;
public const byte K_N         = 0x4e;
public const byte K_O         = 0x4f;
public const byte K_P         = 0x50;
public const byte K_Q         = 0x51;
public const byte K_R         = 0x52;
public const byte K_S         = 0x53;
public const byte K_T         = 0x54;
public const byte K_U         = 0x55;
public const byte K_V         = 0x56;
public const byte K_W         = 0x57;
public const byte K_X         = 0x58;
public const byte K_Y         = 0x59;
public const byte K_Z         = 0x5a;
public const byte K_F1        = 0x70;
public const byte K_F2        = 0x71;
public const byte K_F3        = 0x72;
public const byte K_F4        = 0x73;
public const byte K_F5        = 0x74;
public const byte K_F6        = 0x75;
public const byte K_F7        = 0x76;
public const byte K_F8        = 0x77;
public const byte K_F9        = 0x78;
public const byte K_F10       = 0x79;
public const byte K_F11       = 0x7a;
public const byte K_F12       = 0x7b;

public class Key
{
[DllImport("OMEGA.dll", EntryPoint = "Key_LoadLayout")] public static extern
void LoadLayout( string Layout );

[DllImport("OMEGA.dll", EntryPoint = "KeyEx_Down")] public static extern
bool ExDown( byte KeyCode );

[DllImport("OMEGA.dll", EntryPoint = "Key_Down")] public static extern
bool Down( byte KeyCode );

[DllImport("OMEGA.dll", EntryPoint = "Key_Press")] public static extern
bool Press( byte KeyCode );

[DllImport("OMEGA.dll", EntryPoint = "Key_LastDown")] public static extern
byte LastDown();

[DllImport("OMEGA.dll", EntryPoint = "Key_LastPress")] public static extern
byte LastPress();

[DllImport("OMEGA.dll", EntryPoint = "Key_BeginReadText")] public static extern
void BeginReadText( string StartText );

[DllImport("OMEGA.dll", EntryPoint = "Key_EndReadText")] public static extern
string EndReadText();

[DllImport("OMEGA.dll", EntryPoint = "Key_MaxReadText")] public static extern
void MaxReadText( int Count );
}

// M O U S E
public const int M_RBUTTON = 0x0;
public const int M_LBUTTON = 0x1;
public const int M_MBUTTON = 0x2;

public class Mouse
{
[DllImport("OMEGA.dll", EntryPoint = "MouseEx_X")] public static extern
int ExX();

[DllImport("OMEGA.dll", EntryPoint = "MouseEx_Y")] public static extern
int ExY();

[DllImport("OMEGA.dll", EntryPoint = "MouseEx_Down")] public static extern
bool ExDown( byte Button );

[DllImport("OMEGA.dll", EntryPoint = "Mouse_X")] public static extern
int X();

[DllImport("OMEGA.dll", EntryPoint = "Mouse_Y")] public static extern
int Y();

[DllImport("OMEGA.dll", EntryPoint = "Mouse_Move")] public static extern
bool Move();

[DllImport("OMEGA.dll", EntryPoint = "Mouse_Lock")] public static extern
void Lock();

[DllImport("OMEGA.dll", EntryPoint = "Mous_DeltaX")] public static extern
int DeltaX();

[DllImport("OMEGA.dll", EntryPoint = "Mouse_DeltaY")] public static extern
int DeltaY();

[DllImport("OMEGA.dll", EntryPoint = "Mouse_Down")] public static extern
bool Down( byte Button );

[DllImport("OMEGA.dll", EntryPoint = "Mouse_Press")] public static extern
bool Press( byte Button );

[DllImport("OMEGA.dll", EntryPoint = "Mouse_Click")] public static extern
bool Click( byte Button );

[DllImport("OMEGA.dll", EntryPoint = "Mouse_DblClick")] public static extern
bool DblClick( byte Button );

[DllImport("OMEGA.dll", EntryPoint = "Mouse_WheelUp")] public static extern
bool WheelUp();

[DllImport("OMEGA.dll", EntryPoint = "Mouse_WheelDown")] public static extern
bool WheelDown();
}

// J O Y P A D
public const int JOY_0      = 0x000000;

public const int JOY_XLEFT  = 0x000001;
public const int JOY_XRIGHT = 0x000002;
public const int JOY_YUP    = 0x000003;
public const int JOY_YDOWN  = 0x000004;
             
public const uint JOY_BTN01  = 0x00000001;
public const uint JOY_BTN02  = 0x00000002;
public const uint JOY_BTN03  = 0x00000004;
public const uint JOY_BTN04  = 0x00000008;
public const uint JOY_BTN05  = 0x00000010;
public const uint JOY_BTN06  = 0x00000020;
public const uint JOY_BTN07  = 0x00000040;
public const uint JOY_BTN08  = 0x00000080;
public const uint JOY_BTN09  = 0x00000100;
public const uint JOY_BTN10  = 0x00000200;
public const uint JOY_BTN11  = 0x00000400;
public const uint JOY_BTN12  = 0x00000800;
public const uint JOY_BTN13  = 0x00001000;
public const uint JOY_BTN14  = 0x00002000;
public const uint JOY_BTN15  = 0x00004000;
public const uint JOY_BTN16  = 0x00008000;
public const uint JOY_BTN17  = 0x00010000;
public const uint JOY_BTN18  = 0x00020000;
public const uint JOY_BTN19  = 0x00040000;
public const uint JOY_BTN20  = 0x00080000;
public const uint JOY_BTN21  = 0x00100000;
public const uint JOY_BTN22  = 0x00200000;
public const uint JOY_BTN23  = 0x00400000;
public const uint JOY_BTN24  = 0x00800000;
public const uint JOY_BTN25  = 0x01000000;
public const uint JOY_BTN26  = 0x02000000;
public const uint JOY_BTN27  = 0x04000000;
public const uint JOY_BTN28  = 0x08000000;
public const uint JOY_BTN29  = 0x10000000;
public const uint JOY_BTN30  = 0x20000000;
public const uint JOY_BTN31  = 0x40000000;
public const uint JOY_BTN32  = 0x80000000;

public class Joy
{
[DllImport("OMEGA.dll", EntryPoint = "Joy_Down")] public static extern
bool Down( int Joy, int Button );

[DllImport("OMEGA.dll", EntryPoint = "Joy_Press")] public static extern
bool Press( int Joy, int Button );

[DllImport("OMEGA.dll", EntryPoint = "Joy_AxePos")] public static extern
bool AxePos( int Joy, int AxePos );
}

//----------------------------------------------------------------------------//
//----------------------------  T E X T U R E S  -----------------------------//
//----------------------------------------------------------------------------//

public struct TTexture
{
  public uint   ID;
  public int    Width;
  public int    Height;
  public float  U;
  public float  V;
  public int    Flags;
  public ushort FramesX;
  public ushort FramesY;
  public uint   Reserved;
};

public const int TEXTYPE_BJGWI = 0x000000; // BMP, JPG, GIF, WMF, ICO
public const int TEXTYPE_TGA   = 0x000001; // TGA

public const int TEX_MIPMAP            = 0x000001;
public const int TEX_CLAMP             = 0x000002;
public const int TEX_COMPRESS          = 0x000004;

// Special
public const int TEX_OMEGA_TO_2X2      = 0x000008;

// Effects
public const int TEX_GRAYSCALE         = 0x000010;
public const int TEX_INVERT            = 0x000020;
public const int TEX_USEMASK           = 0x000040;

// Filtering
public const int TEX_FILTER_NEAREST    = 0x000080;
public const int TEX_FILTER_LINEAR     = 0x000100;
public const int TEX_FILTER_BILINEAR   = 0x000200;
public const int TEX_FILTER_TRILINEAR  = 0x000400;
public const int TEX_FILTER_ANISOTROPY = 0x000800;

// Quality
public const int TEX_QUALITY_LOW 	   = 0x400000;
public const int TEX_QUALITY_MEDIUM    = 0x800000;

public const int TEX_DEFAULT_2D        = TEX_OMEGA_TO_2X2 | TEX_FILTER_LINEAR | TEX_CLAMP;
public const int TEX_DEFAULT_3D        = TEX_MIPMAP | TEX_FILTER_TRILINEAR | TEX_CLAMP;

[DllImport("OMEGA.dll")] public static extern
void Tex_SetAnisotropyLevel( int Level );

[DllImport("OMEGA.dll")] unsafe public static extern
TTexture* Tex_CreateZero( int Width, int Height, int Flags );

[DllImport("OMEGA.dll")] unsafe public static extern
TTexture* Tex_LoadFromFile( string FileName, int TransparentColor, int Flags );

[DllImport("OMEGA.dll")] unsafe public static extern
TTexture* Tex_LoadFromMemory( TMemory* Memory, int FormatType, int TransparentColor, int Flags );

[DllImport("OMEGA.dll")] unsafe public static extern
void Tex_Free( out TTexture* Texture );

[DllImport("OMEGA.dll")] public static extern
void Tex_LoadMaskFromFile( string FileName );

[DllImport("OMEGA.dll")] unsafe public static extern
void Tex_LoadMaskFromMemory( TMemory* Memory );

[DllImport("OMEGA.dll")] public static extern
void Tex_FreeMask();

[DllImport("OMEGA.dll")] unsafe public static extern
void Tex_SetFramesSize( TTexture* Texture, ushort FrameWidth, ushort FrameHeight );

//----------------------------------------------------------------------------//
//-----------------------  R E N D E R  T O  T E X T U R E  ------------------//
//----------------------------------------------------------------------------//

[DllImport("OMEGA.dll")] public static extern
void Tex_BeginRenderIn( uint Texture, bool SaveOld, bool RealSize );

[DllImport("OMEGA.dll")] public static extern
void Tex_EndRenderIn();

//----------------------------------------------------------------------------//
//----------------------------  C A M E R A  2 D  ----------------------------//
//----------------------------------------------------------------------------//

public struct TCamera2D
{
  public int  X;
  public int  Y;
  public bool Active;
  public uint Reserved;
};
public uint PCamera2D;

[DllImport("OMEGA.dll")] public static extern
uint Cam2D_Create();

[DllImport("OMEGA.dll")] public static extern
void Cam2D_Free( out uint YourCamera );

[DllImport("OMEGA.dll")] public static extern
void Cam2D_Set( uint YourCamera );

//----------------------------------------------------------------------------//
//----------------------------------  F X  -----------------------------------//
//----------------------------------------------------------------------------//

public const int FX_BLEND    = 0x000001;
public const int FX_FLIPX    = 0x000002;
public const int FX_FLIPY    = 0x000004;
public const int FX_COLORMIX = 0x000008;
public const int FX_SCALE    = 0x000010;
public const int FX_VCHANGE  = 0x000020;
public const int FX_VCA      = 0x000040;

public const int FX_BLEND_NORMAL = 0x000000;
public const int FX_BLEND_ADD    = 0x000001;
public const int FX_BLEND_MULT   = 0x000002;
public const int FX_BLEND_BLACK  = 0x000003;
public const int FX_BLEND_WHITE  = 0x000004;
public const int FX_BLEND_MASK   = 0x000005;


public const int FX_DEFAULT      = FX_BLEND;

[DllImport("OMEGA.dll")] public static extern
void FX_SetColorMix( int Color );

[DllImport("OMEGA.dll")] public static extern
void FX_SetBlendMode( int Mode );

[DllImport("OMEGA.dll")] public static extern
void FX_SetScale( float ScaleX, float ScaleY );

[DllImport("OMEGA.dll")] public static extern
void FX_SetVertexes( int X1, int Y1, int X2, int Y2, int X3, int Y3, int X4, int Y4 );

[DllImport("OMEGA.dll")] public static extern
void FX_SetVCA( int C1, int C2, int C3, int C4, byte A1, byte A2, byte A3, byte A4 );

// B L U R
[DllImport("OMEGA.dll")] public static extern
void FX_Blur_SetTex( uint TexToRender );

[DllImport("OMEGA.dll")] public static extern
void FX_Blur_SetParams( int Count, int MoveX, int MoveY );

[DllImport("OMEGA.dll")] public static extern
void FX_Blur_Calc( ProcAddr OnRender, float Delta, byte Alpha, int BlendMode);

[DllImport("OMEGA.dll")] public static extern
void FX_Blur_Draw( int Color, byte Alpha );

// "R A D I A L"  B L U R
[DllImport("OMEGA.dll")] public static extern
void FX_RadBlur_SetTex( uint TexToRender );

[DllImport("OMEGA.dll")] public static extern
void FX_RadBlur_SetParams( int Count, int MoveX, int MoveY );

[DllImport("OMEGA.dll")] public static extern
void FX_RadBlur_Calc( ProcAddr OnRender, byte Alpha, int BlendMode);

[DllImport("OMEGA.dll")] public static extern
void FX_RadBlur_Draw( int Color, byte Alpha );

//----------------------------------------------------------------------------//
//------------------------------  T E X T  2 D  ------------------------------//
//----------------------------------------------------------------------------//

public struct TSymbol
{
  public ushort X;
  public ushort Y;
  public byte   Width;
};

unsafe public struct TFont2D
{
  public byte             Height;
  public static TSymbol[] Sizes = new TSymbol[256];
  public TTexture* 		  Texture;
  public uint      		  Reserved;
};

public class Text
{
[DllImport("OMEGA.dll", EntryPoint = "Text_LoadFontFromFile")] public static extern
TFont2D* LoadFontFromFile( string FontTexture, string FontInfo, int TransparentColor, int TexFlags);

[DllImport("OMEGA.dll", EntryPoint = "Text_LoadFonrFromMemory")] unsafe public static extern
TFont2D* LoadFontFromMemory( TMemory* FontTexture, int FontTexType, TMemory* FontInfo, int TransparentColor, int TexFlags);

[DllImport("OMEGA.dll", EntryPoint = "Text_Free")] unsafe public static extern
void FreeFont( out TFont2D* Font );

[DllImport("OMEGA.dll", EntryPoint = "Text_Draw")] unsafe public static extern
void Draw( TFont2D* Font, int X, int Y, string Text, float Scale, int Step, byte Alpha, int Color );

[DllImport("OMEGA.dll", EntryPoint = "Text_GetWidth")] unsafe public static extern
int GetWidth( TFont2D* Font, string Text, float Scale, int Step );
}

//----------------------------------------------------------------------------//
//------------------------------  C O N S O L E  -----------------------------//
//----------------------------------------------------------------------------//

public class Console
{
[DllImport("OMEGA.dll", EntryPoint = "Console_Active")] public static extern
void Active( bool Enable );

[DllImport("OMEGA.dll", EntryPoint = "Console_SetOptions")] unsafe public static extern
void SetOptions( TFont2D* Font, TTexture* Texture, int Color, byte Alpha, int FontColor, byte FontAlpha );

[DllImport("OMEGA.dll", EntryPoint = "Console_ToLog")] public static extern
void ToLog( bool Connect );

[DllImport("OMEGA.dll", EntryPoint = "Console_Draw")] public static extern
void Draw();

[DllImport("OMEGA.dll", EntryPoint = "Console_RegCommand")] public static extern
void RegCommand( string Command, uint Proc );

[DllImport("OMEGA.dll", EntryPoint = "Console_RegVariable")] public static extern
void RegVariable( string VarName, IntPtr Variable );

[DllImport("OMEGA.dll", EntryPoint = "Console_RegProcedure")] public static extern
void RegProcedure( string ProcName, ProcAddr Proc );

[DllImport("OMEGA.dll", EntryPoint = "Console_AddString")] public static extern
void AddString( string Str );
}

//----------------------------------------------------------------------------//
//-----------------------  P R I M I T I V E S  2 D  -------------------------//
//----------------------------------------------------------------------------//

public const int PR_FILL    = 0x000001;
public const int PR_SMOOTH  = 0x000002;

public const int PR_DEFAULT = 0x0;

public struct oePoint
{
  public int X;
  public int Y;
};

public struct oeLine
{
  public int x0;
  public int y0;
  public int x1;
  public int y1;
};

public struct oeRect
{
  public int X;
  public int Y;
  public int Width;
  public int Height;
};

public struct oeTriangle
{
  public int X1; public int Y1;
  public int X2; public int Y2;
  public int X3; public int Y3;
};

public struct oeCircle
{
  public int cX;
  public int cY;
  public int Radius;
};

[DllImport("OMEGA.dll")] public static extern
void Pr2D_PixelSize( int Size );

[DllImport("OMEGA.dll")] public static extern
void Pr2D_LineWidth( int Width );

[DllImport("OMEGA.dll")] public static extern
void Pr2D_Pixel( int X, int Y, int Color, byte Alpha );

[DllImport("OMEGA.dll")] public static extern
void Pr2D_Line( int X1, int Y1, int X2, int Y2, int Color, byte Alpha, int Flags );

[DllImport("OMEGA.dll")] public static extern
void Pr2D_TLine( out oeLine Line, int Color, byte Alpha, int Flags);

[DllImport("OMEGA.dll")] public static extern
void Pr2D_Rect( int X, int Y, int Width, int Height, int Color, byte Alpha, int Flags);

[DllImport("OMEGA.dll")] public static extern
void Pr2D_TRect( out oeRect Rectangle, int Color, byte Alpha, int Flags);

[DllImport("OMEGA.dll")] public static extern
void Pr2D_Triangle( int X1, int Y1, int X2, int Y2, int X3, int Y3, int Color, byte Alpha, int Flags);

[DllImport("OMEGA.dll")] public static extern
void Pr2D_TTriangle( out oeTriangle Triangle, int Color, byte Alpha, int Flags);

[DllImport("OMEGA.dll")] public static extern
void Pr2D_Circle( int  cX, int cY, int Radius, int Color, byte Alpha, int Quality, int Flags);

[DllImport("OMEGA.dll")] public static extern
void Pr2D_TCircle( out oeCircle Circle, int Color, byte Alpha, int Quality, int Flags );

[DllImport("OMEGA.dll")] public static extern
void Pr2D_Ellipse( int cX, int cY, int xRadius, int yRadius, int Color, byte Alpha, int Quality, int Flags );

[DllImport("OMEGA.dll")] unsafe public static extern
void Pr2D_Polygon( oePoint[] Points, int PCount, int Color, byte Alpha, int Flags );

//----------------------------------------------------------------------------//
//----------------------------  S P R I T E S  -------------------------------//
//----------------------------------------------------------------------------//

// S T A T I C
[DllImport("OMEGA.dll")] unsafe public static extern
void SSprite_Draw( TTexture* Tex, int X, int Y, int Width, int Height, byte Alpha, int Angle, int Flags );

// A N I M A T E D
[DllImport("OMEGA.dll")] unsafe public static extern
void ASprite_Draw( TTexture* Tex, int X, int Y, int Width, int Height, int FrameNow, byte Alpha, int Angle, int Flags );

// C U T
[DllImport("OMEGA.dll")] unsafe public static extern
void CSprite_Draw( TTexture* Tex, int X, int Y, int Width, int Height, uint CutRect, byte Alpha, int Angle, int Flags );

//----------------------------------------------------------------------------//
//------------------------------  T I L E S  ---------------------------------//
//----------------------------------------------------------------------------//

// S T A T I C
[DllImport("OMEGA.dll")] public static extern
void STile_Draw( uint Tex, int X, int Y, int Width, int Height, int TilesX, int TilesY, byte Alpha, int Flags );

// A N I M A T E D
[DllImport("OMEGA.dll")] public static extern
void ATile_Draw( uint Tex, int X, int Y, int Width, int Height, int TilesX, int TilesY, int FrameNow, byte Alpha, int Flags );

//----------------------------------------------------------------------------//
//---------------------------  D R A W  L I S T  -----------------------------//
//----------------------------------------------------------------------------//
[DllImport("OMEGA.dll")] public static extern
uint DrawList_Begin();

[DllImport("OMEGA.dll")] public static extern
void DrawList_End();

[DllImport("OMEGA.dll")] public static extern
void DrawList_Free( uint List );

[DllImport("OMEGA.dll")] public static extern
void DrawList_Draw( uint List );

//----------------------------------------------------------------------------//
//-----------------------------  S C I S S O R  ------------------------------//
//----------------------------------------------------------------------------//

[DllImport("OMEGA.dll")] public static extern
void Scissor_Begin( int X, int Y, int Width, int Height );

[DllImport("OMEGA.dll")] public static extern
void Scissor_End(void);

//----------------------------------------------------------------------------//
//------------------------------  S O U N D  ---------------------------------//
//----------------------------------------------------------------------------//

public class Snd
{
[DllImport("OMEGA.dll", EntryPoint = "Snd_Init")] public static extern
bool Init();

[DllImport("OMEGA.dll", EntryPoint = "Snd_Enable")] public static extern
void Enable();

[DllImport("OMEGA.dll", EntryPoint = "Snd_Disable")] public static extern
void Disable();

[DllImport("OMEGA.dll", EntryPoint = "Snd_LoadFromFile")] public static extern
uint LoadFromFile( string FileName, int BufferCount );

[DllImport("OMEGA.dll", EntryPoint = "Snd_LoadFromMemory")] public static extern
uint LoadFromMemory( uint Memory, int BufferCount );

[DllImport("OMEGA.dll", EntryPoint = "Snd_Free")] public static extern
bool Free( uint Sound );

[DllImport("OMEGA.dll", EntryPoint = "Snd_SetBuffersCount")] public static extern
void SetBuffersCount( uint Sound, int Count );

[DllImport("OMEGA.dll", EntryPoint = "Snd_Play")] public static extern
int Play( uint Sound, int Pan, int Volume, int Frequency, bool Loop );

[DllImport("OMEGA.dll", EntryPoint = "Snd_PlayID")] public static extern
void PlayID( uint Sound, int ID, int Pan, int Volume, int Frequency, bool Loop );

[DllImport("OMEGA.dll", EntryPoint = "Snd_Stop")] public static extern
void Stop( uint Sound );

[DllImport("OMEGA.dll", EntryPoint = "Snd_StopID")] public static extern
void StopID( uint Sound, int ID );

[DllImport("OMEGA.dll", EntryPoint = "Snd_StopAll")] public static extern
void StopAll();

[DllImport("OMEGA.dll", EntryPoint = "Snd_ChangeParam")] public static extern
void ChangeParam( uint Sound, int ID, int Pan, int Volume, int Frequency );
}

//----------------------------------------------------------------------------//
//------------------------------  M E D I A  ---------------------------------//
//----------------------------------------------------------------------------//

public class Media
{
[DllImport("OMEGA.dll", EntryPoint = "Media_Play")] public static extern
void Play( string FileName, bool Loop );

[DllImport("OMEGA.dll", EntryPoint = "Media_Replay")] public static extern
void Replay();

[DllImport("OMEGA.dll", EntryPoint = "Media_Pause")] public static extern
void Pause();

[DllImport("OMEGA.dll", EntryPoint = "Media_Resume")] public static extern
void Resume();

[DllImport("OMEGA.dll", EntryPoint = "Media_Stop")] public static extern
void Stop();

[DllImport("OMEGA.dll", EntryPoint = "Media_SetVolume")] public static extern
void SetVolume( int Volume );

[DllImport("OMEGA.dll", EntryPoint = "Media_GetLength")] public static extern
double GetLength();

[DllImport("OMEGA.dll", EntryPoint = "Media_SetPosition")] public static extern
void SetPosition( double Position );

[DllImport("OMEGA.dll", EntryPoint = "Media_GetPosition")] public static extern
double GetPosition();

[DllImport("OMEGA.dll", EntryPoint = "Media_SetWindowRect")] public static extern
void SetWindowRect( int X, int Y, int Width, int Height );
}

//----------------------------------------------------------------------------//
//---------------------------  C O L L I S I O N  ----------------------------//
//----------------------------------------------------------------------------//

public struct TPolyLine2D
{
  public uint      Count;
  public int       cX;
  public int       cY;
  public oePoint[] Points;
};

// P O I N T ' s
public class Col
{
[DllImport("OMEGA.dll", EntryPoint = "Col_PointInAABB")] public static extern
bool PointInAABB( int X, int Y, out oeRect AABB );

[DllImport("OMEGA.dll", EntryPoint = "Col_PointInCircle")] public static extern
bool PointInCircle( int X, int Y, out oeCircle Circ );

[DllImport("OMEGA.dll", EntryPoint = "Col_PointInPolyLine")] public static extern
bool PointInPolyLine( int X, int Y, out TPolyLine2D PL );

// L I N E ' s
[DllImport("OMEGA.dll", EntryPoint = "Col_Line")] public static extern
bool Line( out oeLine A, out oeLine B );

[DllImport("OMEGA.dll", EntryPoint = "Col_LineVsAABB")] public static extern
bool LineVsAABB( out oeLine A, out oeRect AABB );

[DllImport("OMEGA.dll", EntryPoint = "Col_LineVsCircle")] public static extern
bool LineVsCircle( out oeLine L, out oeCircle Circ );

[DllImport("OMEGA.dll", EntryPoint = "Col_LineVsCircleXY")] public static extern
bool LineVsCircleXY( out oeLine L, out oeCircle Circ, int Precision );

[DllImport("OMEGA.dll", EntryPoint = "Col_LineVsPolyLine")] public static extern
bool LineVsPolyLine( out oeLine A, out TPolyLine2D B );

// P O L Y L I N E ' s
[DllImport("OMEGA.dll", EntryPoint = "Col_PolyLine")] public static extern
bool PolyLine( out TPolyLine2D A, out TPolyLine2D B );

[DllImport("OMEGA.dll", EntryPoint = "Col_PolyLineVsAABB")] public static extern
bool PolyLineVsAABB( out TPolyLine2D PL, out oeRect AABB );

[DllImport("OMEGA.dll", EntryPoint = "Col_PolyLineVsCircle")] public static extern
bool Col_PolyLineVsCircle( uint A, uint Circ );

// A A B B ' s
[DllImport("OMEGA.dll", EntryPoint = "Col_AABB")] public static extern
bool AABB( out oeRect AABB1, out oeRect AABB2 );

[DllImport("OMEGA.dll", EntryPoint = "Col_AABBInAABB")] public static extern
bool AABBInAABB( out oeRect AABB1, out oeRect AABB2 );

[DllImport("OMEGA.dll", EntryPoint = "Col_AABBInCircle")] public static extern
bool AABBInCircle( out oeRect AABB1, out oeCircle Circ );

[DllImport("OMEGA.dll", EntryPoint = "Col_AABBVsCircle")] public static extern
bool AABBVsCircle( out oeRect AABB1, out oeCircle Circ );

// C I R C L E ' s
[DllImport("OMEGA.dll", EntryPoint = "Col_Circle")] public static extern
bool Circle( out oeCircle Circ1, out oeCircle Circ2 );

[DllImport("OMEGA.dll", EntryPoint = "Col_CircleInCircle")] public static extern
bool CircleInCircle( out oeCircle Circ1, out oeCircle Circ2 );

[DllImport("OMEGA.dll", EntryPoint = "Col_CircleInAABB")] public static extern
bool CircleInAABB( out oeCircle Circ1, out oeRect AABB );

// E X T E N D E D  F U N C T I O N S
// G E T ' s
[DllImport("OMEGA.dll", EntryPoint = "ColEx_LastX")] public static extern
float ExLastX();
[DllImport("OMEGA.dll", EntryPoint = "ColEx_LastY")] public static extern
float ExLastY();

// T R A N S F O R M A T I O N ' s
[DllImport("OMEGA.dll", EntryPoint = "ColEx_PolyRotate")] public static extern
void ExPolyRotate( out TPolyLine2D A, out TPolyLine2D B, int Angle );

[DllImport("OMEGA.dll", EntryPoint = "ColEx_PolyScale")] public static extern
void ExPolyScale( out TPolyLine2D A, float ScaleX, float ScaleY );

[DllImport("OMEGA.dll", EntryPoint = "ColEx_PolyMove")] public static extern
void ExPolyMove( out TPolyLine2D A, out TPolyLine2D B, int X, int Y );

[DllImport("OMEGA.dll", EntryPoint = "ColEx_PolyCenter")] public static extern
void ExPolyCenter( out TPolyLine2D A );

[DllImport("OMEGA.dll", EntryPoint = "ColEx_PolyRect")] public static extern
void ExPolyRect( out TPolyLine2D A, out oeRect Rect );

// L I N E ' s
[DllImport("OMEGA.dll", EntryPoint = "ColEx_CalcLineCross")] public static extern
void ExCalcLineCross( out oeLine A, out oeLine B );
}

//----------------------------------------------------------------------------//
//----------------------------  F A S T  M A T H  ----------------------------//
//----------------------------------------------------------------------------//

[DllImport("OMEGA.dll")] public static extern
float M_Cos( int Angle );

[DllImport("OMEGA.dll")] public static extern
float M_Sin( int Angle );

[DllImport("OMEGA.dll")] public static extern
float M_CosF( int Angle );

[DllImport("OMEGA.dll")] public static extern
float M_SinF( int Angle );

[DllImport("OMEGA.dll")] public static extern
int M_Round( float Value );

[DllImport("OMEGA.dll")] public static extern
int M_Trunc( float Value );

[DllImport("OMEGA.dll")] public static extern
float M_Distance( float X1, float Y1, float X2, float Y2 );

[DllImport("OMEGA.dll")] public static extern
int M_FindAngle( int X1, int Y1, int X2, int Y2 );

//----------------------------------------------------------------------------//
//-------------------------------  U T I L S  --------------------------------//
//----------------------------------------------------------------------------//

// H A R D W A R E
[DllImport("OMEGA.dll")] public static extern
string U_GetCPUName();
[DllImport("OMEGA.dll")] public static extern
int U_GetTotalRAM();
[DllImport("OMEGA.dll")] public static extern
bool U_Is3DAccelerator();

[DllImport("OMEGA.dll")] public static extern
int U_GetMaxTexSize();
[DllImport("OMEGA.dll")] public static extern
int U_GetMaxAnisotropy();

// A D D I T I O N A L  F O R  E N G I N E
[DllImport("OMEGA.dll")] public static extern
void U_SnapShot( string Path, string FileName );

// C O N V E R Tint Num );
[DllImport("OMEGA.dll")] public static extern
string U_IntToStr( int Num );

[DllImport("OMEGA.dll")] public static extern
int U_StrToInt( string Str );

[DllImport("OMEGA.dll")] public static extern
string U_FloatToStr( float Num );

[DllImport("OMEGA.dll")] public static extern
uint U_GetTime();

	public Omega()
	{
	}
}
