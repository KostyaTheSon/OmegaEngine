////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                           O M E G A  E N G I N E                           //
//                                  D E M O                                   //
//                                                                            //
//    Здесь демонстрируется отрисовка разнообразных примитивов с помощью      //
//  функций движка                                                            //
//                                                                            //
//  (C)2006 Andru 'aka' KEMKA ANDREY.                                         //
//  web  : HTTP://isada.mirgames.ru                                           //
//  eMail: Andru_@list.ru                                                     //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

uses
  OMEGA in '..\..\..\headers\Delphi\OMEGA.pas';


var
  MyTimer : PTimer;

  // Переменная, которая будут хранить идентификатор текстуры
  Texture : PTexture;

procedure Load;
begin
end;

procedure Init;
begin
end;

procedure Draw;
begin
// Рисуем две линии - обычную и сглаженную
Pr2D_LineWidth( 4 ); // Для чуть большего эффекта увеличим ширину линии
Pr2D_Line(
           0, 0,         // Начальные координаты
           200, 100,     // Конечные координаты
           $00FF00,      // Цвет
           255,          // Альфа
           PR_DEFAULT ); // Флаги
Pr2D_Line( 200, 0, 0, 100, $00FF00, 255, PR_SMOOTH );

Pr2D_LineWidth( 1 ); // Возвращаем на всякий случай ширину линии
// Рисуем два прямоугольника - заполненный и обычный
Pr2D_Rect( 200, 0,    // Координаты левого верхнего угла
           100, 50,   // Ширина и высота прямоугольника
           $FFFFFF,   // Цвет
           255,       // Альфа
           PR_FILL ); // Флаги
Pr2D_Rect( 200, 50, 100, 50, $FFFFFF, 255, PR_DEFAULT );

// Аналагично рисуем две окрудности и эллипс
Pr2D_Circle( 350, 50,      // Координаты центра окружности
             50,           // Радиус
             $FF0000,      // Цвет
             255,          // Альфа
             32,           // Качество, другими слова - сколько линий содержит окружность
             PR_DEFAULT ); // Флаги
Pr2D_Circle( 450, 50, 50, $FF0000, 255, 32, PR_FILL );

Pr2D_Ellipse(
              600, 50,      // Центр эллипса
              100, 50,      // Радиусы по оси X и Y
              $FFFFFF,      // Цвет
              255,          // Альфа
              32,           // Качество
              PR_DEFAULT ); // Флаги
Pr2D_Ellipse( 750, 100, 50, 100, $FFFFFF, 255, 32, PR_FILL );
end;

procedure Quit;
begin
end;

procedure Timer1;
begin
// По нажатию Escape завершаем работу
if Key_Down( K_ESCAPE ) Then OE_Quit;
end;

begin

// Создаем таймер
MyTimer := Timer_Create( @Timer1, 10 );

// Назначаем "системные" процедуры
OE_RegProcedure( SYS_FASTINIT, @Load );
OE_RegProcedure( SYS_INIT,     @Init );
OE_RegProcedure( SYS_DRAW,     @Draw );
OE_RegProcedure( SYS_QUIT,     @Quit );

OE_SetScreenOptions( 800, 600, 32, 0, true, false );

//Запускаем движок, пока в тестовом режиме
OE_Init;

end.

