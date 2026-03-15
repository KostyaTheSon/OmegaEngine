////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                           O M E G A  E N G I N E                           //
//                                  D E M O                                   //
//                                                                            //
//    Простой пример демонстрирующий наложение эффектов на текстуры в момент  //
//  загрузки                                                                  //
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
  TexGray   : PTexture;
  TexInvert : PTexture;
  TexNormal : PTexture;

procedure Load;
Begin
End;

procedure Init;
Begin
// Загружаем текстуры
TexGray := Tex_LoadFromFile( '..\..\..\Media\BadTexture.jpg', $FFFFFF,
                             TEX_DEFAULT_2D or
                             TEX_GRAYSCALE ); // Конвертация в градации серого
                                              // через добавление флага TEX_INVERT

TexInvert := Tex_LoadFromFile( '..\..\..\Media\BadTexture.jpg', $FFFFFF,
                              TEX_DEFAULT_2D or
                              TEX_INVERT ); // Инвертируем значение цветов
                                           // через добавление флага TEX_INVERT

TexNormal := Tex_LoadFromFile( '..\..\..\Media\BadTexture.jpg', $FFFFFF,
                              TEX_DEFAULT_2D );


End;

procedure Draw;
Begin
//Чтоб скучно не было рисуем эти текстуры
SSprite_Draw( TexGray,   400 - 190, 300 - 45, 120, 90, 255, 0, FX_DEFAULT );
SSprite_Draw( TexInvert, 400 - 60, 300 - 45, 120, 90, 255, 0, FX_DEFAULT );
SSprite_Draw( TexNormal, 400 + 60, 300 - 45, 120, 90, 255, 0, FX_DEFAULT );
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

