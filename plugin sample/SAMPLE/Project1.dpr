///////////////////////////
//  VERTEX LIGHT SAMPLE  //
///////////////////////////
program Project1;

uses
  OMEGA     in '..\..\headers\Delphi\OMEGA.pas',    //Подключение OMEGA Engine
  VL_HEADER in '..\VL_Header.pas' //Подключения VERTEX LIGHT Plugin
  ;

var
  Ground : PTexture;

  LastID : Integer;

  Timer  : PTimer;

procedure MouseDraw;
Begin

Pr2d_Rect( Mouse_X - 2, Mouse_Y - 2, 4, 4, $FFFFFF, 255, PR_FILL );

End;

procedure Init;
begin

Ground := Tex_LoadFromFile( 'ground.jpg', -1, TEX_DEFAULT_2D );

//Инициализация плагина
VL_Init;

LastID := VL_AddLight( Mouse_X, Mouse_Y, 64, 200 );

End;

procedure Timer1;
Begin

if Mouse_Click( M_LBUTTON ) Then
  LastID := VL_AddLight( Mouse_X, Mouse_Y, 64, 200 );

VL_MoveLight( LastID, Mouse_X, Mouse_Y );

End;

procedure Draw;
Begin

STile_Draw( Ground, 0, 0, 256, 256, 4, 3, 255 );
VL_Draw;

End;

begin
  OE_SetScreenOptions( 800, 600, 32, 0, TRUE, FALSE );

  Timer := Timer_Create( @Timer1, 10, 0 );

  OE_RegProcedure( SYS_DRAW, @Draw );
  OE_RegProcedure( SYS_INIT, @Init );

  OE_Init;
end.

