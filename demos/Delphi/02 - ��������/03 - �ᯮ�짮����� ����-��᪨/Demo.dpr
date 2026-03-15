////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                           O M E G A  E N G I N E                           //
//                                  D E M O                                   //
//                                                                            //
//    Демонстрация загрузки текстуры с использованием предварительно          //
//  загруженной маской                                                        //
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
  
  // Переменная, которая будут хранить идентификатор текстуры
  Texture : PTexture;

procedure Load;
Begin
End;

procedure Init;
Begin
// Загружаем маску указывая только имя файла
Tex_LoadMaskFromFile( '..\..\..\Media\Mask.gif' );

// Загружаем текстуру.
//ВНИМАНИЕ: Если размеры маски и текстуры не совпадают - это грозит ошибками
// в памяти!
Texture := Tex_LoadFromFile( '..\..\..\Media\Texture01.jpg', -1,
                             TEX_DEFAULT_2D or
                             TEX_USEMASK ); // Добавляя флаг TEX_USEMASK движок
                                            // будет использовать последнюю
                                            // загруженную маску

// Если будут загружаться другие маски, то следует сперва очистить эту
Tex_FreeMask;

End;

procedure Draw;
Begin
//Чтоб скучно не было рисуем эти текстуры
SSprite_Draw( Texture, 400 - 320, 300 - 125, 640, 250, 255, 0, FX_DEFAULT );
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

