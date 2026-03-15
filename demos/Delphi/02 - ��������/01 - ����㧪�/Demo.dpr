////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                           O M E G A  E N G I N E                           //
//                                  D E M O                                   //
//                                                                            //
//    Простой пример демонстрирующий загрузку текстур с "нормальным "размером //
//  и размером не кратным 2.                                                  //
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
  TexBad  : PTexture;
  TexBadN : PTexture;

procedure Load;
Begin
End;

procedure Init;
Begin
// Загружаем текстуру
Texture := Tex_LoadFromFile( '..\..\..\Media\Logo.gif', // Где файл текстуры
                            $FFFFFF,          // Цвет прозрачности - белый
                            TEX_DEFAULT_2D ); // Загрузка со стандартными
                                              // параметрами для OpenGL

// Загружаем текстуру которую OpenGL не любит=)
TexBadN := Tex_LoadFromFile( '..\..\..\Media\BadTexture.jpg',
                             -1,              // Без прозрачности
                             TEX_DEFAULT_2D );// Стандартные опции TEX_DEFAULT_2D
                                              // настроены таким образом чтоб
                                              // текстуры с размерами не кратными двум
                                              // загружались без "мыла"

// Для наглядности загрузим тектстуру опять но со стандартными параметрами для OpenGL,
// правда с удалением "неправильных краев"
TexBad := Tex_LoadFromFile( '..\..\..\Media\BadTexture.jpg', -1,
                            TEX_MIPMAP or TEX_FILTER_LINEAR or TEX_CLAMP );
End;

procedure Draw;
Begin
//Чтоб скучно не было рисуем эти текстуры
SSprite_Draw( Texture, 800 - 128, 600 - 128, 128, 128, 255, 0, FX_DEFAULT );
SSprite_Draw( TexBad,  400 - 120, 300 - 45,  120,  90, 255, 0, FX_DEFAULT );
SSprite_Draw( TexBadN, 400,       300 - 45,  120,  90, 255, 0, FX_DEFAULT );
End;

procedure Quit;
Begin
End;

procedure Timer1;
Begin
// По нажатию Escape завершаем работу
if Key_Down( K_ESCAPE ) Then OE_Quit;
End;

begin

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

