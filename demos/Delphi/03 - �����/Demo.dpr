////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                           O M E G A  E N G I N E                           //
//                                  D E M O                                   //
//                                                                            //
//    Текст... комментарии не требуются=)                                     //
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

  // Переменная, которая будет хранить идентификатор шрифта
  Font : PFont2D;

procedure Load;
Begin
End;

procedure Init;
Begin
// Загружаем шрифт
Font := Text_LoadFontFromFile( '..\..\Media\Font.gif',       // Где текстура шрифта
                               '..\..\Media\FontInfo.ofi',   // Где параметры шрифта
                               0,                               // Цвет прозрачности - черный
                               TEX_DEFAULT_2D or TEX_FILTER_NEAREST ); // Для ауентичности не будем использовать фильтрацию

End;

procedure Draw;
Begin

//Рисуем его=)
Text_Draw( Font,      // Наш идентификатор
           0, 0,      // Координаты
           PChar( 'FPS: ' + U_IntToStr( OE_GetFPS ) ), // Сам текст
           1,         // Клэффициент увеличения
           0,         // Дополнительное растояние между символами
           255,       // Альфа
           $FFFFFF ); // Ну и цвет

// А теперь проявите соображалку=) и поймите чего тут делается
Text_Draw( Font, 400 - Text_GetWidth( Font, 'Hello, World!', 6, 0 ) div 2, 300 - 98,
           'Hello, World!', 6, 0, 255, $0000FF );

Text_Draw( Font, 0, 20, U_IntToStr( M_FindAngle( Mouse_X, Mouse_Y, 400, 300 ) ) );

Pr2D_Circle( Mouse_X, Mouse_Y, 8, $FFFFFF, 255, 32, PR_FILL );
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

