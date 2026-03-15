////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                           O M E G A  E N G I N E                           //
//                                  D E M O                                   //
//                                                                            //
//    Здесь показывается какие флаги можно использовать чтоб наложить простые //
//  эффекты(отражение, масштабирование, наложение цвета и т.д.) и какие       //
//  "подготовительные" функции надо вызывать.                                 //
//                                                                            //
//  (C)2006 Andru 'aka' KEMKA ANDREY.                                         //
//  web  : HTTP://isada.mirgames.ru                                           //
//  eMail: Andru_@list.ru                                                     //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////
program Demo;

uses
  OMEGA in '..\..\..\headers\Delphi\OMEGA.pas'; // подключаем хедер движка

var
  MyTimer : PTimer;
  
  // Переменные, которые будут хранить идентификаторы текстур
  Texture : PTexture;
  Sprite  : PTexture;

  N       : Integer; // Текущий кадр спрайта

procedure Load;
Begin
End;

procedure Init;
Begin
// Загружаем текстуру Logo
Texture := Tex_LoadFromFile( '..\..\Media\Logo.gif', $FFFFFF, TEX_DEFAULT_2D );

// Загружаем текстуру с кадрами анимации
Sprite := Tex_LoadFromFile( '..\..\Media\Sprite.tga', -1, TEX_DEFAULT_2D );
Tex_SetFramesSize( Sprite, 100, 100 );

End;

procedure Draw;
Begin
//Рисуем Logo
SSprite_Draw( Texture, 800 - 128, 600 - 128, 128, 128, 255, 0, FX_DEFAULT );

// Теперь рисуем анимированный спрайт с отражением по оси X
ASprite_Draw( Sprite, 400 - 100, 300 - 50, 100, 100, N, 255, 0,
              FX_DEFAULT or FX_FLIPX ); // Добавляем нужный флаг через or

// Устанавливаем цвет смешивания
FX_SetColorMix( $0000FF );
ASprite_Draw( Sprite, 400 - 50, 300 - 50, 100, 100, N, 255, 0,
              FX_DEFAULT or FX_COLORMIX ); // Добавляем флаг наложения цвета через or

// Устанавливаем цвет смешивания для каждой отдельной вершины
FX_SetVCA( $FF0000, $00FF00, $0000FF, $FFFF00, 255, 255, 255, 255 );
ASprite_Draw( Sprite, 400, 300 - 50, 100, 100, N, 255, 0,
              FX_DEFAULT or FX_VCA ); // Добавляем через or

// Устанавливаем коэфициент увеличение
FX_SetScale( 2, 2 );
ASprite_Draw( Sprite, 400 - 50, 300 + 50 * 2, 100, 100, N, 255, 0,
              FX_DEFAULT or FX_SCALE ); // Добавляем через or
End;

procedure Quit;
Begin
End;

procedure Timer1;
Begin
// Инкрементируем=) текущий кадр спрайта...
INC( N );
//... и проверяем не выходит ли он за границы(хотя это делает и сам движок)
if N > 10 Then N := 1;
// По нажатию Escape завершаем работу
if Key_Down( K_ESCAPE ) Then OE_Quit;
End;

begin

// Создаем таймер
MyTimer := Timer_Create( @Timer1, 33, 0 );

// Назначаем "системные" процедуры
OE_RegProcedure( SYS_FASTINIT, @Load );
OE_RegProcedure( SYS_INIT,     @Init );
OE_RegPRocedure( SYS_DRAW,     @Draw );
OE_RegPRocedure( SYS_QUIT,     @Quit );

OE_SetScreenOptions( 800, 600, 32, 0, TRUE, FALSE );

//Запускаем движок
OE_Init;

end.

