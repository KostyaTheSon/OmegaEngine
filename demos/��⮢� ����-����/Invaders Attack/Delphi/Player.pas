unit Player;

interface
uses
  OMEGA, uSpriteEngine, Bullet;

type
  TPlayer = class( CSprite )
    Life    : Integer;
    Score   : Integer;
    Collis  : TAABB2D;

    constructor Create; override;
    procedure Process; override;
end;

implementation
uses
  GEngine;

constructor TPlayer.Create;
Begin
inherited;

// Загружаем текстуру
Texture := Tex_LoadFromFile( '..\media\Player.gif', $FF00FF, TEX_DEFAULT_2D );
// Обязательно выставляем размеры спрайта!!
Width := 50;
Height := 50;

Life := 100;               // Устанавливаем жизни
Y := 600 - 50 - 10;        // Перемещаемся чуть выше нижнего края
X := 700 div 2 + 100 - 25; // Очень сложная комбинация просчета центра=)
Z := 1;
End;

procedure TPlayer.Process;
  var
    i : Integer;
Begin
inherited;

if Mouse_Press( M_LBUTTON ) Then
  begin
    i := GameEngine.AddNew;
    GameEngine.List[ i ] := TBullet.Create;
    GameEngine.List[ i ].ID := i;
    GameEngine.List[ i ].X  := X + 25 - 3;
    GameEngine.List[ i ].Y  := Y - 10;
  end;

// Двигаем спрайт в два раза медленнее чем двигается курсор
X := X + Mouse_DeltaX div 2;

// Если вылазим за границы то ставим на место
if X < 100 Then X := 100;
if X > 800 - 50 Then X := 800 - 50;

// Блокируем мышь по центру экрана чтоб на следующий проход возможно было выделить
// DeltaX
Mouse_Lock;

Collis.X := X;
Collis.Y := Y;
Collis.Width := 50;
Collis.Height := 50;

if Life <= 0 Then GameEngine.GameOver := TRUE;
End;

end.
