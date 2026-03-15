program Invaders;

uses
  OMEGA in '..\..\..\..\headers\Delphi\OMEGA.pas',
  uSpriteEngine in '..\..\..\..\units\Delphi\uSpriteEngine.pas',
  Player in 'Player.pas',
  Monster1 in 'Monster1.pas',
  Bullet in 'Bullet.pas',
  Boom in 'Boom.pas',
  GEngine in 'GEngine.pas';

var
  Process : PTimer;

  BackGround : PTexture;
  Left       : PTexture;

  Font : PFont2D;

procedure Init;
  var
    i : Integer;
Begin

LastEnemyAdd := U_GetTime;

BackGround := Tex_LoadFromFile( '..\media\BackGround.jpg', -1, TEX_DEFAULT_2D );
Left       := Tex_LoadFromFile( '..\media\Left.jpg', -1, TEX_DEFAULT_2D );
Font := Text_LoadFontFromFile( '..\..\..\media\Font.gif', '..\..\..\media\FontInfo.ofi' );

Monster1_Tex := Tex_LoadFromFile( '..\media\Monster1.gif', $FE00FE, TEX_DEFAULT_2D );
Tex_SetFramesSize( Monster1_Tex, 48, 48 );
Bullet_Tex := Tex_LoadFromFile( '..\media\Bullet.gif', 0, TEX_DEFAULT_2D );
Boom_Tex := Tex_LoadFromFile( '..\media\Boom.jpg', -1, TEX_DEFAULT_2D );
Tex_SetFramesSize( Boom_Tex, 64, 64 );

// Инициализируем движок игры
GameEngine := TGameEngine.Create;
GameEngine.InvertSort := TRUE;
i := GameEngine.AddNew;
GameEngine.PlayerID := i;
GameEngine.List[ i ] := TPlayer.Create;
GameEngine.List[ i ].ID := i;

End;

procedure Draw;
Begin

SSprite_Draw( BackGround, 100, 0, 700, 600 );
SSprite_Draw( Left, 0, 0, 100, 600 );

// Рисуем инфу
Text_Draw( Font, 25, 240, PChar( 'Life: ' + Chr( 13 ) +
           U_IntToStr( ( GameEngine.List[ GameEngine.PlayerID ] as TPlayer ).Life ) + '%' ),
           1, 1, 255, $00FF00 );
Text_Draw( Font, 20, 310, PChar( 'Score: ' + Chr( 13 ) +
           U_IntToStr( ( GameEngine.List[ GameEngine.PlayerID ] as TPlayer ).Score ) ),
           1, 1, 255, $FF0000 );

if GameEngine.GameOver Then
  Text_Draw( Font, 400 - Text_GetWidth( Font, 'Game Over' ) div 2, 290, 'Game Over', 1, 1, 255, $0000FF );
GameEngine.Draw;

End;

procedure GameTimer;
Begin
GameEngine.Process;

if Key_Down( K_ESCAPE ) Then OE_Quit;
End;

begin

Randomize;
Process := Timer_Create( @GameTimer, 16 );

//Установка параметров экрана
OE_SetScreenOptions( 800, 600, 32, 0, TRUE, TRUE );

//Регистрация процедур
OE_RegProcedure( SYS_INIT, @Init );
OE_RegProcedure( SYS_DRAW, @Draw );

// Выключаем очистку буфера цвета для оптимизации
OE_Disable( FLAG_CLEAR_COLOR_BUFFER );
// Выключаем отрезку невидных обьектов, потому как все в пределах одного экрана
OE_Disable( FLAG_CROP_UNVISIBLE_OBJ );

OE_SetAdvancedOptions( TRUE ); //Включить движковый лог
OE_Init; // Запуск движка
end.
