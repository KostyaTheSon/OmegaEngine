unit Monster1;

interface
uses
  OMEGA, uSpriteEngine;

type
  TMonster1 = class( CSprite )
    Life    : Integer;
    Speed   : Integer;
    Demage  : Integer;
    Collis  : TAABB2D;

    constructor Create; override;
    procedure Process; override;
end;

var
  Monster1_Tex : PTexture;

implementation
uses GEngine, Player, Boom;

constructor TMonster1.Create;
Begin
inherited;

// Загружаем текстуру
Texture := Monster1_Tex;
// Обязательно выставляем размеры спрайта!!
Width := 48;
Height := 48;
Animated := TRUE;
AnimSpeed := 0.5;

Life  := 100;
Speed := random( 3 ) + 2;
Demage:= random( 50 );
X     := random( 700 ) + 100;
Y     := -64;
Z     := random( 100 ); // На практике надо четко продумать Z-координаты 
End;

procedure TMonster1.Process;
  var
    i : Integer;
Begin
inherited;
Y := Y + Speed;

if Life <= 0 Then
  begin
    Kill := TRUE;
    i := GameEngine.AddNew;
    GameEngine.List[ i ] := TBoom.Create;
    GameEngine.List[ i ].ID := i;
    GameEngine.List[ i ].X  := X + 24 - 32;
    GameEngine.List[ i ].Y  := Y + 24 - 32;
    INC( ( GameEngine.List[ GameEngine.PlayerID ] as TPlayer ).Score, 10 );
  end;

Collis.X := X + 10;
Collis.Y := Y + 10;
Collis.Width := 25;
Collis.Height := 30;

if Col_AABB( @Collis, @( GameEngine.List[ GameEngine.PlayerID ] as TPlayer ).Collis ) Then
  begin
    DEC( ( GameEngine.List[ GameEngine.PlayerID ] as TPlayer ).Life, Demage );
    Kill := TRUE;
    Exit;
  end;
End;

end.
