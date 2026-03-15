////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                           O M E G A  E N G I N E                           //
//                                  D E M O                                   //
//                                                                            //
//    Демонстрируется как использовать 2D-камеры                              //
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
  
  // Переменная, которая будет хранить идентификатор текстуры
  Texture : PTexture;

  // Шрифт
  Font : PFont2D;

  //По сути указатель на текущую 2D-камеру которую использует движок
  Camera : PCamera2D;

procedure Load;
Begin
End;

procedure Init;
Begin
randomize; // что это=)

// Загружаем текстуру Logo
Texture := Tex_LoadFromFile( '..\..\Media\Logo.gif', $FFFFFF, TEX_DEFAULT_2D );

// Загружаем шрифт
Font := Text_LoadFontFromFile( '..\..\Media\Font.gif',
                               '..\..\Media\FontInfo.ofi' );

// Создаем камеру
Camera := Cam2D_Create;
Cam2D_Set( Camera );
End;

procedure Draw;
Begin
//Рисуем уже Logo в нулевых координатах, так как все остальное делает камера
SSprite_Draw( Texture, 0, 0, 128, 128, 255, 0, FX_DEFAULT );

// Отключаем камеру на момент вывода текста
Camera^.Active := FALSE;
Text_Draw( Font, 0, 0, PChar( 'FPS: ' + U_IntToStr( OE_GetFPS ) ) );
Camera^.Active := TRUE;

End;

procedure Quit;
Begin
End;

procedure Timer1;
Begin

// Двигаем камеру за грызуном, только инвертируем координаты чтоб левый угол
// спрайта "весел" на грызуне
Camera^.X := -Mouse_X;
Camera^.Y := -Mouse_Y;

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

