////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                           O M E G A  E N G I N E                           //
//                                  D E M O                                   //
//                                                                            //
//    Хотя приведенный тут "алгоритм позиционирования звука" считать          //
//  правильным не стоит, но решить простые задачи он позволит. И маленькое    //
//  пояснение: координаты 400/300 являются координатами слушателя.            //
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

  //Идентификатор звук
  Sound : PSound;
  ID    : Integer; // Идентификатор для измены параметров проигрывания

// Вообще поэксперементируйте сами...
function CalcX( X : Integer ) : Integer;
Begin
Result := ( X - 400 ) * 5;
End;

function CalcY( Y : Integer ) : Integer;
Begin
Result := -( 300 - Y );
End;

procedure Load;
Begin
End;

procedure Init;
Begin

Snd_Init; // Инициализируем звуковую подсистему
// Загружаем звук
Sound := Snd_LoadFromFile( '..\..\Media\snd.wav', // Где наш сэмпл
                           1 );                      // Нам хватит и одного буфера
// Зацыкленно воспроизводим
ID := Snd_Play( Sound,  // Идентификатор звука
                0,      // Значение Pan
                0,      // "Громксоть"
                0,      // Частота проигрывания
                TRUE ); // Зацикленно ли играть
// Ну и еще, 0 - это значения по-умолчанию

End;

procedure Draw;
Begin

Pr2D_Circle( 400, 300, 16, $00FF00, 255, 32, PR_FILL );

Pr2D_Circle( Mouse_X, Mouse_Y, 8, $FF0000, 255, 32, PR_FILL );

End;

procedure Quit;
Begin
End;

procedure Timer1;
Begin

// Меняем параметры звук
Snd_ChangeParam( Sound,            // Знакомый параметр
                 ID,               // Идентификатор буфера который играет
                 CalcX( Mouse_X ), // Новые "X-координаты"
                 CalcY( Mouse_Y ), // Новые "Y-координаты"
                 0 );              // Частоту оставляем без измен

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

