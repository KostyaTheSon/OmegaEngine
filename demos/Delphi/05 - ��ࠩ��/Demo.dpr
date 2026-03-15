////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                           O M E G A  E N G I N E                           //
//                                  D E M O                                   //
//                                                                            //
//    Тут описывается три новых команды, которые понадобяться при работе со   //
//  спрайтами                                                                 //
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
// Теперь очень важный момент. Указываем для текстуры размеры одного кадра
Tex_SetFramesSize( Sprite,     // Текстура которую надо разделить на кадры
                   100, 100 ); // Ширина и высота одного кадра

End;

procedure Draw;
Begin
//Рисуем уже немного знакомой командой статичный спрайт Logo
SSprite_Draw( Texture,               // Текстура коорую надо рисовать
              800 - 128, 600 - 128,  // Координаты верхнего левого угла
              128, 128,              // Ширина и высота спрайта
              255,                   // Альфа
              0,                     // Угол поворота, значения от 0..360
              FX_DEFAULT );          // Флаги

// Теперь рисуем анимированный спрайт абсолютно также за исключением одного параметра
ASprite_Draw( Sprite,
              400 - 50, 300 - 50,
              100, 100,
              N,                 // Вот этого, который отвечает за текущий кадр
              255,
              0,
              FX_DEFAULT );
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

