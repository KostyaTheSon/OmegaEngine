////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                           O M E G A  E N G I N E                           //
//                                  D E M O                                   //
//                                                                            //
//    Проигрывать медиафайлы с помощью движка очень просто.                   //
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

procedure Load;
Begin
End;

procedure Init;
Begin

// В примере я не использовал формат mp3, или другой поддерживаемый, поэтому
// не надо считать что двиг не поддерживает mp3, wma, avi, asf и т.д.
Media_Play(
            '..\..\Media\beam.wav', // Файл где находится медиа-файл
            TRUE );                    // Зацикленно играем
// Если же используем видео-файлы, то тут следует воспользоваться еще и функцией
// Media_SetWindowRect. Там все довольно просто.

End;

procedure Draw;
Begin
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

