unit Boom;

interface
uses
  OMEGA, uSpriteEngine, Bullet;

type
  TBoom = class( CSprite )
    constructor Create; override;
    procedure Draw; override;
    procedure Process; override;
end;

var
  Boom_Tex : PTexture;

implementation
uses
  GEngine;

constructor TBoom.Create;
Begin
inherited;

// Загружаем текстуру
Texture := Boom_Tex;
// Обязательно выставляем размеры спрайта!!
Width := 64;
Height := 64;
Frame := 1;
Animated := TRUE;
AnimSpeed := 0.5;
End;

procedure TBoom.Draw;
Begin
FX_SetBlendMode( FX_BLEND_ADD );
inherited;
FX_SetBlendMode( FX_BLEND_NORMAL );
End;

procedure TBoom.Process;
  var
    i : Integer;
Begin
inherited;
if Frame >= 32 Then Kill := TRUE;
End;

end.
