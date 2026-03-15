unit uSpriteEngine;

//Delphi 3
{$IFDEF VER100}
  {$DEFINE DELPHI}
{$ENDIF}
//Delphi 4
{$IFDEF VER120}
  {$DEFINE DELPHI}
{$ENDIF}
//Delphi 5
{$IFDEF VER130}
  {$DEFINE DELPHI}
{$ENDIF}
//Delphi 6
{$IFDEF VER140}
  {$DEFINE DELPHI}
{$ENDIF}
//Delphi 7
{$IFDEF VER150}
  {$DEFINE DELPHI}
{$ENDIF}
//Delphi 2005
{$IFDEF VER170}
  {$DEFINE DELPHI}
  {$DEFINE INLINE}
{$ENDIF}
//Delphi 2006
{$IFDEF VER180}
  {$DEFINE DELPHI}
  {$DEFINE INLINE}
{$ENDIF}

{$IFNDEF DELPHI}
  {$MODE DELPHI}
{$ENDIF}

interface
uses OMEGA;

// CSprite Class

type
  CSprite = class
  protected
  public
    ID            : Integer;
    X, Y, Z       : Integer;
    Width, Height : Integer;
    Alpha         : Byte;
    Angle         : Integer;
    FX            : Integer;
    Animated      : Boolean;
    AnimSpeed     : Single;
    Frame         : Single;
    Texture       : PTexture;
    Kill          : Boolean;

    constructor Create; virtual;
    procedure Freeing; virtual;

    procedure Draw;    virtual;
    procedure Process; virtual;
end;

// CSpriteEngine Class

type
  CSpriteEngine = class
  protected
  public
    List     : array of CSprite;
    DrawList : array of Integer;
    Count    : Integer;

    InvertSort : Boolean;

    function  CreateNew : CSprite;
    function  AddNew : Integer;
    procedure Del( ID : Integer );

    procedure qSortN( iLo, iHi : Integer );
    procedure qSortI( iLo, iHi : Integer );

    procedure Draw;    virtual;
    procedure Process; virtual;
end;

var
  SEngine  : CSpriteEngine;

implementation

//----------------------------------------------------------------------------//
//------------------------------  S P R I T E  -------------------------------//
//----------------------------------------------------------------------------//

constructor CSprite.Create;
Begin
inherited;
X         := 0;
Y         := 0;
Z         := 0;
Width     := 0;
Height    := 0;
Alpha     := 255;
Angle     := 0;
Animated  := FALSE;
AnimSpeed := 0;
FX        := FX_DEFAULT;
Frame     := 1;
Kill      := FALSE;
Texture   := nil;
End;

procedure CSprite.Freeing;
Begin
End;

procedure CSprite.Draw;
Begin
if Texture = nil Then exit;
if Animated Then
  ASprite_Draw( Texture, X, Y, Width, Height, M_Round( Frame ), Alpha, Angle, FX )
else
  SSprite_Draw( Texture, X, Y, Width, Height, Alpha, Angle, FX );
End;

procedure CSprite.Process;
Begin
if Animated Then
  begin
    Frame := Frame + AnimSpeed;
    if Frame - 1 > Texture^.FramesX * Texture^.FramesY  Then
      Frame := 1;
  end;
End;

//----------------------------------------------------------------------------//
//------------------------  S P R I T E  E N G I N E  ------------------------//
//----------------------------------------------------------------------------//

function CSpriteEngine.CreateNew : CSprite;
Begin
INC( Count );

SetLength( List, Count );
SetLength( DrawList, Count );

List[ Count - 1 ]     := CSprite.Create;
List[ Count - 1 ].ID  := Count - 1;
DrawList[ Count - 1 ] := List[ Count - 1 ].ID;
Result                := List[ Count - 1 ];
End;

function CSpriteEngine.AddNew;
Begin
INC( Count );

SetLength( List, Count );
SetLength( DrawList, Count );

DrawList[ Count - 1 ] := Count - 1;
Result                := Count - 1;

End;

procedure CSpriteEngine.Del( ID : Integer );
  var
    i : Integer;
Begin
if Count = 0 Then exit;
DEC( Count );
List[ ID ].Freeing;
List[ ID ].Free;
for i := ID to Count - 1 do
  begin
    List[ i ]    := List[ i + 1 ];
    List[ i ].ID := List[ i ].ID - 1;
  end;
SetLength( List, Count );

SetLength( DrawList, Count );
for i := 0 to Count - 1 do
  DrawList[ i ] := List[ i ].ID;
End;

procedure CSpriteEngine.qSortN;
  var
    Lo, Hi, Mid, T: Integer;
begin

Lo := iLo;
Hi := iHi;
Mid := List[ DrawList[ ( Lo + Hi ) shr 1 ] ].Z;

repeat
  while List[ DrawList[ Lo ] ].Z > Mid do INC( Lo );
  while List[ DrawList[ Hi ] ].Z < Mid do DEC( Hi );
  if Lo <= Hi then
    begin
      T              := DrawList[ Lo ];
      DrawList[ Lo ] := DrawList[ Hi ];
      DrawList[ Hi ] := T;
      INC( Lo );
      DEC( Hi );
    end;
until Lo > Hi;

if Hi > iLo Then qSortN( iLo, Hi );
if Lo < iHi Then qSortN( Lo, iHi );

end;

procedure CSpriteEngine.qSortI;
  var
    Lo, Hi, Mid, T: Integer;
begin

Lo := iLo;
Hi := iHi;
Mid := List[ DrawList[ ( Lo + Hi ) shr 1 ] ].Z;

repeat
  while List[ DrawList[ Lo ] ].Z < Mid do INC( Lo );
  while List[ DrawList[ Hi ] ].Z > Mid do DEC( Hi );
  if Lo <= Hi then
    begin
      T              := DrawList[ Lo ];
      DrawList[ Lo ] := DrawList[ Hi ];
      DrawList[ Hi ] := T;
      INC( Lo );
      DEC( Hi );
    end;
until Lo > Hi;

if Hi > iLo Then qSortI( iLo, Hi );
if Lo < iHi Then qSortI( Lo, iHi );

end;

procedure CSpriteEngine.Draw;
  var
    i : Integer;
Begin
if Count > 1 Then
if InvertSort Then
  qSortI( 0, Count - 1 )
else
  qSortN( 0, Count - 1 );

for i := 0 to Count - 1 do
  List[ DrawList[ i ] ].Draw;
End;

procedure CSpriteEngine.Process;
  var
    i : Integer;
Begin
i := 0;
while i <= Count - 1 do
  begin
    if List[ i ].Kill Then
      begin
        Del( List[ i ].ID );
        DEC( i );
      end else
        List[ i ].Process;
    INC( i );
  end;
End;

initialization
begin

// S P R I T E  E N G I N E
SEngine       := CSpriteEngine.Create;
SEngine.Count := 0;

end;

end.
