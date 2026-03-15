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

  // Переменная, которая будет хранить идентификатор шрифта для консоли
  Font : PFont2D;

procedure Load;
Begin
End;

procedure Init;
Begin
// Загружаем шрифт
Font := Text_LoadFontFromFile( '..\..\Media\consoleFont.gif', '..\..\Media\consoleFontInfo.ofi' );

Console_Setoptions( Font,    // Задаем шрифт
                    nil,     // Если значение nil, то будет фон цвета...
                    0,       // указанного тут
                    155,     // Альфа консоли
                    $FFFFFF, // Цвет шрифта
                    255 );   // Альфа шрифта
Console_Active( TRUE ); // Разрешаем использовать консоль

// В качестве примера зарегистрируем движковую функцию выхода как команду Quit
Console_RegCommand( 'quit', @OE_Quit );

// Добавим информацию о приложении
Console_AddString( '###########################' );
Console_AddString( '# Simple console application v.1.0 #' );
Console_AddString( '###########################' );

End;

procedure Draw;
Begin
Console_Draw; // Рисуем консоль, ее надо вставить в конце всех отрисовок
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

