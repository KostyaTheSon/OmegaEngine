unit Bullet;

interface
uses
  OMEGA, uSpriteEngine;

type
  TBullet = class( CSprite )
    Speed : Integer;
    Collis: TAABB2D;
    
    constructor Create; override;
    procedure Process; override;
end;

var
  Bullet_Tex : PTexture;

implementation
uses
  GEngine, Monster1;

constructor TBullet.Create;
Begin
inherited;
// Загружаем текстуру
Texture := Bullet_Tex;
// Обязательно выставляем размеры спрайта!!
Width := 7;
Height := 13;

Speed := random( 2 ) + 5;
End;

procedure TBullet.Process;
  var
    i : Integer;
Begin
Y := Y - Speed;

Collis.X := X;
Collis.Y := Y;
Collis.Width := 7;
Collis.Height := 13;

for i := 0 to GameEngine.Count - 1 do
  if GameEngine.List[ i ] is TMonster1 Then
    if Col_AABB( @Collis, @( GameEngine.List[ i ] as TMonster1 ).Collis ) Then
      begin
        DEC( ( GameEngine.List[ i ] as TMonster1 ).Life, 50 );
        Kill := TRUE;
        Exit;
      end;
End;

end.
