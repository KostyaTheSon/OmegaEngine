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
unit OMEGA;

//Delphi 3
{$IFDEF VER100}
  {$DEFINE DELPHI}
{$ENDIF}
//Delphi 4
{$IFDEF VER120}
  {$DEFINE DELPHI}
{$ENDIF}
//Delphi 5
{$IFDEF VER130}
  {$DEFINE DELPHI}
{$ENDIF}
//Delphi 6
{$IFDEF VER140}
  {$DEFINE DELPHI}
{$ENDIF}
//Delphi 7
{$IFDEF VER150}
  {$DEFINE DELPHI}
{$ENDIF}
//Delphi 2005
{$IFDEF VER170}
  {$DEFINE DELPHI}
{$ENDIF}
//Delphi 2006
{$IFDEF VER180}
  {$DEFINE DELPHI}
{$ENDIF}

{$IFNDEF DELPHI}
  {$MODE DELPHI}
{$ENDIF}

interface

type
  DWORD = LongWord;

const
  OMEGA_dll = 'OMEGA.dll';

// G L O B A L  T Y P E S
type
  TMemory = record
    Ptr  : Pointer;
    Size : DWORD;
end;
PMemory = ^TMemory;

//----------------------------------------------------------------------------//
//-----------------------------  E N G I N E  --------------------------------//
//----------------------------------------------------------------------------//

// S T A R T
procedure OE_Init( zBits       : Byte = 16;
                   stencilBits : Byte = 0 );
                                                     stdcall external OMEGA_dll;

procedure OE_Init2(
                    HWND        : DWORD;
                    zBits       : Byte = 16;
                    stencilBits : Byte = 0 );
                                                     stdcall external OMEGA_dll;

procedure OE_Quit;
                                                     stdcall external OMEGA_dll;

// M A I N
const
  SYS_DRAW     = 0;
  SYS_INIT     = 1;
  SYS_QUIT     = 2;
  SYS_FASTINIT = 3;

procedure OE_RegProcedure(
                           PType    : Byte;
                           PAddress : Pointer );
                                                     stdcall external OMEGA_dll;

procedure OE_UnRegProcedure(
                             PAddress : Pointer );
                                                     stdcall external OMEGA_dll;

procedure OE_UnRegProcedureT(
                              Draw     : Boolean = FALSE;
                              Init     : Boolean = FALSE;
                              Quit     : Boolean = FALSE;
                              FastInit : Boolean = FALSE );
                                                     stdcall external OMEGA_dll;

// T I M E R S
type
  TTimer = record
    Active    : Boolean;
    Interval  : DWORD;
    LastTime  : DWORD;
    Precision : Integer;
    OnTimer   : Procedure;
    Reserved  : DWORD;
end;
PTimer = ^TTimer;

function Timer_Create(
                       OnTimer   : Pointer;
                       Interval  : Integer = 1000;
                       Precision : Integer = 1 ) : PTimer;
                                                     stdcall external OMEGA_dll;

procedure Timer_Free(
                      var Timer : PTimer );
                                                     stdcall external OMEGA_dll;

// O P T I O N S
//FLAGS
const
  FLAG_CLEAR_COLOR_BUFFER = $000001;
  FLAG_CROP_UNVISIBLE_OBJ = $000002;
  FLAG_RESOLUTION_CORRECT = $000004;
  FLAG_SHOW_WARNINGS      = $000008;

procedure OE_Enable( What : Integer );
                                                     stdcall external OMEGA_dll;

procedure OE_Disable( What : Integer );
                                                     stdcall external OMEGA_dll;

//WINDOW
procedure OE_SetWndOnTop( Enable : Boolean );
                                                     stdcall external OMEGA_dll;

procedure OE_SetWndPosition(
                             X, Y : Integer );
                                                     stdcall external OMEGA_dll;

procedure OE_SetWndName(
                         NewName : PChar );
                                                     stdcall external OMEGA_dll;

procedure OE_ShowCursor(
                         Show : Boolean );
                                                     stdcall external OMEGA_dll;

procedure OE_ResizeWindow(
                           Width, Height : Integer );
                                                     stdcall external OMEGA_dll;

//SCREEN
procedure OE_SetScreenOptions(
                               Width, Height : Integer;
                               BPP           : Integer;
                               Refresh       : Integer;
                               FullScreen    : Boolean;
                               WaitVSync     : Boolean );
                                                     stdcall external OMEGA_dll;
procedure OE_ChangeScreenOptions(
                                  Width, Height : Integer;
                                  BPP           : Integer;
                                  Refresh       : Integer;
                                  FullScreen    : Boolean;
                                  WaitVSync     : Boolean );
                                                     stdcall external OMEGA_dll;

procedure OE_SetResolutionDependence( NormalResX, NormalResY : Integer );
                                                     stdcall external OMEGA_dll;

procedure OE_SetVSync(
                       WaitVSync : Boolean );
                                                     stdcall external OMEGA_dll;

//GET
type
  TOptions = record
    app_FullScreen : Boolean;
    wnd_X          : Integer;
    wnd_Y          : Integer;
    wnd_Width      : Integer;
    wnd_Height     : Integer;
    scr_Width      : Integer;
    scr_Height     : Integer;
    scr_BPP        : Integer;
    scr_Refresh    : Byte;
    scr_VSync      : Boolean;
    Reserved       : Boolean;
end;
POptions = ^TOptions;

function OE_GetOptions : POptions;
                                                     stdcall external OMEGA_dll;

// A D D I T I O N A L
procedure OE_SetAdvancedOptions(
                                 UseLog      : Boolean;
                                 AppCanClose : Boolean = TRUE;
                                 HaltOnExit  : Boolean = FALSE );
                                                     stdcall external OMEGA_dll;

function OE_GetFPS : Integer;
                                                     stdcall external OMEGA_dll;

//----------------------------------------------------------------------------//
//-----------------------------  H T M L  L O G  -----------------------------//
//----------------------------------------------------------------------------//

const
  LOGT_ERROR   = 0;
  LOGT_WARNING = 1;
  LOGT_APP     = 2;
  LOGT_CONSOLE = 3;

procedure LOG_SetOptions(
                          clrBODY    : PChar {= '808080'};
                          clrTIME    : PChar {= 'yellowgreen'};
                          clrENGINE  : PChar {= '00ff00'};
                          clrAPP     : PChar {= 'blue'};
                          clrCONSOLE : PChar {= 'blue'};
                          clrMESS    : PChar {= 'black'};
                          clrWARNING : PChar {= 'orange'};
                          clrERROR   : PChar {= 'red'};
                          sTIME      : Byte  = 2;
                          sENGINE    : Byte  = 4;
                          sAPP       : Byte  = 4;
                          sCONSOLE   : Byte  = 4;
                          sMESS      : Byte  = 3;
                          sWARNING   : Byte  = 4;
                          sERROR     : Byte  = 4 );
                                                     stdcall external OMEGA_dll;

procedure LOG_Init(
                    FileName : PChar;
                    Create   : Boolean );
                                                     stdcall external OMEGA_dll;

procedure LOG_AddMessage(
                          MessageType : Byte;
                          Text        : PChar );
                                                     stdcall external OMEGA_dll;

procedure LOG_AddLine(
                       Size  : Integer;
                       Color : PChar );
                                                     stdcall external OMEGA_dll;

//----------------------------------------------------------------------------//
//------------------------------  I N P U T  ---------------------------------//
//----------------------------------------------------------------------------//

// K E Y B O A R D
const
  K_LAYOUT_ENG = '00000409';
  K_LAYOUT_RUS = '00000419';

  K_BACKSPACE  = 8;
  K_TAB        = 9;
  K_ENTER      = 13;
  K_SHIFT      = 16;
  K_CTRL       = 17;
  K_ALT        = 18;
  K_ESCAPE     = 27;
  K_SPACE      = 32;

  K_PAGEUP     = 33;
  K_PAGEDOWN   = 34;
  K_END        = 35;
  K_HOME       = 36;
  K_SNAPSHOT   = 44;
  K_INSERT     = 45;
  K_DELETE     = 46;

  K_LEFT       = 37;
  K_UP         = 38;
  K_RIGHT      = 39;
  K_DOWN       = 40;

  K_0          = 48;
  K_1          = 49;
  K_2          = 50;
  K_3          = 51;
  K_4          = 52;
  K_5          = 53;
  K_6          = 54;
  K_7          = 55;
  K_8          = 56;
  K_9          = 57;

  K_NUMPAD0    = 96;
  K_NUMPAD1    = 97;
  K_NUMPAD2    = 98;
  K_NUMPAD3    = 99;
  K_NUMPAD4    = 100;
  K_NUMPAD5    = 101;
  K_NUMPAD6    = 102;
  K_NUMPAD7    = 103;
  K_NUMPAD8    = 104;
  K_NUMPAD9    = 105;

  K_MULTIPLY   = 106;
  K_ADD        = 107;
  K_SEPARATOR  = 108;
  K_SUBTRACT   = 109;
  K_DECIMAL    = 110;
  K_DIVIDE     = 111;

  K_A          = 65;
  K_B          = 66;
  K_C          = 67;
  K_D          = 68;
  K_E          = 69;
  K_F          = 70;
  K_G          = 71;
  K_H          = 72;
  K_I          = 73;
  K_J          = 74;
  K_K          = 75;
  K_L          = 76;
  K_M          = 77;
  K_N          = 78;
  K_O          = 79;
  K_P          = 80;
  K_Q          = 81;
  K_R          = 82;
  K_S          = 83;
  K_T          = 84;
  K_U          = 85;
  K_V          = 86;
  K_W          = 87;
  K_X          = 88;
  K_Y          = 89;
  K_Z          = 90;

  K_F1         = 112;
  K_F2         = 113;
  K_F3         = 114;
  K_F4         = 115;
  K_F5         = 116;
  K_F6         = 117;
  K_F7         = 118;
  K_F8         = 119;
  K_F9         = 120;
  K_F10        = 121;
  K_F11        = 122;
  K_F12        = 123;

procedure Key_LoadLayout(
                          Layout : PChar );
                                                     stdcall external OMEGA_dll;

function KeyEx_Down(
                     KeyCode : Byte ) : Boolean;
                                                     stdcall external OMEGA_dll;

function Key_Down(
                   KeyCode : Byte ) : Boolean;
                                                     stdcall external OMEGA_dll;

function Key_Press(
                    KeyCode : Byte ) : Boolean;
                                                     stdcall external OMEGA_dll;

function Key_LastDown : Byte;
                                                     stdcall external OMEGA_dll;
function Key_LastPress : Byte;
                                                     stdcall external OMEGA_dll;

procedure Key_BeginReadText( StartText : PChar );
                                                     stdcall external OMEGA_dll;
function Key_EndReadText : PChar;
                                                     stdcall external OMEGA_dll;
procedure Key_MaxReadText( Count : Integer );
                                                     stdcall external OMEGA_dll;

// M O U S E
const
  M_RBUTTON = 0;
  M_LBUTTON = 1;
  M_MBUTTON = 2;

function MouseEx_X : Integer;
                                                     stdcall external OMEGA_dll;

function MouseEx_Y : Integer;
                                                     stdcall external OMEGA_dll;

function MouseEx_Down( Button : Byte ) : Boolean;
                                                     stdcall external OMEGA_dll;


function Mouse_X : Integer;
                                                     stdcall external OMEGA_dll;

function Mouse_Y : Integer;
                                                     stdcall external OMEGA_dll;

function Mouse_Move : Boolean;
                                                     stdcall external OMEGA_dll;

procedure Mouse_Lock;
                                                     stdcall external OMEGA_dll;

function Mouse_DeltaX : Integer;
                                                     stdcall external OMEGA_dll;

function Mouse_DeltaY : Integer;
                                                     stdcall external OMEGA_dll;

function Mouse_Down(
                     Button : Byte ) : Boolean;
                                                     stdcall external OMEGA_dll;

function Mouse_Press(
                      Button : Byte ) : Boolean;
                                                     stdcall external OMEGA_dll;

function Mouse_Click(
                      Button : Byte ) : Boolean;
                                                     stdcall external OMEGA_dll;

function Mouse_DblClick(
                         Button : Byte ) : Boolean;
                                                     stdcall external OMEGA_dll;

function Mouse_WheelUp : Boolean;
                                                     stdcall external OMEGA_dll;

function Mouse_WheelDown : Boolean;
                                                     stdcall external OMEGA_dll;

// J O Y P A D
const
  JOY_0      = $000000;

  JOY_XLEFT  = $000001;
  JOY_XRIGHT = $000002;
  JOY_YUP    = $000003;
  JOY_YDOWN  = $000004;

  JOY_BTN01  = $00000001;
  JOY_BTN02  = $00000002;
  JOY_BTN03  = $00000004;
  JOY_BTN04  = $00000008;
  JOY_BTN05  = $00000010;
  JOY_BTN06  = $00000020;
  JOY_BTN07  = $00000040;
  JOY_BTN08  = $00000080;
  JOY_BTN09  = $00000100;
  JOY_BTN10  = $00000200;
  JOY_BTN11  = $00000400;
  JOY_BTN12  = $00000800;
  JOY_BTN13  = $00001000;
  JOY_BTN14  = $00002000;
  JOY_BTN15  = $00004000;
  JOY_BTN16  = $00008000;
  JOY_BTN17  = $00010000;
  JOY_BTN18  = $00020000;
  JOY_BTN19  = $00040000;
  JOY_BTN20  = $00080000;
  JOY_BTN21  = $00100000;
  JOY_BTN22  = $00200000;
  JOY_BTN23  = $00400000;
  JOY_BTN24  = $00800000;
  JOY_BTN25  = $01000000;
  JOY_BTN26  = $02000000;
  JOY_BTN27  = $04000000;
  JOY_BTN28  = $08000000;
  JOY_BTN29  = $10000000;
  JOY_BTN30  = $20000000;
  JOY_BTN31  = $40000000;
  JOY_BTN32  = $80000000;

function Joy_Down(
                   Joy, Button : Integer ) : Boolean;
                                                     stdcall external OMEGA_dll;

function Joy_Press(
                    Joy, Button : Integer ) : Boolean;
                                                     stdcall external OMEGA_dll;

function Joy_AxePos(
                     Joy, AxePos : Integer ) : Boolean;
                                                     stdcall external OMEGA_dll;

//----------------------------------------------------------------------------//
//----------------------------  T E X T U R E S  -----------------------------//
//----------------------------------------------------------------------------//

type
  TTexture = record
    ID            : Cardinal;
    Width, Height : Integer;
    U, V          : Single;
    Flags         : Integer;
    FramesX       : WORD;
    FramesY       : WORD;
    Reserved      : DWORD;
end;
PTexture = ^TTexture;

const
  TEXTYPE_BJGWI = $000000; // BMP, JPG, GIF, WMF, ICO
  TEXTYPE_TGA   = $000001; // TGA

const
  TEX_MIPMAP            = $000001;
  TEX_CLAMP             = $000002;
  TEX_COMPRESS          = $000004;

  // Special
  TEX_OMEGA_TO_2X2      = $000008;

  // Effects
  TEX_GRAYSCALE         = $000010;
  TEX_INVERT            = $000020;
  TEX_USEMASK           = $000040;

  // Filtering
  TEX_FILTER_NEAREST    = $000080;
  TEX_FILTER_LINEAR     = $000100;
  TEX_FILTER_BILINEAR   = $000200;
  TEX_FILTER_TRILINEAR  = $000400;
  TEX_FILTER_ANISOTROPY = $000800;

  // Quality
  TEX_QUALITY_LOW 	    = $400000;
	TEX_QUALITY_MEDIUM    = $800000;

  TEX_DEFAULT_2D        = TEX_OMEGA_TO_2X2 or TEX_FILTER_LINEAR or TEX_CLAMP;
  TEX_DEFAULT_3D        = TEX_MIPMAP or TEX_FILTER_TRILINEAR or TEX_CLAMP;

procedure Tex_SetAnisotropyLevel( Level : Integer );
                                                     stdcall external OMEGA_dll;

function Tex_CreateZero(
                         Width, Height : Integer;
                         Flags         : Integer ) : PTexture;
                                                     stdcall external OMEGA_dll;

function Tex_LoadFromFile(
                           FileName         : PChar;
                           TransparentColor : Integer;
                           Flags            : Integer ) : PTexture;
                                                     stdcall external OMEGA_dll;

function Tex_LoadFromMemory(
                             Memory           : PMemory;
                             FormatType       : Integer;
                             TransparentColor : Integer;
                             Flags            : Integer ) : PTexture;
                                                     stdcall external OMEGA_dll;

procedure Tex_Free(
                    var Texture : PTexture );
                                                     stdcall external OMEGA_dll;

procedure Tex_LoadMaskFromFile(
                                FileName : PChar );
                                                     stdcall external OMEGA_dll;

procedure Tex_LoadMaskFromMemory(
                                  Memory : PMemory );
                                                     stdcall external OMEGA_dll;

procedure Tex_FreeMask;
                                                     stdcall external OMEGA_dll;

procedure Tex_SetFramesSize(
                             Texture     : PTexture;
                             FrameWidth  : Word;
                             FrameHeight : Word );
                                                     stdcall external OMEGA_dll;

//----------------------------------------------------------------------------//
//-----------------------  R E N D E R  T O  T E X T U R E  ------------------//
//----------------------------------------------------------------------------//
procedure Tex_BeginRenderIn(
                             Texture  : PTexture;
                             SaveOld  : Boolean = FALSE;
                             RealSize : Boolean = FALSE );
                                                     stdcall external OMEGA_dll;

procedure Tex_EndRenderIn;
                                                     stdcall external OMEGA_dll;

//----------------------------------------------------------------------------//
//----------------------------  C A M E R A  2 D  ----------------------------//
//----------------------------------------------------------------------------//

type
  TCamera2D = record
    X, Y     : Integer;
    Active   : Boolean;
    Reserved : DWORD;
end;
PCamera2D = ^TCamera2D;

function Cam2D_Create : PCamera2D;
                                                     stdcall external OMEGA_dll;

procedure Cam2D_Free(
                      var YourCamera : PCamera2D );
                                                     stdcall external OMEGA_dll;

procedure Cam2D_Set(
                     YourCamera : PCamera2D );
                                                     stdcall external OMEGA_dll;

//----------------------------------------------------------------------------//
//----------------------------------  F X  -----------------------------------//
//----------------------------------------------------------------------------//

const
  FX_BLEND    = $000001;
  FX_FLIPX    = $000002;
  FX_FLIPY    = $000004;
  FX_COLORMIX = $000008;
  FX_SCALE    = $000010;
  FX_VCHANGE  = $000020;
  FX_VCA      = $000040;

  FX_DEFAULT  = FX_BLEND;

  FX_BLEND_NORMAL = $000000;
  FX_BLEND_ADD    = $000001;
  FX_BLEND_MULT   = $000002;
  FX_BLEND_BLACK  = $000003;
  FX_BLEND_WHITE  = $000004;
  FX_BLEND_MASK   = $000005;

procedure FX_SetColorMix(
                          Color : Integer );
                                                     stdcall external OMEGA_dll;

procedure FX_SetBlendMode(
                           Mode : Integer );
                                                     stdcall external OMEGA_dll;

procedure FX_SetScale(
                       ScaleX, ScaleY : Single );
                                                     stdcall external OMEGA_dll;

procedure FX_SetVertexes(
                          X1, Y1 : Integer;
                          X2, Y2 : Integer;
                          X3, Y3 : Integer;
                          X4, Y4 : Integer );
                                                     stdcall external OMEGA_dll;

procedure FX_SetVCA(
                     C1, C2, C3, C4 : Integer;
                     A1, A2, A3, A4 : Byte );
                                                     stdcall external OMEGA_dll;

// B L U R
procedure FX_Blur_SetTex( TexToRender : PTexture );
                                                     stdcall external OMEGA_dll;

procedure FX_Blur_SetParams( Count, MoveX, MoveY : Integer );
                                                     stdcall external OMEGA_dll;

procedure FX_Blur_Calc(
                        RenderProc  : Pointer;
                        Delta       : Single;
                        Alpha       : Byte;
                        BlendMode   : Integer = FX_BLEND_NORMAL );
                                                     stdcall external OMEGA_dll;

procedure FX_Blur_Draw( Color : Integer; Alpha : Byte );
                                                     stdcall external OMEGA_dll;

// "R A D I A L"  B L U R
procedure FX_RadBlur_SetTex( TexToRender : PTexture );
                                                     stdcall external OMEGA_dll;

procedure FX_RadBlur_SetParams( Count, MoveX, MoveY : Integer );
                                                     stdcall external OMEGA_dll;

procedure FX_RadBlur_Calc(
                           RenderProc : Pointer;
                           Alpha      : Byte;
                           BlendMode  : Integer = FX_BLEND_NORMAL );
                                                     stdcall external OMEGA_dll;

procedure FX_RadBlur_Draw( Color : Integer; Alpha : Byte );
                                                     stdcall external OMEGA_dll;

//----------------------------------------------------------------------------//
//------------------------------  T E X T  2 D  ------------------------------//
//----------------------------------------------------------------------------//

type
  TSymbol = record
    X, Y  : WORD;
    Width : Byte;
end;

type
  TFont2D = record
    Height   : Byte;
    Sizes    : array[ 0..255 ] of TSymbol;
    Texture  : PTexture;
    Reserved : DWORD;
end;
PFont2D = ^TFont2D;

function Text_LoadFontFromFile(
                                FontTexture      : PChar;
                                FontInfo         : PChar;
                                TransparentColor : Integer = $000000;
                                TexFlags         : Integer = TEX_DEFAULT_2D ) : PFont2D;
                                                     stdcall external OMEGA_dll;

function Text_LoadFontFromMemory(
                                  FontTexture      : PMemory;
                                  FontTexType      : Integer;
                                  FontInfo         : PMemory;
                                  TransparentColor : Integer = $000000;
                                  TexFlags         : Integer = TEX_DEFAULT_2D ) : PFont2D;
                                                     stdcall external OMEGA_dll;

procedure Text_FreeFont(
                         var Font : PFont2D );
                                                     stdcall external OMEGA_dll;

procedure Text_Draw(
                     Font  : PFont2D;
                     X, Y  : Integer;
                     Text  : PChar;
                     Scale : Single  = 1.0;
                     Step  : Integer = 0;
                     Alpha : Byte    = 255;
                     Color : Integer = $FFFFFF );
                                                     stdcall external OMEGA_dll;

function Text_GetWidth(
                        Font  : PFont2D;
                        Text  : PChar;
                        Scale : Single  = 1.0;
                        Step  : Integer = 0 ) : Integer;
                                                     stdcall external OMEGA_dll;

//----------------------------------------------------------------------------//
//------------------------------  C O N S O L E  -----------------------------//
//----------------------------------------------------------------------------//

procedure Console_Active(
                          Enable : Boolean );
                                                     stdcall external OMEGA_dll;

procedure Console_SetOptions(
                              Font      : PFont2D;
                              Texture   : PTexture;
                              Color     : Integer = 0;
                              Alpha     : Byte    = 155;
                              FontColor : Integer = $FFFFFF;
                              FontAlpha : Byte    = 255 );
                                                     stdcall external OMEGA_dll;

procedure Console_ToLog(
                         Connect : Boolean );
                                                     stdcall external OMEGA_dll;

procedure Console_Draw;
                                                     stdcall external OMEGA_dll;

procedure Console_RegCommand(
                              Command : PChar;
                              Execute : Pointer );
                                                     stdcall external OMEGA_dll;

procedure Console_RegVariable(
                               VarName  : PChar;
                               Variable : PInteger );
                                                     stdcall external OMEGA_dll;

procedure Console_RegProcedure(
                                ProcName : PChar;
                                ProcPtr  : Pointer );
                                                     stdcall external OMEGA_dll;

procedure Console_AddString( Str : PChar );
                                                     stdcall external OMEGA_dll;

//----------------------------------------------------------------------------//
//-----------------------  P R I M I T I V E S  2 D  -------------------------//
//----------------------------------------------------------------------------//

const
  PR_FILL    = $000001;
  PR_SMOOTH  = $000002;

  PR_DEFAULT = 0;

type
  oePoint = record
    X, Y : Integer;
end;
oePPoint = ^oePoint;

type
  oeLine = record
    x0, y0 : Integer;
    x1, y1 : Integer;
end;
oePLine = ^oeLine;

type
  oeRect = record
    X      : Integer;
    Y      : Integer;
    Width  : Integer;
    Height : Integer;
end;
oePRect = ^oeRect;

type
  oeTriangle = record
    X1, Y1 : Integer;
    X2, Y2 : Integer;
    X3, Y3 : Integer;
end;
oePTriangle = ^oeTriangle;

type
  oeCircle = record
    cX, cY : Integer;
    Radius : Integer;
end;
oePCircle = ^oeCircle;

procedure Pr2D_PixelSize(
                          Size : Integer );
                                                     stdcall external OMEGA_dll;

procedure Pr2D_LineWidth(
                          Width : Integer );
                                                     stdcall external OMEGA_dll;


procedure Pr2D_Pixel(
                      X, Y  : Integer;
                      Color : Integer;
                      Alpha : Byte = 255 );
                                                     stdcall external OMEGA_dll;

procedure Pr2D_Line(
                     X1, Y1 : Integer;
                     X2, Y2 : Integer;
                     Color  : Integer;
                     Alpha  : Byte    = 255;
                     Flags  : Integer = PR_DEFAULT );
                                                     stdcall external OMEGA_dll;

procedure Pr2D_TLine(
                      Line  : oePLine;
                      Color : Integer;
                      Alpha : Byte    = 255;
                      Flags : Integer = PR_DEFAULT );
                                                     stdcall external OMEGA_dll;

procedure Pr2D_Rect(
                     X, Y          : Integer;
                     Width, Height : Integer;
                     Color         : Integer;
                     Alpha         : Byte    = 255;
                     Flags         : Integer = PR_DEFAULT );
                                                     stdcall external OMEGA_dll;

procedure Pr2D_TRect(
                      Rectangle : oePRect;
                      Color     : Integer;
                      Alpha     : Byte    = 255;
                      Flags     : Integer = PR_DEFAULT );
                                                     stdcall external OMEGA_dll;

procedure Pr2D_Triangle(
                         X1, Y1 : Integer;
                         X2, Y2 : Integer;
                         X3, Y3 : Integer;
                         Color  : Integer;
                         Alpha  : Byte    = 255;
                         Flags  : Integer = PR_DEFAULT );
                                                     stdcall external OMEGA_dll;

procedure Pr2D_TTriangle(
                          Triangle : oePTriangle;
                          Color    : Integer;
                          Alpha    : Byte    = 255;
                          Flags    : Integer = PR_DEFAULT );
                                                     stdcall external OMEGA_dll;

procedure Pr2D_Circle(
                       cX, cY  : Integer;
                       Radius  : Integer;
                       Color   : Integer;
                       Alpha   : Byte    = 255;
                       Quality : Integer = 32;
                       Flags   : Integer = PR_DEFAULT );
                                                     stdcall external OMEGA_dll;

procedure Pr2D_TCircle(
                        Circle  : oePCircle;
                        Color   : Integer;
                        Alpha   : Byte    = 255;
                        Quality : Integer = 32;
                        Flags   : Integer = PR_DEFAULT );
                                                     stdcall external OMEGA_dll;

procedure Pr2D_Ellipse(
                        cX, cY  : Integer;
                        xRadius : Integer;
                        yRadius : Integer;
                        Color   : Integer;
                        Alpha   : Byte    = 255;
                        Quality : Integer = 32;
                        Flags   : Integer = PR_DEFAULT );
                                                     stdcall external OMEGA_dll;

procedure Pr2D_Polygon(
                        Points  : array of oePoint;
                        PCount  : Integer;
                        Color   : Integer;
                        Alpha   : Byte    = 255;
                        Flags   : Integer = PR_DEFAULT );
                                                     stdcall external OMEGA_dll;

//----------------------------------------------------------------------------//
//----------------------------  S P R I T E S  -------------------------------//
//----------------------------------------------------------------------------//

// S T A T I C
procedure SSprite_Draw(
                        Tex           : PTexture;
                        X, Y          : Integer;
                        Width, Height : Integer;
                        Alpha         : Byte    = 255;
                        Angle         : Integer = 0;
                        Flags         : Integer = FX_DEFAULT );
                                                     stdcall external OMEGA_dll;

// A N I M A T E D
procedure ASprite_Draw(
                        Tex           : PTexture;
                        X, Y          : Integer;
                        Width, Height : Integer;
                        FrameNow      : Integer;
                        Alpha         : Byte    = 255;
                        Angle         : Integer = 0;
                        Flags         : Integer = FX_DEFAULT );
                                                     stdcall external OMEGA_dll;

// C U T
procedure CSprite_Draw(
                        Tex           : PTexture;
                        X, Y          : Integer;
                        Width, Height : Integer;
                        CutRect       : oePRect;
                        Alpha         : Byte    = 255;
                        Angle         : Integer = 0;
                        Flags         : Integer = FX_DEFAULT );
                                                     stdcall external OMEGA_dll;

//----------------------------------------------------------------------------//
//------------------------------  T I L E S  ---------------------------------//
//----------------------------------------------------------------------------//

// S T A T I C
procedure STile_Draw(
                      Tex            : PTexture;
                      X, Y           : Integer;
                      Width, Height  : Integer;
                      TilesX, TilesY : Integer;
                      Alpha          : Byte    = 255;
                      Flags          : Integer = FX_DEFAULT );
                                                     stdcall external OMEGA_dll;

// A N I M A T E D
procedure ATile_Draw(
                      Tex            : PTexture;
                      X, Y           : Integer;
                      Width, Height  : Integer;
                      TilesX, TilesY : Integer;
                      FrameNow       : Integer;
                      Alpha          : Byte    = 255;
                      Flags          : Integer = FX_DEFAULT );
                                                     stdcall external OMEGA_dll;

//----------------------------------------------------------------------------//
//---------------------------  D R A W  L I S T  -----------------------------//
//----------------------------------------------------------------------------//
function DrawList_Begin : DWORD;
                                                     stdcall external OMEGA_dll;

procedure DrawList_End;
                                                     stdcall external OMEGA_dll;

procedure DrawList_Free( List : DWORD );
                                                     stdcall external OMEGA_dll;

procedure DrawList_Draw( List : DWORD );
                                                     stdcall external OMEGA_dll;

//----------------------------------------------------------------------------//
//-----------------------------  S C I S S O R  ------------------------------//
//----------------------------------------------------------------------------//

procedure Scissor_Begin( X, Y, Width, Height : Integer );
                                                     stdcall external OMEGA_dll;

procedure Scissor_End;
                                                     stdcall external OMEGA_dll;

//----------------------------------------------------------------------------//
//------------------------------  S O U N D  ---------------------------------//
//----------------------------------------------------------------------------//

type PSound = Pointer;

function Snd_Init : Boolean;
                                                     stdcall external OMEGA_dll;

procedure Snd_Enable;
                                                     stdcall external OMEGA_dll;

procedure Snd_Disable;
                                                     stdcall external OMEGA_dll;

function Snd_LoadFromFile(
                           FileName    : PChar;
                           BufferCount : Integer ) : PSound;
                                                     stdcall external OMEGA_dll;

function Snd_LoadFromMemory(
                             Memory      : PMemory;
                             BufferCount : Integer ) : PSound;
                                                     stdcall external OMEGA_dll;

function Snd_Free(
                   Sound : PSound ) : Boolean;
                                                     stdcall external OMEGA_dll;

procedure Snd_SetBuffersCount(
                               Sound : PSound;
                               Count : Integer );
                                                     stdcall external OMEGA_dll;

// Нормализация громкости к размерности 0..100
function VOLUME( Value : Byte ) : Integer; stdcall;

function Snd_Play(
                   Sound      : PSound;
                   Pan        : Integer = 0;
                   Volume     : Integer = 0;
                   Frequency  : Integer = 0;
                   Loop       : Boolean = FALSE ) : Integer;
                                                     stdcall external OMEGA_dll;

procedure Snd_PlayID(
                      Sound      : PSound;
                      ID         : Integer;
                      Pan        : Integer = 0;
                      Volume     : Integer = 0;
                      Frequency  : Integer = 0;
                      Loop       : Boolean = FALSE );
                                                     stdcall external OMEGA_dll;

procedure Snd_Stop(
                    Sound : PSound );
                                                     stdcall external OMEGA_dll;

procedure Snd_StopID(
                      Sound : PSound;
                      ID    : Integer );
                                                     stdcall external OMEGA_dll;

procedure Snd_StopAll;
                                                     stdcall external OMEGA_dll;

procedure Snd_ChangeParam(
                           Sound     : PSound;
                           ID        : Integer;
                           Pan       : Integer;
                           Volume    : Integer;
                           Frequency : Integer );
                                                     stdcall external OMEGA_dll;

//----------------------------------------------------------------------------//
//-------------------------------  M E D I A  --------------------------------//
//----------------------------------------------------------------------------//

procedure Media_Play(
                      FileName : PChar;
                      Loop     : Boolean );
                                                     stdcall external OMEGA_dll;

procedure Media_Replay;
                                                     stdcall external OMEGA_dll;

procedure Media_Pause;
                                                     stdcall external OMEGA_dll;

procedure Media_Resume;
                                                     stdcall external OMEGA_dll;

procedure Media_Stop;
                                                     stdcall external OMEGA_dll;

procedure Media_SetVolume(
                           Volume : Integer );
                                                     stdcall external OMEGA_dll;

function  Media_GetLength : Double;
                                                     stdcall external OMEGA_dll;

procedure Media_SetPosition(
                             Position : Double );
                                                     stdcall external OMEGA_dll;

function Media_GetPosition : Double;
                                                     stdcall external OMEGA_dll;

procedure Media_SetWindowRect(
                               X, Y, Width, Height : Integer );
                                                     stdcall external OMEGA_dll;

//----------------------------------------------------------------------------//
//---------------------------  C O L L I S I O N  ----------------------------//
//----------------------------------------------------------------------------//

type
  TPoint2D = oePoint;
  PPoint2D = oePPoint;

type
  TLine2D = oeLine;
  PLine2D = oePLine;

type
  TPolyLine2D = record
    Count  : DWORD;
    cX, cY : Integer;
    Points : array of TPoint2D;
end;
PPolyLine2D = ^TPolyLine2D;

type
  TAABB2D = oeRect;
  PAABB2D = oePRect;

type
  TOBB2D = record
    X, Y   : Integer;
    Width  : Integer;
    Height : Integer;
    Angle  : Integer;
end;
POBB2D = ^TOBB2D;

type
  TCircle2D = oeCircle;
  PCircle2D = oePCircle;

// P O I N T ' s
function Col_PointInAABB(
                          X, Y : Integer;
                          AABB : PAABB2D ) : Boolean;
                                                     stdcall external OMEGA_dll;

function Col_PointInCircle(
                            X, Y : Integer;
                            Circ : PCircle2D ) : Boolean;
                                                     stdcall external OMEGA_dll;

function Col_PointInPolyLine(
                              X, Y : Integer;
                              PL   : PPolyLine2D ) : Boolean;
                                                     stdcall external OMEGA_dll;

// L I N E ' s
function Col_Line(
                   A, B : PLine2D ) : Boolean;
                                                     stdcall external OMEGA_dll;

function Col_LineVsAABB(
                         A    : PLine2D;
                         AABB : PAABB2D ) : Boolean;
                                                     stdcall external OMEGA_dll;

function Col_LineVsCircle(
                           L    : PLine2D;
                           Circ : PCircle2D ) : Boolean;
                                                     stdcall external OMEGA_dll;

function Col_LineVsCircleXY(
                             L    : PLine2D;
                             Circ : PCircle2D;
                             Precision : Integer ) : Boolean;
                                                     stdcall external OMEGA_dll;

function Col_LineVsPolyLine(
                             A : PLine2D;
                             B : PPolyLine2D ) : Boolean;
                                                     stdcall external OMEGA_dll;

// P O L Y L I N E ' s
function Col_PolyLine(
                       A, B : PPolyLine2D ) : Boolean;
                                                     stdcall external OMEGA_dll;

function Col_PolyLineVsAABB(
                             A    : PPolyLine2D;
                             AABB : PAABB2D ) : Boolean;
                                                     stdcall external OMEGA_dll;

function Col_PolyLineVsCircle(
                               A    : PPolyLine2D;
                               Circ : PCircle2D ) : Boolean;
                                                     stdcall external OMEGA_dll;

// A A B B ' s
function Col_AABB(
                   AABB1, AABB2 : PAABB2D ) : Boolean;
                                                     stdcall external OMEGA_dll;

function Col_AABBInAABB(
                         AABB1, AABB2 : PAABB2D ) : Boolean;
                                                     stdcall external OMEGA_dll;

function Col_AABBInCircle(
                           AABB : PAABB2D;
                           Circ : PCircle2D ) : Boolean;
                                                     stdcall external OMEGA_dll;

function Col_AABBVsCircle(
                           AABB : PAABB2D;
                           Circ : PCircle2D ) : Boolean;
                                                     stdcall external OMEGA_dll;

// C I R C L E ' s
function Col_Circle(
                     Circ1, Circ2 : PCircle2D ) : Boolean;
                                                     stdcall external OMEGA_dll;

function Col_CircleInCircle(
                             Circ1, Circ2 : PCircle2D ) : Boolean;
                                                     stdcall external OMEGA_dll;

function Col_CircleInAABB(
                           Circ : PCircle2D;
                           AABB : PAABB2D ) : Boolean;
                                                     stdcall external OMEGA_dll;

// E X T E N D E D  F U N C T I O N S
// G E T ' s
function ColEx_LastX : Single;
                                                     stdcall external OMEGA_dll;
function ColEx_LastY : Single;
                                                     stdcall external OMEGA_dll;

function ColEx_LastLineA : Integer;
                                                     stdcall external OMEGA_dll;
function ColEx_LastLineB : Integer;
                                                     stdcall external OMEGA_dll;

// T R A N S F O R M A T I O N ' s
procedure ColEx_PolyRotate(
                            A, B  : PPolyLine2D;
                            Angle : Integer );
                                                     stdcall external OMEGA_dll;

procedure ColEx_PolyScale(
                           A              : PPolyLine2D;
                           ScaleX, ScaleY : Single );
                                                     stdcall external OMEGA_dll;

procedure ColEx_PolyMove(
                          A, B : PPolyLine2D;
                          X, Y : Integer );
                                                     stdcall external OMEGA_dll;

procedure ColEx_PolyCenter(
                            A : PPolyLine2D );
                                                     stdcall external OMEGA_dll;

procedure ColEx_PolyRect(
                          A    : PPolyLine2D;
                          Rect : PAABB2D );
                                                     stdcall external OMEGA_dll;

// L I N E ' s
procedure ColEx_CalcLineCross(
                               A, B : PLine2D );
                                                     stdcall external OMEGA_dll;

//----------------------------------------------------------------------------//
//----------------------------  F A S T  M A T H  ----------------------------//
//----------------------------------------------------------------------------//

function M_Cos(
                Angle : Integer ) : Single;
                                                     stdcall external OMEGA_dll;

function M_Sin(
                Angle : Integer ) : Single;
                                                     stdcall external OMEGA_dll;

function M_CosF(
                 Angle : Integer ) : Single;
                                                     stdcall external OMEGA_dll;

function M_SinF(
                 Angle : Integer ) : Single;
                                                     stdcall external OMEGA_dll;

function M_Round(
                  Value : Single ) : Integer;
                                                     stdcall external OMEGA_dll;

function M_Trunc(
                  Value : Single ) : Integer;
                                                     stdcall external OMEGA_dll;

function M_Distance(
                     X1, Y1, X2, Y2 : Single ) : Single;
                                                     stdcall external OMEGA_dll;

function M_FindAngle(
                      X1, Y1, X2, Y2 : Integer ) : Integer;
                                                     stdcall external OMEGA_dll;

//----------------------------------------------------------------------------//
//--------------------------------  U T I L S  -------------------------------//
//----------------------------------------------------------------------------//

// H A R D W A R E
function U_GetCPUName : PChar;
                                                     stdcall external OMEGA_dll;

function U_GetTotalRAM : Integer;
                                                     stdcall external OMEGA_dll;


function U_Is3DAccelerator : Boolean;
                                                     stdcall external OMEGA_dll;

function U_GetMaxTexSize : Integer;
                                                     stdcall external OMEGA_dll;
function U_GetMaxAnisotropy : Integer;
                                                     stdcall external OMEGA_dll;

// A D D I T I O N A L  F O R  E N G I N E
procedure U_SnapShot( Path, FileName : PChar );
                                                     stdcall external OMEGA_dll;

// C O N V E R T
function U_IntToStr(
                     Num : Integer ) : PChar; overload;
                                                     stdcall external OMEGA_dll;

function U_StrToInt(
                     Str : PChar ) : Integer; overload;
                                                     stdcall external OMEGA_dll;

function U_FloatToStr(
                       Num : Single ) : PChar;
                                                     stdcall external OMEGA_dll;

function U_GetTime : DWORD;
                                                     stdcall external OMEGA_dll;

//----------------------------------------------------------------------------//
                                 IMPLEMENTATION
//----------------------------------------------------------------------------//

function VOLUME;
Begin
Result := -100 * ( 100 - Value );
End;

initialization
// Очень важно!!! Я сам было чуть веру в жизнь не потерял когда Delphi постоянно
// выбивал левые ошибки когда речь идет о record'ах с дин-массивами внутри...
// Эту функцию надо вызвать в любом случаи. Она отключает какие-то ошибки свзяннаые
// с плавающей запятой. Большинство прогеров использующих OpenGL даже наверно и не
// догадываются что эту функцию им тоже надо вызывать, но она по автомату стоит
// в инициализации модуля OpenGL.
  Set8087CW( $133F );
end.
