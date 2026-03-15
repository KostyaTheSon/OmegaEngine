////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                           O M E G A  E N G I N E                           //
//                                  D E M O                                   //
//                                                                            //
//    Этот пример показывает как правильно пользоваться функциями коллизий    //
//  для TPolyLine2D                                                           //
//                                                                            //
//  (C)2006 Andru 'aka' KEMKA ANDREY.                                         //
//  web  : HTTP://isada.mirgames.ru                                           //
//  eMail: Andru_@list.ru                                                     //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////
program Demo;

uses
  OMEGA in '..\..\..\..\headers\Delphi\OMEGA.pas';

var
  Timer     : PTimer;

  orig_Ship : TPolyLine2D;

  Ship1     : TPolyLine2D;
  Ship2     : TPolyLine2D;

  X, Y      : Single;
  Color     : Integer = $FFFFFF;
  Ang       : Integer;

  Fnt       : PFont2D;

procedure Init;
Begin

Fnt := Text_LoadFontFromFile( '..\..\..\Media\Font.gif', '..\..\..\Media\FontInfo.ofi' );

// Создаем корабль
// Увеличиваем размер массива точек на n+1
SetLength( orig_Ship.Points, 25 );
orig_Ship.Count := 24; // Устанавливаем количество точек в PolyLine
// Думаю таким садизмом по отношению к себе вы заниматься не будете=)
orig_Ship.Points[ 0 ].X  := 10;   orig_Ship.Points[ 0 ].Y  := 110;
orig_Ship.Points[ 1 ].X  := 20;   orig_Ship.Points[ 1 ].Y  := 80;
orig_Ship.Points[ 2 ].X  := 10;   orig_Ship.Points[ 2 ].Y  := 70;
orig_Ship.Points[ 3 ].X  := 10;   orig_Ship.Points[ 3 ].Y  := -10;
orig_Ship.Points[ 4 ].X  := 30;   orig_Ship.Points[ 4 ].Y  := -10;
orig_Ship.Points[ 5 ].X  := 30;   orig_Ship.Points[ 5 ].Y  := -20;
orig_Ship.Points[ 6 ].X  := 110;  orig_Ship.Points[ 6 ].Y  := -30;
orig_Ship.Points[ 7 ].X  := 110;  orig_Ship.Points[ 7 ].Y  := -60;
orig_Ship.Points[ 8 ].X  := 30;   orig_Ship.Points[ 8 ].Y  := -70;
orig_Ship.Points[ 9 ].X  := 20;   orig_Ship.Points[ 9 ].Y  := -80;
orig_Ship.Points[ 10 ].X := 10;   orig_Ship.Points[ 10 ].Y := -80;
orig_Ship.Points[ 11 ].X := 10;   orig_Ship.Points[ 11 ].Y := -70;
orig_Ship.Points[ 12 ].X := -10;  orig_Ship.Points[ 12 ].Y := -70;
orig_Ship.Points[ 13 ].X := -10;  orig_Ship.Points[ 13 ].Y := -80;
orig_Ship.Points[ 14 ].X := -20;  orig_Ship.Points[ 14 ].Y := -80;
orig_Ship.Points[ 15 ].X := -30;  orig_Ship.Points[ 15 ].Y := -70;
orig_Ship.Points[ 16 ].X := -110; orig_Ship.Points[ 16 ].Y := -60;
orig_Ship.Points[ 17 ].X := -110; orig_Ship.Points[ 17 ].Y := -30;
orig_Ship.Points[ 18 ].X := -30;  orig_Ship.Points[ 18 ].Y := -20;
orig_Ship.Points[ 19 ].X := -30;  orig_Ship.Points[ 19 ].Y := -10;
orig_Ship.Points[ 20 ].X := -10;  orig_Ship.Points[ 20 ].Y := -10;
orig_Ship.Points[ 21 ].X := -10;  orig_Ship.Points[ 21 ].Y := 70;
orig_Ship.Points[ 22 ].X := -20;  orig_Ship.Points[ 22 ].Y := 80;
orig_Ship.Points[ 23 ].X := -10;  orig_Ship.Points[ 23 ].Y := 110;
orig_Ship.Points[ 24 ].X := 10;   orig_Ship.Points[ 24 ].Y := 110;
// Чтоб корабль было видно, переместим его
ColEx_PolyMove( @orig_Ship, @orig_Ship, 110, 110 );
// Находим центр используя движковую функцию
ColEx_PolyCenter( @orig_Ship );

SetLength( Ship1.Points, 25 );
Ship1.Count := 24;
SetLength( Ship2.Points, 25 );
Ship2.Count := 24;

Pr2D_LineWidth( 2 );

End;

procedure Draw;
  var
    i : Integer;
Begin

Pr2D_Polygon( Ship1.Points, 24, Color, 155, PR_FILL );
Pr2D_Polygon( Ship2.Points, 24, $FF0000 );

Text_Draw( Fnt, 0, 0, PChar( 'FPS: ' + U_IntToStr( OE_GetFPS ) ) );

End;

procedure Quit;
Begin

End;

procedure Process;
Begin

if Key_Down( K_Right ) Then
  Ang := Ang + 1;
if Key_Down( K_Left ) Then
  Ang := Ang - 1;
if Key_Down( K_Down ) Then
  begin
    X := X - M_Cos( Ang + 90 ) * 2;
    Y := Y - M_Sin( Ang + 90 ) * 2;
  end;
if Key_Down( K_Up ) Then
  begin
    X := X + M_Cos( Ang + 90 ) * 2;
    Y := Y + M_Sin( Ang + 90 ) * 2;
  end;
// Что мы тут делаем:
// Перемещаем оригинал корабля но позицию где должен стоять кораблик, потом
// крутим кораблик и масштабируем его. Почему так? А потому что каждая операция
// использует исходные данные оригинала и поэтому переместив клон а потом
// повернув его относительно оригинала мы варачиваем его в 0 позцию...
// Для этого надо переместить оригинал а потом после всех операций вернуть его
// обратно. Масштабирование же происходит относительно самого клона
ColEx_PolyMove( @orig_Ship, @orig_Ship, M_Round( X ), M_Round( Y ) );
ColEx_PolyRotate( @orig_Ship, @Ship1, Ang );
ColEx_PolyScale( @Ship1, 0.5, 0.5 );
ColEx_PolyMove( @orig_Ship, @orig_Ship, -M_Round( X ), -M_Round( Y ) );
// Если б действия на клоне ограничились поворотом и перемещением, то можно было
// бы сделать так:
//ColEx_PolyRotate( @orig_Ship, @Ship1, Ang );
//ColEx_PolyMove( @Ship1, @Ship1, M_Round( X ), M_Round( Y ) );

// Ну а второй корабль только переместим  
ColEx_PolyMove( @orig_Ship, @Ship2, 300, 200 );

// Если происходит столкновение то изменяем цвет
if Col_PolyLine( @Ship1, @Ship2 ) Then
  Color := $0000FF
else
  Color := $FFFFFF;

if Key_Down( K_Escape ) Then OE_Quit;

End;

begin
          
Timer := Timer_Create( @Process, 10, 0 );

OE_SetScreenOptions( 800, 600, 32, 0, TRUE, FALSE );

OE_RegProcedure( SYS_INIT, @Init );
OE_RegProcedure( SYS_DRAW, @Draw );
OE_Init;

end.
