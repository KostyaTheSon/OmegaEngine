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

#include <windows.h>
#include "OMEGA_types.h"

HINSTANCE dll = LoadLibrary("OMEGA.dll");

//----------------------------------------------------------------------------//
//-----------------------------  E N G I N E  --------------------------------//
//----------------------------------------------------------------------------//

// S T A R T
OE_Init_ _OE_Init;
inline void OE_Init( BYTE zBits = 16, BYTE stencilBits = 0 )
{
  _OE_Init( zBits, stencilBits );
}

OE_Init2_ _OE_Init2;
inline void OE_Init2( DWORD hwnd )
{
  _OE_Init2(hwnd);
}

OE_Quit_ _OE_Quit;
inline void OE_Quit(void)
{
  _OE_Quit();
}

// M A I N
OE_RegProcedure_ _OE_RegProcedure;
inline void OE_RegProcedure( BYTE  PType, void* PAddress )
{
  _OE_RegProcedure( PType, (void*)PAddress );
}

OE_UnRegProcedure_ _OE_UnRegProcedure;
inline void OE_UnRegProcedure( void* PAddress )
{
  _OE_UnRegProcedure( (void*)PAddress );
}

OE_UnRegProcedureT_ _OE_UnRegProcedureT;
void OE_UnRegProcedureT( bool Draw, bool Init, bool Quit, bool FastInit )
{
  _OE_UnRegProcedureT( Draw, Init, Quit, FastInit );
}

Timer_Create_ _Timer_Create;
inline PTimer Timer_Create( void* OnTimer, int Interval, int Precision )
{
  return _Timer_Create( (void*)OnTimer, Interval, Precision );
}

Timer_Free_ _Timer_Free;
inline void Timer_Free( PTimer& Timer )
{
  _Timer_Free( Timer );
}

// O P T I O N S
//FLAGS
OE_Enable_ _OE_Enable;
inline void OE_Enable( int What )
{
  _OE_Enable( What );
}

OE_Disable_ _OE_Disable;
inline void OE_Disable( int What )
{
  _OE_Disable( What );
}

//WINDOW
OE_SetWndOnTop_ _OE_SetWndOnTop;
inline void OE_SetWndOnTop( bool Enable )
{
  _OE_SetWndOnTop( Enable );
}

OE_SetWndPosition_ _OE_SetWndPosition;
inline void OE_SetWndPosition( int X, int Y )
{
  _OE_SetWndPosition( X, Y );
}

OE_SetWndName_ _OE_SetWndName;
inline void OE_SetWndName( char* NewName )
{
  _OE_SetWndName( NewName );
}

OE_ShowCursor_ _OE_ShowCursor;
inline void OE_ShowCursor( bool Show )
{
  _OE_ShowCursor( Show );
}

OE_ResizeWindow_ _OE_ResizeWindow;
inline void OE_ResizeWindow( int Width, int Height )
{
  _OE_ResizeWindow( Width, Height );
}

//SCREEN
OE_SetScreenOptions_ _OE_SetScreenOptions;
inline void OE_SetScreenOptions( int Width, int Height, int BPP, int Refresh, bool FullScreen, bool WaitVSync )
{
  _OE_SetScreenOptions( Width, Height, BPP, Refresh, FullScreen, WaitVSync );
}

OE_ChangeScreenOptions_ _OE_ChangeScreenOptions;
inline void OE_ChangeScreenOptions( int Width, int Height, int BPP, int Refresh, bool FullScreen, bool WaitVSync )
{
  _OE_ChangeScreenOptions( Width, Height, BPP, Refresh, FullScreen, WaitVSync );
}

OE_SetResolutionDependence_ _OE_SetResolutionDependence;
inline void OE_SetScreenOptions( int NormalResX, int NormalResY )
{
  _OE_SetResolutionDependence( NormalResX, NormalResY );
}

OE_SetVSync_ _OE_SetVSync;
inline void OE_SetVSync( bool WaitVSync )
{
  _OE_SetVSync( WaitVSync );
}

//GET
OE_GetOptions_ _OE_GetOptions;
inline POptions OE_GetOptions(void)
{
  return _OE_GetOptions();
}

// A D D I T I O N A L
OE_SetAdvancedOptions_ _OE_SetAdvancedOptions;
inline void OE_SetAdvancedOptions( bool UseLog, bool AppCanClose, bool HaltOnExit )
{
  _OE_SetAdvancedOptions( UseLog, AppCanClose, HaltOnExit );
}

OE_GetFPS_ _OE_GetFPS;
inline int OE_GetFPS(void)
{
  return _OE_GetFPS();
}

//----------------------------------------------------------------------------//
//-----------------------------  H T M L  L O G  -----------------------------//
//----------------------------------------------------------------------------//

LOG_SetOptions_ _LOG_SetOptions;
inline void LOG_SetOptions( char* clrBODY,
                            char* clrTIME,
                            char* clrENGINE,
                            char* clrAPP,
                            char* clrCONSOLE,
                            char* clrMESS,
                            char* clrWARNING,
                            char* clrERROR,
                            BYTE  sTIME,
                            BYTE  sENGINE,
                            BYTE  sAPP,
                            BYTE  sCONSOLE,
                            BYTE  sMESS,
                            BYTE  sWARNING,
                            BYTE  sERROR )
{
  _LOG_SetOptions( clrBODY, clrTIME, clrENGINE, clrAPP, clrCONSOLE, clrMESS, clrWARNING, clrERROR,
                   sTIME, sENGINE, sAPP, sCONSOLE, sMESS, sWARNING, sERROR );
}

LOG_Init_ _LOG_Init;
inline void LOG_Init( char* FileName, bool Create )
{
  _LOG_Init( FileName, Create );
}

LOG_AddMessage_ _LOG_AddMessage;
inline void LOG_AddMessage( BYTE MessageType, char* Text )
{
  _LOG_AddMessage( MessageType, Text );
}

LOG_AddLine_ _LOG_AddLine;
inline void LOG_AddLine( int Size, char* Color )
{
  _LOG_AddLine( Size, Color );
}

//----------------------------------------------------------------------------//
//------------------------------  I N P U T  ---------------------------------//
//----------------------------------------------------------------------------//

// K E Y B O A R D
Key_LoadLayout_ _Key_LoadLayout;
inline void Key_LoadLayout( char* Layout )
{
  _Key_LoadLayout( Layout );
}

KeyEx_Down_ _KeyEx_Down;
inline bool KeyEx_Down( BYTE KeyCode )
{
  return _KeyEx_Down( KeyCode );
}

Key_Down_ _Key_Down;
inline bool Key_Down( BYTE KeyCode )
{
  return _Key_Down( KeyCode );
}

Key_Press_ _Key_Press;
inline bool Key_Press( BYTE KeyCode )
{
  return _Key_Press( KeyCode );
}

Key_LastDown_ _Key_LastDown;
inline BYTE Key_LastDown(void)
{
  return _Key_LastDown();
}

Key_LastPress_ _Key_LastPress;
inline BYTE Key_LastPress(void)
{
  return _Key_LastPress();
}

Key_BeginReadText_ _Key_BeginReadText;
inline void Key_BeginReadText( char* StartText )
{
  _Key_BeginReadText( StartText );
}

Key_EndReadText_ _Key_EndReadText;
inline char* Key_EndReadText(void)
{
  return _Key_EndReadText();
}

Key_MaxReadText_ _Key_MaxReadText;
inline void Key_MaxReadText( int Count )
{
  _Key_MaxReadText( Count );
}

// M O U S E
MouseEx_X_ _MouseEx_X;
inline int MouseEx_X(void)
{
  return _MouseEx_X();
}

MouseEx_Y_ _MouseEx_Y;
inline int MouseEx_Y(void)
{
  return _MouseEx_Y();
}

MouseEx_Down_ _MouseEx_Down;
inline bool MouseEx_Down( BYTE Button )
{
  return _MouseEx_Down( Button );
}

Mouse_X_ _Mouse_X;
inline int Mouse_X(void)
{
  return _Mouse_X();
}

Mouse_Y_ _Mouse_Y;
inline int Mouse_Y(void)
{
  return _Mouse_Y();
}

Mouse_Move_ _Mouse_Move;
inline bool Mouse_Move(void)
{
  return _Mouse_Move();
}

Mouse_Lock_ _Mouse_Lock;
inline void Mouse_Lock(void)
{
  _Mouse_Lock();
}

Mouse_DeltaX_ _Mouse_DeltaX;
inline int Mouse_DeltaX(void)
{
  return _Mouse_DeltaX();
}

Mouse_DeltaY_ _Mouse_DeltaY;
inline int Mouse_DeltaY(void)
{
  return _Mouse_DeltaY();
}

Mouse_Down_ _Mouse_Down;
inline bool Mouse_Down( BYTE Button )
{
  return _Mouse_Down( Button );
}

Mouse_Press_ _Mouse_Press;
inline bool Mouse_Press( BYTE Button )
{
  return _Mouse_Press( Button );
}

Mouse_Click_ _Mouse_Click;
inline bool Mouse_Click( BYTE Button )
{
  return _Mouse_Click( Button );
}

Mouse_DblClick_ _Mouse_DblClick;
inline bool Mouse_DblClick( BYTE Button )
{
  return _Mouse_DblClick( Button );
}

Mouse_WheelUp_ _Mouse_WheelUp;
inline bool Mouse_WheelUp(void)
{
  return _Mouse_WheelUp();
}

Mouse_WheelDown_ _Mouse_WheelDown;
inline bool Mouse_WheelDown(void)
{
  return _Mouse_WheelDown();
}

// J O Y P A D
Joy_Down_ _Joy_Down;
inline bool Joy_Down( int Joy, int Button )
{
  return _Joy_Down( Joy, Button );
}

Joy_Press_ _Joy_Press;
inline bool Joy_Press( int Joy, int Button )
{
  return _Joy_Press( Joy, Button );
}

Joy_AxePos_ _Joy_AxePos;
inline bool Joy_AxePos( int Joy, int AxePos )
{
  return _Joy_AxePos( Joy, AxePos );
}

//----------------------------------------------------------------------------//
//----------------------------  T E X T U R E S  -----------------------------//
//----------------------------------------------------------------------------//

Tex_SetAnisotropyLevel_ _Tex_SetAnisotropyLevel;
inline void Tex_SetAnisotropyLevel( int Level )
{
	_Tex_SetAnisotropyLevel( Level );
}

Tex_CreateZero_ _Tex_CreateZero;
inline PTexture Tex_CreateZero( int Width, int Height, int Flags )
{
	return _Tex_CreateZero( Width, Height, Flags );
}

Tex_LoadFromFile_ _Tex_LoadFromFile;
inline PTexture Tex_LoadFromFile( char* FileName, int TransparentColor, int Flags )
{
  return _Tex_LoadFromFile( FileName, TransparentColor, Flags );
}

Tex_LoadFromMemory_ _Tex_LoadFromMemory;
inline PTexture Tex_LoadFromFile( PMemory Memory, int FormatType, int TransparentColor, int Flags )
{
  return _Tex_LoadFromMemory( Memory, FormatType, TransparentColor, Flags );
}

Tex_Free_ _Tex_Free;
inline void Tex_Free( PTexture &Texture )
{
  _Tex_Free( Texture );
}

Tex_LoadMaskFromFile_ _Tex_LoadMaskFromFile;
inline void Tex_LoadMaskFromFile( char* FileName )
{
  _Tex_LoadMaskFromFile( FileName );
}

Tex_LoadMaskFromMemory_ _Tex_LoadMaskFromMemory;
inline void Tex_LoadMaskFromMemory( PMemory Memory )
{
  _Tex_LoadMaskFromMemory( Memory );
}

Tex_FreeMask_ _Tex_FreeMask;
inline void Tex_FreeMask(void)
{
  _Tex_FreeMask();
}

Tex_SetFramesSize_ _Tex_SetFramesSize;
inline void Tex_SetFramesSize( PTexture Texture, WORD FrameWidth, WORD FrameHeight )
{
  _Tex_SetFramesSize( Texture, FrameWidth, FrameHeight );
}

//----------------------------------------------------------------------------//
//-----------------------  R E N D E R  T O  T E X T U R E  ------------------//
//----------------------------------------------------------------------------//

Tex_BeginRenderIn_ _Tex_BeginRenderIn;
inline void Tex_BeginRenderIn( PTexture Texture, bool SaveOld, bool RealSize )
{
	_Tex_BeginRenderIn( Texture, SaveOld, RealSize );
}

Tex_EndRenderIn_ _Tex_EndRenderIn;
inline void Tex_EndRenderIn(void)
{
	_Tex_EndRenderIn();
}

//----------------------------------------------------------------------------//
//----------------------------  C A M E R A  2 D  ----------------------------//
//----------------------------------------------------------------------------//

Cam2D_Create_ _Cam2D_Create;
inline PCamera2D Cam2D_Create(void)
{
  return _Cam2D_Create();
}

Cam2D_Free_ _Cam2D_Free;
inline void Cam2D_Free( PCamera2D& YourCamera )
{
  _Cam2D_Free( YourCamera );
}

Cam2D_Set_ _Cam2D_Set;
inline void Cam2D_Set( PCamera2D YourCamera )
{
  _Cam2D_Set( YourCamera );
}

//----------------------------------------------------------------------------//
//----------------------------------  F X  -----------------------------------//
//----------------------------------------------------------------------------//

FX_SetColorMix_ _FX_SetColorMix;
inline void FX_SetColorMix( int Color )
{
  _FX_SetColorMix( Color );
}

FX_SetBlendMode_ _FX_SetBlendMode;
inline void FX_SetBlendMode( int Mode )
{
  _FX_SetBlendMode( Mode );
}

FX_SetScale_ _FX_SetScale;
inline void FX_SetScale( float ScaleX, float ScaleY )
{
  _FX_SetScale( ScaleX, ScaleY );
}

FX_SetVertexes_ _FX_SetVertexes;
inline void FX_SetVertexes( int X1, int Y1, int X2, int Y2, int X3, int Y3, int X4, int Y4 )
{
  _FX_SetVertexes( X1, Y1, X2, Y2, X3, Y3, X4, Y4 );
}


FX_SetVCA_ _FX_SetVCA;
inline void FX_SetVCA( int C1, int C2, int C3, int C4, BYTE A1, BYTE A2, BYTE A3, BYTE A4 )
{
  _FX_SetVCA( C1, C2, C3, C4, A1, A2, A3, A4 );
}

// B L U R
FX_Blur_SetTex_ _FX_Blur_SetTex;
void FX_Blur_SetTex( PTexture TexToRender )
{
  _FX_Blur_SetTex( TexToRender );
}

FX_Blur_SetParams_ _FX_Blur_SetParams;
void FX_Blur_SetParams( int Count, int MoveX, int MoveY )
{
  _FX_Blur_SetParams( Count, MoveX, MoveY );
}

FX_Blur_Calc_ _FX_Blur_Calc;
void FX_Blur_Calc( void* RenderProc, float Delta, BYTE Alpha, int BlendMode )
{
  _FX_Blur_Calc( (void*)RenderProc, Delta, Alpha, BlendMode );
}

FX_Blur_Draw_ _FX_Blur_Draw;
void FX_Blur_Draw( int Color, BYTE Alpha )
{
  _FX_Blur_Draw( Color, Alpha );
}

// "R A D I A L"  B L U R
FX_RadBlur_SetTex_ _FX_RadBlur_SetTex;
void FX_RadBlur_SetTex( PTexture TexToRender )
{
  _FX_RadBlur_SetTex( TexToRender );
}

FX_RadBlur_SetParams_ _FX_RadBlur_SetParams;
void FX_RadBlur_SetParams( int Count, int MoveX, int MoveY )
{
  _FX_RadBlur_SetParams( Count, MoveX, MoveY );
}

FX_RadBlur_Calc_ _FX_RadBlur_Calc;
void FX_RadBlur_Calc( void* RenderProc, BYTE Alpha, int BlendMode )
{
  _FX_RadBlur_Calc( (void*)RenderProc, Alpha, BlendMode );
}

FX_RadBlur_Draw_ _FX_RadBlur_Draw;
void FX_RadBlur_Draw( int Color, BYTE Alpha )
{
  _FX_RadBlur_Draw( Color, Alpha );
}

//----------------------------------------------------------------------------//
//------------------------------  T E X T  2 D  ------------------------------//
//----------------------------------------------------------------------------//

Text_LoadFontFromFile_ _Text_LoadFontFromFile;
inline PFont2D Text_LoadFontFromFile( char* FontTexture, char* FontInfo, int TransparentColor, int TexFlags )
{
	return _Text_LoadFontFromFile( FontTexture, FontInfo, TransparentColor, TexFlags );
}

Text_LoadFontFromMemory_ _Text_LoadFontFromMemory;
inline PFont2D Text_LoadFontFromMemory( PMemory FontTexture, int FontTexType, PMemory FontInfo, int TransparentColor, int TexFlags )
{
	return _Text_LoadFontFromMemory( FontTexture, FontTexType, FontInfo, TransparentColor, TexFlags );
}

Text_FreeFont_ _Text_FreeFont;
inline void Text_FreeFont( PFont2D &Font )
{
_Text_FreeFont( Font );
}

Text_Draw_ _Text_Draw;
inline void Text_Draw( PFont2D Font, int X, int Y, char* Text, float Scale, int Step, BYTE Alpha, int Color )
{
_Text_Draw( Font, X, Y, Text, Scale, Step, Alpha, Color );
}

Text_GetWidth_ _Text_GetWidth;
inline int Text_GetWidth( PFont2D Font, char* Text, float Scale, int Step )
{
	return _Text_GetWidth( Font, Text, Scale, Step );
}

//----------------------------------------------------------------------------//
//------------------------------  C O N S O L E  -----------------------------//
//----------------------------------------------------------------------------//

Console_Active_ _Console_Active;
inline void Console_Active( bool Enable )
{
  _Console_Active( Enable );
}

Console_SetOptions_ _Console_SetOptions;
inline void Console_SetOptions( PFont2D Font, PTexture Texture, int Color, BYTE Alpha, int FontColor, int FontAlpha )
{
  _Console_SetOptions( Font, Texture, Color, Alpha, FontColor, FontAlpha );
}

Console_ToLog_ _Console_ToLog;
inline void Console_ToLog( bool Connect )
{
  _Console_ToLog( Connect );
}

Console_Draw_ _Console_Draw;
inline void Console_Draw(void)
{
  _Console_Draw();
}

Console_RegCommand_ _Console_RegCommand;
inline void Console_RegCommand( char* Command, void* Execute )
{
  _Console_RegCommand( Command, (void*)Execute );
}

Console_RegVariable_ _Console_RegVariable;
inline void Console_RegVariable( char* VarName, int* Variable )
{
  _Console_RegVariable( VarName, Variable );
}

Console_RegProcedure_ _Console_RegProcedure;
inline void Console_RegProcedure( char* ProcName, void* ProcPtr )
{
  _Console_RegProcedure( ProcName, (void*)ProcPtr );
}

Console_AddString_ _Console_AddString;
inline void Console_AddString( char* Str )
{
  _Console_AddString( Str );
}

//----------------------------------------------------------------------------//
//-----------------------  P R I M I T I V E S  2 D  -------------------------//
//----------------------------------------------------------------------------//

Pr2D_PixelSize_ _Pr2D_PixelSize;
inline void Pr2D_PixelSize( int Size )
{
  _Pr2D_PixelSize( Size );
}

Pr2D_LineWidth_ _Pr2D_LineWidth;
inline void Pr2D_LineWidth( int Width )
{
  _Pr2D_LineWidth( Width );
}


Pr2D_Pixel_ _Pr2D_Pixel;
inline void Pr2D_Pixel( int X, int Y, int Color, BYTE Alpha )
{
  _Pr2D_Pixel( X, Y, Color, Alpha );
}

Pr2D_Line_ _Pr2D_Line;
inline void Pr2D_Line( int X1, int Y1, int X2, int Y2, int Color, BYTE Alpha, int Flags )
{
  _Pr2D_Line( X1, Y1, X2, Y2, Color, Alpha, Flags );
}

Pr2D_TLine_ _Pr2D_TLine;
inline void Pr2D_TLine( oePLine Line, int Color, BYTE Alpha, int Flags )
{
  _Pr2D_TLine( Line, Color, Alpha, Flags );
}

Pr2D_Rect_ _Pr2D_Rect;
inline void Pr2D_Rect( int X, int Y, int Width, int Height, int Color, BYTE Alpha, int Flags )
{
  _Pr2D_Rect( X, Y, Width, Height, Color, Alpha, Flags );
}

Pr2D_TRect_ _Pr2D_TRect;
inline void Pr2D_TRect( oePRect Rectangle, int Color, BYTE Alpha, int Flags )
{
  _Pr2D_TRect( Rectangle, Color, Alpha, Flags );
}

Pr2D_Triangle_ _Pr2D_Triangle;
inline void Pr2D_Triangle( int X1, int Y1, int X2, int Y2, int X3, int Y3, int Color, BYTE Alpha, int Flags )
{
  _Pr2D_Triangle( X1, Y1, X2, Y2, X3, Y3, Color, Alpha, Flags );
}

Pr2D_TTriangle_ _Pr2D_TTriangle;
inline void Pr2D_TTriangle( oePTriangle Triangle, int Color, BYTE Alpha, int Flags )
{
  _Pr2D_TTriangle( Triangle, Color, Alpha, Flags );
}

Pr2D_Circle_ _Pr2D_Circle;
inline void Pr2D_Circle( int cX, int cY, int Radius, int Color, BYTE Alpha, int Quality, int Flags )
{
  _Pr2D_Circle( cX, cY, Radius, Color, Alpha, Quality, Flags );
}

Pr2D_TCircle_ _Pr2D_TCircle;

inline void Pr2D_TCircle( oePCircle Circle, int Color, BYTE Alpha, int Quality, int Flags )
{
  _Pr2D_TCircle( Circle, Color, Alpha, Quality, Flags );
}

Pr2D_Ellipse_ _Pr2D_Ellipse;
inline void Pr2D_Ellipse( int cX, int cY, int xRadius, int yRadius, int Color, BYTE Alpha, int Quality, int Flags )
{
  _Pr2D_Ellipse( cX, cY, xRadius, yRadius, Color, Alpha, Quality, Flags );
}

//----------------------------------------------------------------------------//
//----------------------------  S P R I T E S  -------------------------------//
//----------------------------------------------------------------------------//

// S T A T I C
SSprite_Draw_ _SSprite_Draw;
inline void SSprite_Draw( PTexture Tex, int X, int Y, int Width, int Height, BYTE Alpha, int Angle, int Flags )
{
  _SSprite_Draw( Tex, X, Y, Width, Height, Alpha, Angle, Flags );
}

// A N I M A T E D
ASprite_Draw_ _ASprite_Draw;
extern inline void ASprite_Draw( PTexture Tex, int X, int Y, int Width, int Height, int FrameNow, BYTE Alpha, int Angle, int Flags )
{
  _ASprite_Draw( Tex, X, Y, Width, Height, FrameNow, Alpha, Angle, Flags );
}

// C U T
CSprite_Draw_ _CSprite_Draw;
inline void CSprite_Draw( PTexture Tex, int X, int Y, int Width, int Height, oePRect CutRect, BYTE Alpha, int Angle, int Flags )
{
  _CSprite_Draw( Tex, X, Y, Width, Height, CutRect, Alpha, Angle, Flags );
}

//----------------------------------------------------------------------------//
//------------------------------  T I L E S  ---------------------------------//
//----------------------------------------------------------------------------//

// S T A T I C
STile_Draw_ _STile_Draw;
inline void STile_Draw( PTexture Tex, int X, int Y, int Width, int Height, int TilesX, int TilesY, BYTE Alpha, int Flags )
{
  _STile_Draw( Tex, X, Y, Width, Height, TilesX, TilesY, Alpha, Flags );
}

// A N I M A T E D
ATile_Draw_ _ATile_Draw;
inline void ATile_Draw( PTexture Tex, int X, int Y, int Width, int Height, int TilesX, int TilesY, int FrameNow, BYTE Alpha, int Flags )
{
  _ATile_Draw( Tex, X, Y, Width, Height, TilesX, TilesY, FrameNow, Alpha, Flags );
}

//----------------------------------------------------------------------------//
//---------------------------  D R A W  L I S T  -----------------------------//
//----------------------------------------------------------------------------//
DrawList_Begin_ _DrawList_Begin;
inline DWORD DrawList_Begin(void)
{
	return _DrawList_Begin();
}

DrawList_End_ _DrawList_End;
inline void DrawList_End(void)
{
	_DrawList_End();
}

DrawList_Free_ _DrawList_Free;
inline void DrawList_Free( DWORD List )
{
	_DrawList_Free( List );
}

DrawList_Draw_ _DrawList_Draw;
inline void DrawList_Draw( DWORD List )
{
	_DrawList_Draw( List );
}

//----------------------------------------------------------------------------//
//-----------------------------  S C I S S O R  ------------------------------//
//----------------------------------------------------------------------------//

Scissor_Begin_ _Scissor_Begin;
inline void Scissor_Begin( int X, int Y, int Width, int Height )
{
  _Scissor_Begin( X, Y, Width, Height );
}

Scissor_End_ _Scissor_End;
inline void Scissor_End(void)
{
  _Scissor_End();
}

//----------------------------------------------------------------------------//
//------------------------------  S O U N D  ---------------------------------//
//----------------------------------------------------------------------------//

Snd_Init_ _Snd_Init;
inline bool Snd_Init(void)
{
  return _Snd_Init();
}

Snd_Enable_ _Snd_Enable;
inline void Snd_Enable(void)
{
_Snd_Enable();
}

Snd_Disable_ _Snd_Disable;
inline void Snd_Disable(void)
{
_Snd_Disable();
}

Snd_LoadFromFile_ _Snd_LoadFromFile;
inline PSound Snd_LoadFromFile( char* FileName, int BufferCount )
{
  return _Snd_LoadFromFile( FileName, BufferCount );
}

Snd_LoadFromMemory_ _Snd_LoadFromMemory;
inline PSound Snd_LoadFromMemory( PMemory Memory, int BufferCount )
{
  return _Snd_LoadFromMemory( Memory, BufferCount );
}


Snd_Free_ _Snd_Free;
inline bool Snd_Free( PSound Sound )
{
  return _Snd_Free( Sound );
}

Snd_SetBuffersCount_ _Snd_SetBuffersCount;
inline void Snd_SetBuffersCount( PSound Sound, int Count )
{
  _Snd_SetBuffersCount( Sound, Count );
}

Snd_Play_ _Snd_Play;
inline int Snd_Play( PSound Sound, int Pan, int Volume, int Frequency, bool Loop )
{
  return _Snd_Play( Sound, Pan, Volume, Frequency, Loop );
}


Snd_PlayID_ _Snd_PlayID;
inline void Snd_PlayID( PSound Sound, int ID, int Pan, int Volume, int Frequency, bool Loop )
{
  _Snd_PlayID( Sound, ID, Pan, Volume, Frequency, Loop );
}

Snd_Stop_ _Snd_Stop;
inline void Snd_Stop( PSound Sound )
{
  _Snd_Stop( Sound );
}

Snd_StopID_ _Snd_StopID;
inline void Snd_StopID( PSound Sound, int ID )
{
  _Snd_StopID( Sound, ID );
}

Snd_StopAll_ _Snd_StopAll;
inline void Snd_StopAll(void)
{
  _Snd_StopAll();
}

Snd_ChangeParam_ _Snd_ChangeParam;
inline void Snd_ChangeParam( PSound Sound, int ID, int Pan, int Volume, int Frequency )
{
  _Snd_ChangeParam( Sound, ID, Pan, Volume, Frequency );
}

//----------------------------------------------------------------------------//
//------------------------------  M E D I A  ---------------------------------//
//----------------------------------------------------------------------------//

Media_Play_ _Media_Play;
inline void Media_Play( char* FileName, bool Loop )
{
  _Media_Play( FileName, Loop );
}

Media_Replay_ _Media_Replay;
inline void Media_Replay(void)
{
  _Media_Replay();
}

Media_Pause_ _Media_Pause;
inline void Media_Pause(void)
{
  _Media_Pause();
}

Media_Resume_ _Media_Resume;
inline void Media_Resume(void)
{
  _Media_Resume();
}

Media_Stop_ _Media_Stop;
inline void Media_Stop(void)
{
  _Media_Stop();
}

Media_SetVolume_ _Media_SetVolume;
inline void Media_SetVolume( int Volume )
{
  _Media_SetVolume( Volume );
}

Media_GetLength_ _Media_GetLength;
inline double Media_GetLength(void)
{
  return _Media_GetLength();
}

Media_SetPosition_ _Media_SetPosition;
inline void Media_SetPosition( double Position )
{
  _Media_SetPosition( Position );
}

Media_GetPosition_ _Media_GetPosition;
inline double Media_GetPosition(void)
{
  return _Media_GetPosition();
}

Media_SetWindowRect_ _Media_SetWindowRect;
inline void Media_SetWindowRect( int X, int Y, int Width, int Height )
{
  _Media_SetWindowRect( X, Y, Width, Height );
}

//----------------------------------------------------------------------------//
//---------------------------  C O L L I S I O N  ----------------------------//
//----------------------------------------------------------------------------//

// P O I N T ' s
Col_PointInAABB_ _Col_PointInAABB;
inline bool Col_PointInAABB( int X, int Y, PAABB2D AABB )
{
  return _Col_PointInAABB( X, Y, AABB );
}

Col_PointInCircle_ _Col_PointInCircle;
inline bool Col_PointInCircle( int X, int Y, PCircle2D Circ )
{
  return _Col_PointInCircle( X, Y, Circ );
}

Col_PointInPolyLine_ _Col_PointInPolyLine;
inline bool Col_PointInPolyLine( int X, int Y, PPolyLine2D PL )
{
  return _Col_PointInPolyLine( X, Y, PL );
}

// L I N E ' s
Col_Line_ _Col_Line;
inline bool Col_Line( PLine2D A, PLine2D B )
{
  return _Col_Line( A, B );
}

Col_LineVsAABB_ _Col_LineVsAABB;
inline bool Col_LineVsAABB( PLine2D A, PAABB2D AABB )
{
  return _Col_LineVsAABB( A, AABB );
}

Col_LineVsCircle_ _Col_LineVsCircle;
inline bool Col_LineVsCircle( PLine2D L, PCircle2D Circ )
{
  return _Col_LineVsCircle( L, Circ );
}

Col_LineVsCircleXY_ _Col_LineVsCircleXY;
inline bool Col_LineVsCircleXY( PLine2D L, PCircle2D Circ, int Precision )
{
  return _Col_LineVsCircleXY( L, Circ, Precision );
}

Col_LineVsPolyLine_ _Col_LineVsPolyLine;
inline bool Col_LineVsPolyLine( PLine2D A, PPolyLine2D B )
{
  return _Col_LineVsPolyLine( A, B );
}

// P O L Y L I N E ' s
Col_PolyLine_ _Col_PolyLine;
inline bool Col_PolyLine( PPolyLine2D A, PPolyLine2D B )
{
  return _Col_PolyLine( A, B );
}

Col_PolyLineVsAABB_ _Col_PolyLineVsAABB;
inline bool Col_PolyLineVsAABB( PPolyLine2D A, PAABB2D AABB )
{
  return _Col_PolyLineVsAABB( A, AABB );
}

Col_PolyLineVsCircle_ _Col_PolyLineVsCircle;
inline bool Col_PolyLineVsCircle( PPolyLine2D A, PCircle2D Circ )
{
  return _Col_PolyLineVsCircle( A, Circ );
}

// A A B B ' s
Col_AABB_ _Col_AABB;
inline bool Col_AABB( PAABB2D AABB1, PAABB2D AABB2 )
{
  return _Col_AABB( AABB1, AABB2 );
}

Col_AABBInAABB_ _Col_AABBInAABB;
inline bool Col_AABBInAABB( PAABB2D AABB1, PAABB2D AABB2 )
{
  return _Col_AABBInAABB( AABB1, AABB2 );
}

Col_AABBInCircle_ _Col_AABBInCircle;
inline bool Col_AABBInCircle( PAABB2D AABB1, PCircle2D Circ )
{
  return _Col_AABBInCircle( AABB1, Circ );
}

Col_AABBVsCircle_ _Col_AABBVsCircle;
inline bool Col_AABBVsCircle( PAABB2D AABB1, PCircle2D Circ )
{
  return _Col_AABBVsCircle( AABB1, Circ );
}

// C I R C L E ' s
Col_Circle_ _Col_Circle;
inline bool Col_Circle( PCircle2D Circ1, PCircle2D Circ2 )
{
  return _Col_Circle( Circ1, Circ2 );
}

Col_CircleInCircle_ _Col_CircleInCircle;
inline bool Col_CircleInCircle( PCircle2D Circ1, PCircle2D Circ2 )
{
  return _Col_CircleInCircle( Circ1, Circ2 );
}

Col_CircleInAABB_ _Col_CircleInAABB;
inline bool Col_CircleInAABB( PCircle2D Circ1, PAABB2D AABB )
{
  return _Col_CircleInAABB( Circ1, AABB );
}

// E X T E N D E D  F U N C T I O N S
// G E T ' s
ColEx_LastX_ _ColEx_LastX;
inline float ColEx_LastX(void)
{
  return _ColEx_LastX();
}

ColEx_LastY_ _ColEx_LastY;
inline float ColEx_LastY(void)
{
  return _ColEx_LastY();
}

ColEx_LastLineA_ _ColEx_LastLineA;
inline int ColEx_LastLineA(void)
{
  return _ColEx_LastLineA();
}

ColEx_LastLineB_ _ColEx_LastLineB;
inline int ColEx_LastLineB(void)
{
  return _ColEx_LastLineB();
}

// T R A N S F O R M A T I O N ' s
ColEx_PolyRotate_ _ColEx_PolyRotate;
inline void ColEx_PolyRotate( PPolyLine2D A, PPolyLine2D B, int Angle )
{
  _ColEx_PolyRotate( A, B, Angle );
}

ColEx_PolyScale_ _ColEx_PolyScale;
inline void ColEx_PolyScale( PPolyLine2D A, float ScaleX, float ScaleY )
{
  _ColEx_PolyScale( A, ScaleX, ScaleY );
}

ColEx_PolyMove_ _ColEx_PolyMove;
inline void ColEx_PolyMove( PPolyLine2D A, PPolyLine2D B, int X, int Y )
{
  _ColEx_PolyMove( A, B, X, Y );
}

ColEx_PolyCenter_ _ColEx_PolyCenter;
inline void ColEx_PolyCenter( PPolyLine2D A )
{
  _ColEx_PolyCenter( A );
}

ColEx_PolyRect_ _ColEx_PolyRect;
inline void ColEx_PolyRect( PPolyLine2D A, PAABB2D Rect )
{
  _ColEx_PolyRect( A, Rect );
}

// L I N E ' s
ColEx_CalcLineCross_ _ColEx_CalcLineCross;
inline void ColEx_CalcLineCross( PLine2D A, PLine2D B )
{
  _ColEx_CalcLineCross( A, B );
}

//----------------------------------------------------------------------------//
//----------------------------  F A S T  M A T H  ----------------------------//
//----------------------------------------------------------------------------//

M_Cos_ _M_Cos;
inline float M_Cos( int Angle )
{
  return _M_Cos( Angle );
}

M_Sin_ _M_Sin;
inline float M_Sin( int Angle )
{
  return _M_Sin( Angle );
}

M_CosF_ _M_CosF;
inline float M_CosF( int Angle )
{
  return _M_CosF( Angle );
}

M_SinF_ _M_SinF;
inline float M_SinF( int Angle )
{
  return _M_SinF( Angle );
}

M_Round_ _M_Round;
inline int M_Round( float Value )
{
  return _M_Round( Value );
}

M_Trunc_ _M_Trunc;
inline int M_Trunc( float Value )
{
  return _M_Trunc( Value );
}

M_Distance_ _M_Distance;
inline float M_Distance( float X1, float Y1, float X2, float Y2 )
{
  return _M_Distance( X1, Y1, X2, Y2 );
}

M_FindAngle_ _M_FindAngle;
inline float M_Distance( int X1, int Y1, int X2, int Y2 )
{
  return _M_FindAngle( X1, Y1, X2, Y2 );
}

//----------------------------------------------------------------------------//
//--------------------------------  U T I L S  -------------------------------//
//----------------------------------------------------------------------------//

// H A R D W A R E
U_GetCPUName_ _U_GetCPUName;
inline char* U_GetCPUNamer(void)
{
  return _U_GetCPUName();
}

U_GetTotalRAM_ _U_GetTotalRAM;
inline int U_GetTotalRAM(void)
{
  return _U_GetTotalRAM();
}

U_Is3DAccelerator_ _U_Is3DAccelerator;
inline bool U_Is3DAccelerator(void)
{
  return _U_Is3DAccelerator();
}

U_GetMaxTexSize_ _U_GetMaxTexSize;
inline int U_GetMaxTexSize(void)
{
  return _U_GetMaxTexSize();
}

U_GetMaxAnisotropy_ _U_GetMaxAnisotropy;
inline int U_GetMaxAnisotropy(void)
{
  return _U_GetMaxAnisotropy();
}

// A D D I T I O N A L  F O R  E N G I N E
U_SnapShot_ _U_SnapShot;
inline void U_SnapShot( char* Path, char* FileName )
{
  _U_SnapShot( Path, FileName );
}

// C O N V E R T
U_IntToStr_ _U_IntToStr;
inline char* U_IntToStr( int Num )
{
  return _U_IntToStr( Num );
}

U_StrToInt_ _U_StrToInt;
inline int U_StrToInt( char* Str )
{
  return _U_StrToInt( Str );
}

U_FloatToStr_ _U_FloatToStr;
inline char* U_FloatToStr( float Num )
{
  return _U_FloatToStr( Num );
}

U_GetTime_ _U_GetTime;
inline DWORD U_GetTime( void )
{
  return _U_GetTime();
}

//----------------------------------------------------------------------------//
//------------------------------  P L U G I N  -------------------------------//
//----------------------------------------------------------------------------//

P_GetParams_ _P_GetParams;
inline void* P_GetParams( int What )
{
  return _P_GetParams( What );
}

Tex_PostProcess_ _Tex_PostProcess;
inline PTexture Tex_PostProcess( void* &pData, TTexture &Info, int TransparentColor )
{
  return _Tex_PostProcess( pData, Info, TransparentColor );
}

void LoadOMEGA( void )
{
  _OE_Init                    = (OE_Init_)GetProcAddress(dll, "OE_Init");
  _OE_Init2                   = (OE_Init2_)GetProcAddress(dll, "OE_Init2");
  _OE_Quit                    = (OE_Quit_)GetProcAddress(dll, "OE_Quit");
  _OE_RegProcedure            = (OE_RegProcedure_)GetProcAddress(dll, "OE_RegProcedure");
  _OE_UnRegProcedure          = (OE_UnRegProcedure_)GetProcAddress(dll, "OE_UnRegPRocedure");
  _OE_UnRegProcedureT         = (OE_UnRegProcedureT_)GetProcAddress(dll, "OE_UnRegProcedureT");
  _Timer_Create               = (Timer_Create_)GetProcAddress(dll, "Timer_Create");
  _Timer_Free                 = (Timer_Free_)GetProcAddress(dll, "Timer_Free");
  _OE_Enable                  = (OE_Enable_)GetProcAddress(dll, "OE_Enable");
  _OE_Disable                 = (OE_Disable_)GetProcAddress(dll, "OE_Disable");
  _OE_SetWndOnTop             = (OE_SetWndOnTop_)GetProcAddress(dll, "OE_SetWndOnTop");
  _OE_SetWndPosition          = (OE_SetWndPosition_)GetProcAddress(dll, "OE_SetWndPosition");
  _OE_SetWndName              = (OE_SetWndName_)GetProcAddress(dll, "OE_SetWndName");
  _OE_ShowCursor              = (OE_ShowCursor_)GetProcAddress(dll, "OE_ShowCursor");
  _OE_ResizeWindow            = (OE_ResizeWindow_)GetProcAddress(dll, "OE_ResizeWindow");
  _OE_SetScreenOptions        = (OE_SetScreenOptions_)GetProcAddress(dll, "OE_SetScreenOptions");
  _OE_ChangeScreenOptions     = (OE_ChangeScreenOptions_)GetProcAddress(dll, "OE_ChangeScreenOptions");
  _OE_SetResolutionDependence = (OE_SetResolutionDependence_)GetProcAddress(dll, "OE_SetResolutionDependence");
  _OE_SetVSync                = (OE_SetVSync_)GetProcAddress(dll, "OE_SetVSync");
  _OE_GetOptions              = (OE_GetOptions_)GetProcAddress(dll, "OE_GetOptions");
  _OE_SetAdvancedOptions      = (OE_SetAdvancedOptions_)GetProcAddress(dll, "OE_SetAdvancedOptions");
  _OE_GetFPS                  = (OE_GetFPS_)GetProcAddress(dll, "OE_GetFPS");
  _LOG_SetOptions             = (LOG_SetOptions_)GetProcAddress(dll, "LOG_SetOptions");
  _LOG_Init                   = (LOG_Init_)GetProcAddress(dll, "LOG_Init");
  _LOG_AddMessage             = (LOG_AddMessage_)GetProcAddress(dll, "LOG_AddMessage");
  _LOG_AddLine                = (LOG_AddLine_)GetProcAddress(dll, "LOG_AddLine");
  _Key_LoadLayout             = (Key_LoadLayout_)GetProcAddress(dll, "Key_LoadLayout");
  _KeyEx_Down                 = (KeyEx_Down_)GetProcAddress(dll, "KeyEx_Down");
  _Key_Down                   = (Key_Down_)GetProcAddress(dll, "Key_Down");
  _Key_Press                  = (Key_Press_)GetProcAddress(dll, "Key_Press");
  _Key_LastDown               = (Key_LastDown_)GetProcAddress(dll, "Key_LastDown");
  _Key_LastPress              = (Key_LastPress_)GetProcAddress(dll, "Key_LastPress");
  _Key_BeginReadText          = (Key_BeginReadText_)GetProcAddress(dll, "Key_BeginReadText");
  _Key_EndReadText            = (Key_EndReadText_)GetProcAddress(dll, "Key_EndReadText");
  _Key_MaxReadText            = (Key_MaxReadText_)GetProcAddress(dll, "Key_MaxReadText");
  _MouseEx_X                  = (Mouse_X_)GetProcAddress(dll, "MouseEx_X");
  _MouseEx_Y                  = (Mouse_Y_)GetProcAddress(dll, "MouseEx_Y");
  _MouseEx_Down               = (Mouse_Down_)GetProcAddress(dll, "MouseEx_Down");
  _Mouse_X                    = (Mouse_X_)GetProcAddress(dll, "Mouse_X");
  _Mouse_Y                    = (Mouse_Y_)GetProcAddress(dll, "Mouse_Y");
  _Mouse_Move                 = (Mouse_Move_)GetProcAddress(dll, "Mouse_Move");
  _Mouse_Lock                 = (Mouse_Lock_)GetProcAddress(dll, "Mouse_Lock");
  _Mouse_DeltaX               = (Mouse_DeltaX_)GetProcAddress(dll, "Mouse_DeltaX");
  _Mouse_DeltaY               = (Mouse_DeltaY_)GetProcAddress(dll, "Mouse_DeltaY");
  _Mouse_Down                 = (Mouse_Down_)GetProcAddress(dll, "Mouse_Down");
  _Mouse_Press                = (Mouse_Press_)GetProcAddress(dll, "Mouse_Press");
  _Mouse_Click                = (Mouse_Click_)GetProcAddress(dll, "Mouse_Click");
  _Mouse_DblClick             = (Mouse_DblClick_)GetProcAddress(dll, "Mouse_DblClick");
  _Mouse_WheelUp              = (Mouse_WheelUp_)GetProcAddress(dll, "Mouse_WheelUp");
  _Mouse_WheelDown            = (Mouse_WheelDown_)GetProcAddress(dll, "Mouse_WheelDown");
  _Joy_Down                   = (Joy_Down_)GetProcAddress(dll, "Joy_Down");
  _Joy_Press                  = (Joy_Press_)GetProcAddress(dll, "Joy_Press");
  _Joy_AxePos                 = (Joy_AxePos_)GetProcAddress(dll, "Joy_AxePos");
  _Tex_SetAnisotropyLevel     = (Tex_SetAnisotropyLevel_)GetProcAddress(dll, "Tex_SetAnisotropyLevel");
  _Tex_CreateZero             = (Tex_CreateZero_)GetProcAddress(dll, "Tex_CreateZero");
  _Tex_LoadFromFile           = (Tex_LoadFromFile_)GetProcAddress(dll, "Tex_LoadFromFile");
  _Tex_LoadFromMemory         = (Tex_LoadFromMemory_)GetProcAddress(dll, "Tex_LoadFromMemory");
  _Tex_Free                   = (Tex_Free_)GetProcAddress(dll, "Tex_Free");
  _Tex_LoadMaskFromFile       = (Tex_LoadMaskFromFile_)GetProcAddress(dll, "Tex_LoadMaskFromFile");
  _Tex_LoadMaskFromMemory     = (Tex_LoadMaskFromMemory_)GetProcAddress(dll, "Tex_LoadMaskFromMemory");
  _Tex_FreeMask               = (Tex_FreeMask_)GetProcAddress(dll, "Tex_FreeMask");
  _Tex_SetFramesSize          = (Tex_SetFramesSize_)GetProcAddress(dll, "Tex_SetFramesSize");
  _Tex_BeginRenderIn          = (Tex_BeginRenderIn_)GetProcAddress(dll, "Tex_BeginRenderIn");
  _Tex_EndRenderIn            = (Tex_EndRenderIn_)GetProcAddress(dll, "Tex_EndRenderIn");
  _Cam2D_Create               = (Cam2D_Create_)GetProcAddress(dll, "Cam2D_Create");
  _Cam2D_Free                 = (Cam2D_Free_)GetProcAddress(dll, "Cam2D_Free");
  _Cam2D_Set                  = (Cam2D_Set_)GetProcAddress(dll, "Cam2D_Set");
  _FX_SetColorMix             = (FX_SetColorMix_)GetProcAddress(dll, "FX_SetColorMix");
  _FX_SetBlendMode            = (FX_SetBlendMode_)GetProcAddress(dll, "FX_SetBlendMode");
  _FX_SetScale                = (FX_SetScale_)GetProcAddress(dll, "FX_SetScale");
  _FX_SetVertexes             = (FX_SetVertexes_)GetProcAddress(dll, "FX_SetVertexes");
  _FX_SetVCA                  = (FX_SetVCA_)GetProcAddress(dll, "FX_SetVCA");
  _FX_Blur_SetTex             = (FX_Blur_SetTex_)GetProcAddress(dll, "FX_Blur_SetTex");
  _FX_Blur_SetParams          = (FX_Blur_SetParams_)GetProcAddress(dll, "FX_Blur_SetParams");
  _FX_Blur_Calc               = (FX_Blur_Calc_)GetProcAddress(dll, "FX_Blur_Calc");
  _FX_Blur_Draw               = (FX_Blur_Draw_)GetProcAddress(dll, "FX_Blur_Draw");
  _FX_RadBlur_SetTex          = (FX_RadBlur_SetTex_)GetProcAddress(dll, "FX_RadBlur_SetTex");
  _FX_RadBlur_SetParams       = (FX_RadBlur_SetParams_)GetProcAddress(dll, "FX_RadBlur_SetParams");
  _FX_RadBlur_Calc            = (FX_RadBlur_Calc_)GetProcAddress(dll, "FX_RadBlur_Calc");
  _FX_RadBlur_Draw            = (FX_RadBlur_Draw_)GetProcAddress(dll, "FX_RadBlur_Draw");
  _Text_LoadFontFromFile      = (Text_LoadFontFromFile_)GetProcAddress(dll, "Text_LoadFontFromFile");
  _Text_LoadFontFromMemory    = (Text_LoadFontFromMemory_)GetProcAddress(dll, "Text_LoadFontFromMemory");
  _Text_FreeFont              = (Text_FreeFont_)GetProcAddress(dll, "Text_FreeFont");
  _Text_Draw                  = (Text_Draw_)GetProcAddress(dll, "Text_Draw");
  _Text_GetWidth              = (Text_GetWidth_)GetProcAddress(dll, "Text_GetWidth");
  _Console_Active             = (Console_Active_)GetProcAddress(dll, "Console_Active");
  _Console_SetOptions         = (Console_SetOptions_)GetProcAddress(dll, "Console_SetOptions");
  _Console_ToLog              = (Console_ToLog_)GetProcAddress(dll, "Console_ToLog");
  _Console_Draw               = (Console_Draw_)GetProcAddress(dll, "Console_Draw");
  _Console_RegCommand         = (Console_RegCommand_)GetProcAddress(dll, "Console_RegCommand");
  _Console_RegVariable        = (Console_RegVariable_)GetProcAddress(dll, "Console_RegVariable");
  _Console_RegProcedure       = (Console_RegProcedure_)GetProcAddress(dll, "Console_RegProcedure");
  _Console_AddString          = (Console_AddString_)GetProcAddress(dll, "Console_AddString");
  _Pr2D_PixelSize             = (Pr2D_PixelSize_)GetProcAddress(dll, "Pr2D_PixelSize");
  _Pr2D_LineWidth             = (Pr2D_LineWidth_)GetProcAddress(dll, "Pr2D_LineWidth");
  _Pr2D_Pixel                 = (Pr2D_Pixel_)GetProcAddress(dll, "Pr2D_Pixel");
  _Pr2D_Line                  = (Pr2D_Line_)GetProcAddress(dll, "Pr2D_Line");
  _Pr2D_TLine                 = (Pr2D_TLine_)GetProcAddress(dll, "Pr2D_TLine");
  _Pr2D_Rect                  = (Pr2D_Rect_)GetProcAddress(dll, "Pr2D_Rect");
  _Pr2D_TRect                 = (Pr2D_TRect_)GetProcAddress(dll, "Pr2D_TRect");
  _Pr2D_Triangle              = (Pr2D_Triangle_)GetProcAddress(dll, "Pr2D_Triangle");
  _Pr2D_TTriangle             = (Pr2D_TTriangle_)GetProcAddress(dll, "Pr2D_TTriangle");
  _Pr2D_Circle                = (Pr2D_Circle_)GetProcAddress(dll, "Pr2D_Circle");
  _Pr2D_TCircle               = (Pr2D_TCircle_)GetProcAddress(dll, "Pr2D_TCircle");
  _Pr2D_Ellipse               = (Pr2D_Ellipse_)GetProcAddress(dll, "Pr2D_Ellipse");
  _SSprite_Draw               = (SSprite_Draw_)GetProcAddress(dll, "SSprite_Draw");
  _ASprite_Draw               = (ASprite_Draw_)GetProcAddress(dll, "ASprite_Draw");
  _CSprite_Draw               = (CSprite_Draw_)GetProcAddress(dll, "CSprite_Draw");
  _STile_Draw                 = (STile_Draw_)GetProcAddress(dll, "STile_Draw");
  _ATile_Draw                 = (ATile_Draw_)GetProcAddress(dll, "ATile_Draw");
  _DrawList_Begin             = (DrawList_Begin_)GetProcAddress(dll, "DrawList_Begin");
  _DrawList_End               = (DrawList_End_)GetProcAddress(dll, "DrawList_End");
  _DrawList_Free              = (DrawList_Free_)GetProcAddress(dll, "DrawList_Free");
  _DrawList_Draw              = (DrawList_Draw_)GetProcAddress(dll, "DrawList_Draw");
  _Scissor_Begin              = (Scissor_Begin_)GetProcAddress(dll, "Scissor_Begin");
  _Scissor_End                = (Scissor_End_)GetProcAddress(dll, "Scissor_End");
  _Snd_Init                   = (Snd_Init_)GetProcAddress(dll, "Snd_Init");
  _Snd_Enable                 = (Snd_Enable_)GetProcAddress(dll, "Snd_Enable");
  _Snd_Disable                = (Snd_Disable_)GetProcAddress(dll, "Snd_Disable");
  _Snd_LoadFromFile           = (Snd_LoadFromFile_)GetProcAddress(dll, "Snd_LoadFromFile");
  _Snd_LoadFromMemory         = (Snd_LoadFromMemory_)GetProcAddress(dll, "Snd_LoadFromMemory");
  _Snd_Free                   = (Snd_Free_)GetProcAddress(dll, "Snd_Free");
  _Snd_SetBuffersCount        = (Snd_SetBuffersCount_)GetProcAddress(dll, "Snd_SetBuffersCount");
  _Snd_Play                   = (Snd_Play_)GetProcAddress(dll, "Snd_Play");
  _Snd_PlayID                 = (Snd_PlayID_)GetProcAddress(dll, "Snd_PlayID");
  _Snd_Stop                   = (Snd_Stop_)GetProcAddress(dll, "Snd_Stop");
  _Snd_StopID                 = (Snd_StopID_)GetProcAddress(dll, "Snd_StopID");
  _Snd_StopAll                = (Snd_StopAll_)GetProcAddress(dll, "Snd_StopAll");
  _Snd_ChangeParam            = (Snd_ChangeParam_)GetProcAddress(dll, "Snd_ChangeParam");
  _Media_Play                 = (Media_Play_)GetProcAddress(dll, "Media_Play");
  _Media_Replay               = (Media_Replay_)GetProcAddress(dll, "Media_Replay");
  _Media_Pause                = (Media_Pause_)GetProcAddress(dll, "Media_Pause");
  _Media_Resume               = (Media_Resume_)GetProcAddress(dll, "Media_Resume");
  _Media_Stop                 = (Media_Stop_)GetProcAddress(dll, "Media_Stop");
  _Media_SetVolume            = (Media_SetVolume_)GetProcAddress(dll, "Media_SetVolume");
  _Media_GetLength            = (Media_GetLength_)GetProcAddress(dll, "Media_GetLength");
  _Media_SetPosition          = (Media_SetPosition_)GetProcAddress(dll, "Media_SetPosition");
  _Media_GetPosition          = (Media_GetPosition_)GetProcAddress(dll, "Media_GetPosition");
  _Media_SetWindowRect        = (Media_SetWindowRect_)GetProcAddress(dll, "Media_SetWindowRect");
  _Col_PointInAABB            = (Col_PointInAABB_)GetProcAddress(dll, "Col_PointInAABB");
  _Col_PointInCircle          = (Col_PointInCircle_)GetProcAddress(dll, "Col_PointInCircle");
  _Col_PointInPolyLine        = (Col_PointInPolyLine_)GetProcAddress(dll, "Col_PointInPolyLine");
  _Col_Line                   = (Col_Line_)GetProcAddress(dll, "Col_Line");
  _Col_LineVsAABB             = (Col_LineVsAABB_)GetProcAddress(dll, "Col_LineVsAABB");
  _Col_LineVsCircle           = (Col_LineVsCircle_)GetProcAddress(dll, "Col_LineVsCircle");
  _Col_LineVsCircleXY         = (Col_LineVsCircleXY_)GetProcAddress(dll, "Col_LineVsCircleXY");
  _Col_LineVsPolyLine         = (Col_LineVsPolyLine_)GetProcAddress(dll, "Col_LineVsPolyLine");
  _Col_PolyLine               = (Col_PolyLine_)GetProcAddress(dll, "Col_PolyLine");
  _Col_PolyLineVsAABB         = (Col_PolyLineVsAABB_)GetProcAddress(dll, "Col_PolyLineVsAABB");
  _Col_PolyLineVsCircle       = (Col_PolyLineVsCircle_)GetProcAddress(dll, "Col_PolyLineVsCircle");
  _Col_AABB                   = (Col_AABB_)GetProcAddress(dll, "Col_AABB");
  _Col_AABBInAABB             = (Col_AABBInAABB_)GetProcAddress(dll, "Col_AABBInAABB");
  _Col_AABBInCircle           = (Col_AABBInCircle_)GetProcAddress(dll, "Col_AABBInCircle");
  _Col_AABBVsCircle           = (Col_AABBVsCircle_)GetProcAddress(dll, "Col_AABBVsCircle");
  _Col_Circle                 = (Col_Circle_)GetProcAddress(dll, "Col_Circle");
  _Col_CircleInCircle         = (Col_CircleInCircle_)GetProcAddress(dll, "Col_CircleInCircle");
  _Col_CircleInAABB           = (Col_CircleInAABB_)GetProcAddress(dll, "Col_CircleInAABB");
  _ColEx_LastX                = (ColEx_LastX_)GetProcAddress(dll, "ColEx_LastX");
  _ColEx_LastY                = (ColEx_LastY_)GetProcAddress(dll, "ColEx_LastY");
  _ColEx_PolyRotate           = (ColEx_PolyRotate_)GetProcAddress(dll, "ColEx_PolyRotate");
  _ColEx_PolyScale            = (ColEx_PolyScale_)GetProcAddress(dll, "ColEx_PolyScale");
  _ColEx_PolyMove             = (ColEx_PolyMove_)GetProcAddress(dll, "ColEx_PolyMove");
  _ColEx_PolyCenter           = (ColEx_PolyCenter_)GetProcAddress(dll, "ColEx_PolyCenter");
  _ColEx_PolyRect             = (ColEx_PolyRect_)GetProcAddress(dll, "ColEx_PolyRect");
  _ColEx_CalcLineCross        = (ColEx_CalcLineCross_)GetProcAddress(dll, "ColEx_CalcLineCross");
  _M_Cos                      = (M_Cos_)GetProcAddress(dll, "M_Cos");
  _M_Sin                      = (M_Sin_)GetProcAddress(dll, "M_Sin");
  _M_CosF                     = (M_CosF_)GetProcAddress(dll, "M_CosF");
  _M_SinF                     = (M_SinF_)GetProcAddress(dll, "M_SinF");
  _M_Round                    = (M_Round_)GetProcAddress(dll, "M_Round");
  _M_Trunc                    = (M_Trunc_)GetProcAddress(dll, "M_Trunc");
  _M_Distance                 = (M_Distance_)GetProcAddress(dll, "M_Distance");
  _M_FindAngle                = (M_FindAngle_)GetProcAddress(dll, "M_FindAngle");
  _U_GetCPUName               = (U_GetCPUName_)GetProcAddress(dll, "U_GetCPUName");
  _U_GetTotalRAM              = (U_GetTotalRAM_)GetProcAddress(dll, "U_GetTotalRAM");
  _U_Is3DAccelerator          = (U_Is3DAccelerator_)GetProcAddress(dll, "U_Is3DAccelerator");
  _U_GetMaxTexSize            = (U_GetMaxTexSize_)GetProcAddress(dll, "U_GetMaxTexSize");
  _U_GetMaxAnisotropy         = (U_GetMaxAnisotropy_)GetProcAddress(dll, "U_GetMaxAnisotropy");
  _U_SnapShot                 = (U_SnapShot_)GetProcAddress(dll, "U_SnapShot");
  _U_IntToStr                 = (U_IntToStr_)GetProcAddress(dll, "U_IntToStr");
  _U_StrToInt                 = (U_StrToInt_)GetProcAddress(dll, "U_StrToInt");
  _U_FloatToStr               = (U_FloatToStr_)GetProcAddress(dll, "U_FloatToStr");
  _U_GetTime                  = (U_GetTime_)GetProcAddress(dll, "U_GetTime");
  _P_GetParams                = (P_GetParams_)GetProcAddress(dll, "P_GetParams");
  _Tex_PostProcess            = (Tex_PostProcess_)GetProcAddress(dll, "Tex_PostProcess");
};
