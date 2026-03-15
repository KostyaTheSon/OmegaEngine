unit GEngine;

interface
uses
  OMEGA, uSpriteEngine, Monster1;

type
  TGameEngine = class( CSpriteEngine )
    PlayerID : Integer;
    GameOver : Boolean;

    procedure Process; override;
end;

var
  GameEngine : TGameEngine;
  LastEnemyAdd : DWORD;

implementation

procedure TGameEngine.Process;
  var
    i : Integer;
Begin
if GameOver Then Exit;

inherited;

if LastEnemyAdd + random( 1000 ) <= U_GetTime Then
  begin
    i := AddNew;
    List[ i ] := TMonster1.Create;
    List[ i ].ID := i;

    LastEnemyAdd := U_GetTime;
  end;

for i := 0 to Count - 1 do
  if List[ i ].Y > 600 Then
    begin
      Del( List[ i ].ID );
      exit;
    end else
      if List[ i ].Y < -128 Then
        begin
          Del( List[ i ].ID );
          exit;
        end;
End;

end.
