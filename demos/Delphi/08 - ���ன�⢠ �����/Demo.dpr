////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                           O M E G A  E N G I N E                           //
//                                  D E M O                                   //
//                                                                            //
//    За более подробным описанием функций для обработки устройств ввода      //
//  обращайтесь в справку.                                                    //
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

  // Будут координаты спрайта, чтоб с помощью устройств ввода его перемещать
  X, Y : Integer;

procedure Load;
Begin
End;

procedure Init;
Begin
randomize; // что это=)

// Загружаем текстуру Logo
Texture := Tex_LoadFromFile( '..\..\Media\Logo.gif', $FFFFFF, TEX_DEFAULT_2D );
End;

procedure Draw;
Begin
//Рисуем уже немного знакомой командой статичный спрайт Logo
SSprite_Draw( Texture, X, Y, 128, 128, 255, 0, FX_DEFAULT );

End;

procedure Quit;
Begin
End;

procedure Timer1;
Begin

// Мучаем клаву=)
if Key_Down( K_RIGHT ) Then X := X + 1;
if Key_Down( K_LEFT  ) Then X := X - 1;
if Key_Down( K_UP    ) Then Y := Y - 1;
if Key_Down( K_DOWN  ) Then Y := Y + 1;
// Press означает что клавиатура была нажата полностью, т.е. с отпуском
if Key_Press( K_SPACE ) Then
  begin
    X := random( 800 - 128 );
    Y := random( 600 - 128 );
  end;

// Теперь грызуна
if Mouse_Move Then
  begin
    X := Mouse_X;
    Y := Mouse_Y;
  end;

// Джойстки обрабатывается аналогично клавиатуре, например:
//if Joy_Down( JOY_0, JOY_BUTTON01 ) Then...
// но все оставляю в комментариях, потому как при отсутствии джойстика ответы
// могут быть неправильными насчет команд вроде этой Joy_AxePos( JOY_0, JOY_XLEFT );

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

