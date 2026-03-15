////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                           O M E G A  E N G I N E                           //
//                                  D E M O                                   //
//                                                                            //
//    Пример демонстрирующий простенький эффект который можно реализовать     //
//  используя лишь один режим блендинга и рендер в текстуру                   //
//                                                                            //
//  (C)2006 Andru 'aka' KEMKA ANDREY.                                         //
//  web  : HTTP://isada.mirgames.ru                                           //
//  eMail: Andru_@list.ru                                                     //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////
program Demo;

uses
  OMEGA in '..\..\..\..\headers\Delphi\OMEGA.pas'; // подключаем хедер движка

var
  MyTimer : PTimer;
  
  // Переменные, которые будут хранить идентификаторы текстур
  Texture : PTexture;
  Effect  : PTexture;

procedure Load;
Begin
End;

procedure Init;
Begin
// Загружаем текстуру
Texture := Tex_LoadFromFile( '..\..\..\Media\Logo.gif', $FFFFFF, TEX_DEFAULT_2D );


// Создаем пустую текстуру 512x512
Effect := Tex_CreateZero( 512, 512, 0 );
// Рисуем на ней белый прямоугольник
Tex_BeginRenderIn( Effect, TRUE, TRUE );
Pr2D_Rect( 0, 0, 512, 512, $FFFFFF, 255, PR_FILL );
Tex_EndRenderIn;
End;

procedure Draw;
Begin
//Рисуем тайлы
STile_Draw( Texture, 0, 0, 128, 128, 7, 6, 255, FX_DEFAULT );

// Указываем блендинг как маску
FX_SetBlendMode( FX_BLEND_MASK );
// Рисуем нашу текстуру эффекта, где все черные области делают изображение "позади"
// невидимым... покрытым черным цветом
SSprite_Draw( Effect, 0, 0, 800, 600 );
// Возвращаем нормлаьный бленд
FX_SetBlendMode( FX_BLEND_NORMAL );
End;

procedure Quit;
Begin
End;

procedure Timer1;
  var
    i : Integer;
Begin
// Рисуем случайным образом на текстуе эффекта черные пикселы
Tex_BeginRenderIn( Effect, TRUE, TRUE );
for i := 0 to 1000 do
Pr2D_Pixel( random( 512 ), random( 512 ), 0 );
Tex_EndRenderIn;

// По нажатию Escape завершаем работу
if Key_Down( K_ESCAPE ) Then OE_Quit;
End;

begin

Randomize;

// Создаем таймер
MyTimer := Timer_Create( @Timer1, 10, 0 );

// Назначаем "системные" процедуры
OE_RegProcedure( SYS_FASTINIT, @Load );
OE_RegProcedure( SYS_INIT,     @Init );
OE_RegPRocedure( SYS_DRAW,     @Draw );
OE_RegPRocedure( SYS_QUIT,     @Quit );

OE_SetScreenOptions( 800, 600, 32, 0, TRUE, FALSE );

//Запускаем движок
OE_Init;

end.

