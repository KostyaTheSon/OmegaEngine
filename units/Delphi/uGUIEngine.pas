////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////                                                                        ////
////     01010101   010        010   0101010101   0101010101      0110      ////
////    01      01  01010    10101   01           01             01  10     ////
////   01        01 01 010  101 01   01           01             01  10     ////
////   01        01 01  010010  01   0101010101   01            01    10    ////
////    01      01  01    00    01   01           01    0101    01010110    ////
////     01    01   01          01   01           01      01   01      10   ////
////   0101    0101 01          01   0101010101   0101010101   01      10   ////
////                                                                        ////
////                                                                        ////
////                    0101010101   01     01   010101                     ////
////                    01           01     01     01                       ////
////                    01           01     01     01                       ////
////                    01           01     01     01                       ////
////                    01    0101   01    011     01                       ////
////                    01      01   01  01011     01                       ////
////                    0101010101   01010  01   010101                     ////
////                                                                        ////
////   Версия    : 0.2 beta 2                                               ////
////   Дата      : 27.12.06                                                 ////
////   eСтраничка: http://www.isada.mirgames.ru/omega.php                   ////
////                                                                        ////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////                                                                        ////
////  АВТОР: Andru 'aka' КЕМКА АНДРЕЙ                                       ////
////  Mail: Andru_@list.ru                                                  ////
////  Site: http://isada.mirgames.ru                                        ////
////                                                                        ////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////                                                                        ////
////             Л И Ц Е Н З И О Н Н О Е  С О Г Л А Ш Е Н И Е :             ////
////                                                                        ////
////    Всё лицензионное соглашение приведено в соответствующих файлах      ////
////  и в справке к движку. Там же указаны все авторские права.             ////
////                                                             (С)2006    ////
////                                                                        ////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
unit uGUIEngine;

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
{$ENDIF}
//Delphi 2006
{$IFDEF VER180}
  {$DEFINE DELPHI}
{$ENDIF}

{$IFNDEF DELPHI}
  {$MODE DELPHI}
{$ENDIF}

interface
uses
  OMEGA, uSpriteEngine;

type TGUIStatus = ( gsDisable, gsNormal, gsPress, gsFocus );
type TGUIAlign = ( gaLeft, gaRight, gaCenter, gaTop, gaBottom );

type
  TGUICursor = record
    X, Y    : Integer;
    Texture : PTexture;
end;

type
  TGUIFont = record
    fType : PFont2D;
    Scale : Single;
    Step  : Integer;
    Alpha : Byte;
    Color : Integer;
end;

type
  CGUIEngine = class( CSpriteEngine )
  public
    Cursor      : TGUICursor;
    LastZ       : Integer;

    TabWindows  : Boolean;

    WndActive   : Integer;

    constructor Create;
    procedure Draw; override;
    procedure Process; override;
    
    function AddWindow( Texture             : PTexture;
                        X, Y, Width, Height : Integer;
                        Alpha               : Byte = 255 ) : Integer;
    procedure DelWindow( ID : Integer );
end;

type
  CGUIElement = class( CSprite )
  protected
    KeyLastDown : Byte;
    KeyLastUp   : Byte;
  public
    Parent   : CGUIElement;
    Status   : TGUIStatus;
    Focused  : Boolean;
    Visible  : Boolean;

    Color        : Integer;
    BorderColor  : Integer;
    DisableColor : Integer;

    Caption  : String;
    Font     : TGUIFont;

    POnKeyDown       : Procedure( KeyCode : Byte; Sender, Parent : CGUIElement );
    POnKeyUp         : Procedure( KeyCode : Byte; Sender, Parent : CGUIElement );
    POnMouseMove     : Procedure( X, Y : Integer; Sender, Parent : CGUIElement );
    POnMouseClick    : Procedure( mButton : Byte; Sender, Parent : CGUIElement );
    POnMouseDblClick : Procedure( mButton : Byte; Sender, Parent : CGUIElement );
    POnMouseUp       : Procedure( mButton : Byte; Sender, Parent : CGUIElement );
    POnProcess       : Procedure( Sender, Parent : CGUIElement );

    constructor Create; override;

    procedure OnKeyDown;
    procedure OnKeyUp;
    procedure OnMouseMove;
    procedure OnMouseClick;
    procedure OnMouseDblClick;
    procedure OnMouseUp;

    procedure Process; override;
    procedure ResetFocus; virtual;
end;

type
  CGUIWindow = class( CGUIElement )
  protected
    IsMoved : Boolean;
    MoveX   : Integer;
    MoveY   : Integer;
  public
    CaptionHeight : Integer;

    CanMove : Boolean; 

    eList   : array of CGUIElement;
    eDraw   : array of Integer;
    eCount  : Integer;

    LastZ   : Integer;

    procedure qSortN( iLo, iHi : Integer );

    procedure Process; override;
    procedure Draw; override;
    procedure ResetFocus; override;

    procedure DelElement( ID : Integer );

    function AddButton(
                        Texture             : PTexture;
                        Caption             : String;
                        Font                : PFont2D;
                        X, Y, Width, Height : Integer;
                        Alpha               : Byte = 255;
                        OnClick             : Pointer = nil ) : Integer;
    function AddLabel(
                       Caption : String;
                       Font    : PFont2D;
                       X, Y    : Integer;
                       Alpha   : Byte = 255 ) : Integer;
    function AddEdit(
                      Caption             : String;
                      Texture             : PTexture;
                      Font                : PFont2D;
                      X, Y, Width, Height : Integer;
                      Max                 : Integer = -1;
                      Alpha               : Byte = 255 ) : Integer;
    function AddImage(
                       Texture : PTexture;
                       X, Y    : Integer;
                       Alpha   : Byte = 255 ) : Integer;
    function AddCheckBox(
                          Caption             : String;
                          Texture             : PTexture;
                          Font                : PFont2D;
                          X, Y, Width, Height : Integer;
                          Checked             : Boolean = FALSE;
                          Alpha               : Byte = 255 ) : Integer;
    function AddProgressBar(
                             Texture             : PTexture;
                             Font                : PFont2D;
                             X, Y, Width, Height : Integer;
                             MaxValue            : Integer = 100;                             
                             Alpha               : Byte = 255 ) : Integer;
end;

type
  CGUIButton = class( CGUIElement )
  public
    constructor Create; override;
    procedure Draw; override;
    procedure Process; override;
end;

type
  CGUILabel = class( CGUIElement )
  public
    AutoSize  : Boolean;
    TextAlign : TGUIAlign;

    constructor Create; override;
    procedure Draw; override;
    procedure Process; override;
end;

type
  CGUIEdit = class( CGUIElement )
  protected
    OldText  : String;
    TextLine : Byte; 
  public
    TextAlign   : TGUIAlign;
    Max         : Integer;

    constructor Create; override;
    procedure Draw; override;
    procedure Process; override;
end;

type
  CGUIImage = class( CGUIElement )
  public
    AutoSize  : Boolean;

    constructor Create; override;
    procedure Draw; override;
    procedure Process; override;
end;

type
  CGUICheckBox = class( CGUIElement )
  protected
    IsUp : Boolean;
  public
    Checked : Boolean;
    constructor Create; override;
    procedure Draw; override;
    procedure Process; override;
end;

type
  CGUIProgressBar = class( CGUIElement )
  public
    Progress      : Integer;
    MaxValue      : Integer;
    ProgressColor : Integer;

    constructor Create; override;    
    procedure Draw; override;
    procedure Process; override;
end;

function PointInRect( pX, pY, X, Y, Width, Height : Integer ) : Boolean;

implementation
var
  mX, mY : Integer;

function PointInRect( pX, pY, X, Y, Width, Height : Integer ) : Boolean;
Begin
if ( pX > X ) and ( pX < X + Width  ) and
   ( pY > Y ) and ( pY < Y + Height ) Then
  Result := TRUE
else
  Result := FALSE;
End;

procedure ZeroProc( Param : Integer; Sender, Parent : CGUIElement );
Begin
End;

//----------------------------------------------------------------------------//
//------------------------  G U I  E L E M E N T  ----------------------------//
//----------------------------------------------------------------------------//

constructor CGUIElement.Create;
Begin
inherited;
Alpha            := 255;
Caption          := '';
Status           := gsNormal;
Font.Scale       := 1;
Font.Step        := 0;
Font.Alpha       := 255;
Font.Color       := $FFFFFF;
POnKeyDown       := nil;
POnKeyUp         := nil;
POnMouseMove     := nil;
POnMouseClick    := nil;
POnMouseDblClick := nil;
POnMouseUp       := nil;
Visible          := TRUE;
Color            := $AAAAAA;
BorderColor      := $111111;
DisableColor     := $BBBBBB;
End;

procedure CGUIElement.OnKeyDown;
Begin
if @POnKeyDown <> nil Then
  begin
    if Key_LastDown <> KeyLastDown Then
      begin
        KeyLastDown := Key_LastDown;
        POnKeyDown( KeyLastDown, Self, Parent );
      end else
        if Key_Down( KeyLastDown ) Then
          begin
            KeyLastDown := Key_LastDown;
            POnKeyDown( KeyLastDown, Self, Parent );
          end;
  end;
End;

procedure CGUIElement.OnKeyUp;
Begin
if @POnKeyUp <> nil Then
  begin
    if Key_LastPress <> KeyLastUp Then
      begin
        KeyLastUp := Key_LastPress;
        POnKeyUp( KeyLastUp, Self, Parent );
      end else
        if Key_Press( KeyLastUp ) Then
          begin
            KeyLastUp := Key_LastPress;
            POnKeyUp( KeyLastUp, Self, Parent );
          end;
  end;
End;

procedure CGUIElement.OnMouseMove;
Begin
if @POnMouseMove <> nil Then
  POnMouseMove( mX - Parent.X, mY - Parent.Y, Self, Parent );
End;

procedure CGUIElement.OnMouseClick;
Begin
if @POnMouseClick <> nil Then
  begin
    if Mouse_Click( M_LBUTTON ) Then
      POnMouseClick( M_LBUTTON, Self, Parent );
    if Mouse_Click( M_RBUTTON ) Then
      POnMouseClick( M_RBUTTON, Self, Parent );
    if Mouse_Click( M_MBUTTON ) Then
      POnMouseClick( M_MBUTTON, Self, Parent );
  end;
End;

procedure CGUIElement.OnMouseDblClick;
Begin
if @POnMouseDblClick <> nil Then
  begin
    if Mouse_DblClick( M_LBUTTON ) Then
      POnMouseDblClick( M_LBUTTON, Self, Parent );
    if Mouse_DblClick( M_RBUTTON ) Then
      POnMouseDblClick( M_RBUTTON, Self, Parent );
    if Mouse_DblClick( M_MBUTTON ) Then
      POnMouseDblClick( M_MBUTTON, Self, Parent );
  end;
End;

procedure CGUIElement.OnMouseUp;
Begin
if @POnMouseUp <> nil Then
  begin
    if Mouse_Press( M_LBUTTON ) Then
      POnMouseUp( M_LBUTTON, Self, Parent );
    if Mouse_Press( M_RBUTTON ) Then
      POnMouseUp( M_RBUTTON, Self, Parent );
    if Mouse_Press( M_MBUTTON ) Then
      POnMouseUp( M_MBUTTON, Self, Parent );
  end;
End;

procedure CGUIElement.Process;
Begin
if Status = gsDisable Then exit;
if not Visible Then exit;

if Focused Then
  begin
    OnKeyDown;
    OnKeyUp;
  end;
if PointInRect( Mouse_X, Mouse_Y, Parent.X + X, Parent.Y + Y, Width, Height ) Then
  begin
    if Mouse_Move then
      OnMouseMove;
    OnMouseUp;
    OnMouseClick;
    OnMouseDblClick;

    if Self is CGUIButton Then
      Status := gsFocus;

    if Mouse_Down( M_LBUTTON ) Then
      Status := gsPress
    else
      if Status <> gsFocus Then Status := gsNormal;

  end else
    Status := gsNormal;

if @POnProcess <> nil Then
  POnProcess( Self, Parent );    

End;

procedure CGUIElement.ResetFocus;
Begin
Focused := FALSE;
End;

//----------------------------------------------------------------------------//
//-------------------------  G U I  B U T T O N  -----------------------------//
//----------------------------------------------------------------------------//

constructor CGUIButton.Create;
Begin
inherited;
Color := $888888;
End;

procedure CGUIButton.Draw;
Begin

if not Visible Then exit;

if Texture = nil Then
  begin
    case Status of
    gsDisable:
      begin
        Pr2D_Rect( Parent.X + X, Parent.Y + Y, Width, Height, DisableColor, Alpha, PR_FILL );
      end;
    gsNormal:
      begin
        Pr2D_Rect( Parent.X + X, Parent.Y + Y, Width, Height, Color, Alpha, PR_FILL );
        Pr2D_Rect( Parent.X + X, Parent.Y + Y, Width, Height, BorderColor, Alpha );
      end;
    gsPress:
      begin
        Pr2D_Rect( Parent.X + X, Parent.Y + Y, Width, Height, Color, Alpha, PR_FILL );
        Pr2D_Rect( Parent.X + X, Parent.Y + Y, Width, Height, BorderColor, Alpha );
      end;
    gsFocus:
      begin
        Pr2D_Rect( Parent.X + X, Parent.Y + Y, Width, Height, Color, Alpha, PR_FILL );
        Pr2D_Rect( Parent.X + X, Parent.Y + Y, Width, Height, BorderColor, Alpha );
        Pr2D_Rect( Parent.X + X + 1, Parent.Y + Y, Width - 1, Height - 1, $FFFFFF, Alpha div 2, PR_FILL );
      end;
    end;
  end else
    case Status of
    gsDisable : ASprite_Draw( Texture, Parent.X + X, Parent.Y + Y, Width, Height, 1, Alpha );
    gsNormal  : ASprite_Draw( Texture, Parent.X + X, Parent.Y + Y, Width, Height, 2, Alpha );
    gsPress   : ASprite_Draw( Texture, Parent.X + X, Parent.Y + Y, Width, Height, 3, Alpha );
    gsFocus   : ASprite_Draw( Texture, Parent.X + X, Parent.Y + Y, Width, Height, 4, Alpha );
    end;

if ( Font.fType <> nil ) and ( Caption <> '' ) Then
  Text_Draw( Font.fType,
             Parent.X + X + ( Width - Text_GetWidth( Font.fType, PChar( Caption ), Font.Scale, Font.Step ) ) div 2,
             Parent.Y + Y + ( Height - Font.fType.Height ) div 2,
             PChar( Caption ), Font.Scale, Font.Step, Font.Alpha, Font.Color );

End;

procedure CGUIButton.Process;
Begin
if Mouse_Down( M_LBUTTON ) and PointInRect( mX, mY, Parent.X + X, Parent.Y + Y, Width, Height ) Then
  begin
    Parent.ResetFocus;
    Focused := TRUE;
  end;
inherited;
End;

//----------------------------------------------------------------------------//
//--------------------------  G U I  L A B E L  ------------------------------//
//----------------------------------------------------------------------------//

constructor CGUILabel.Create;
Begin
inherited;
AutoSize  := TRUE;
TextAlign := gaCenter;
End;

procedure CGUILabel.Draw;
  var
    tW, tH : Integer;
Begin

if not ( ( Font.fType <> nil ) and ( Caption <> '' ) ) Then exit;

tW := Text_GetWidth( Font.fType, PChar( Caption ), Font.Scale, Font.Step );
tH := Font.fType.Height;
case TextAlign of
gaLeft   : Text_Draw( Font.fType, Parent.X + X, Parent.Y + Y, PChar( Caption ), Font.Scale, Font.Step, Font.Alpha, Font.Color );
gaRight  : Text_Draw( Font.fType, Parent.X + X + Width - tW, Parent.Y + Y, PChar( Caption ), Font.Scale, Font.Step, Font.Alpha, Font.Color );
gaCenter : Text_Draw( Font.fType, Parent.X + X + ( Width - tW ) div 2, Parent.Y + Y + ( Height - tH ) div 2, PChar( Caption ), Font.Scale, Font.Step, Font.Alpha, Font.Color );
gaTop    : Text_Draw( Font.fType, Parent.X + X + ( Width - tW ) div 2, Parent.Y + Y, PChar( Caption ), Font.Scale, Font.Step, Font.Alpha, Font.Color );
gaBottom : Text_Draw( Font.fType, Parent.X + X + ( Width - tW ) div 2, Parent.Y + Y + Height + tH, PChar( Caption ), Font.Scale, Font.Step, Font.Alpha, Font.Color );
end;

End;

procedure CGUILabel.Process;
Begin
inherited;
if Mouse_Down( M_LBUTTON ) and PointInRect( mX, mY, Parent.X + X, Parent.Y + Y, Width, Height ) Then
  begin
    Parent.ResetFocus;
    Focused := TRUE;
  end;
if AutoSize Then
  begin
    Width  := Text_GetWidth( Font.fType, PChar( Caption ), Font.Scale, Font.Step );
    Height := Font.fType.Height;
  end;

End;

//----------------------------------------------------------------------------//
//--------------------------  G U I  L A B E L  ------------------------------//
//----------------------------------------------------------------------------//

constructor CGUIEdit.Create;
Begin
inherited;
TextAlign   := gaLeft;
Font.Color  := 0;
Color       := $FFFFFF;
BorderColor := 0;
End;

procedure CGUIEdit.Draw;
Begin
INC( TextLine );
if Texture = nil Then
  begin
    Pr2D_Rect( Parent.X + X, Parent.Y + Y, Width, Height, Color, Alpha, PR_FILL );
    Pr2D_Rect( Parent.X + X + 1, Parent.Y + Y + 2, Width - 3, Height - 3, BorderColor, Alpha );
  end else
    SSprite_Draw( Texture, Parent.X + X, Parent.Y + Y, Width, Height, Alpha );

if Focused Then
  begin
    Pr2D_LineWidth( 1 );
    Pr2D_Line( Parent.X + X + 2 + Text_GetWidth( Font.fType, PChar( Caption ), Font.Scale, Font.Step ), Parent.Y + Y + 2,
               Parent.X + X + 2 + Text_GetWidth( Font.fType, PChar( Caption ), Font.Scale, Font.Step ), Parent.Y + Y + 2 + Height - 3,
               BorderColor, TextLine );
  end;

Text_Draw( Font.fType, Parent.X + X + 2, Parent.Y + Y + 2, PChar( Caption ), Font.Scale, Font.Step, Font.Alpha, Font.Color );

End;

procedure CGUIEdit.Process;
Begin
inherited;
if Mouse_Down( M_LBUTTON ) and PointInRect( mX, mY, Parent.X + X, Parent.Y + Y, Width, Height ) Then
  begin
    TextLine := 0;
    Parent.ResetFocus;
    Focused := TRUE;
    Key_MaxReadText( Max );
    Key_BeginReadText( PChar( Caption ) );
  end;
if Focused Then
  Caption := Key_EndReadText;
End;

//----------------------------------------------------------------------------//
//--------------------------  G U I  I M A G E -------------------------------//
//----------------------------------------------------------------------------//

constructor CGUIImage.Create;
Begin
inherited;
AutoSize := TRUE;
End;

procedure CGUIImage.Draw;
Begin

if Texture = nil Then exit;
if not Visible Then exit;
SSprite_Draw( Texture, Parent.X + X, Parent.Y + Y, Width, Height, Alpha );

End;

procedure CGUIImage.Process;
Begin

if Mouse_Down( M_LBUTTON ) and PointInRect( mX, mY, Parent.X + X, Parent.Y + Y, Width, Height ) Then
  begin
    Parent.ResetFocus;
    Focused := TRUE;
  end;
if AutoSize Then
  begin
    Width  := Texture.Width;
    Height := Texture.Height;
  end;

End;

//----------------------------------------------------------------------------//
//--------------------  G U I  P R O G R E S S  B A R  -----------------------//
//----------------------------------------------------------------------------//

constructor CGUIProgressBar.Create;
begin
inherited;
ProgressColor := $00FF00;
end;

procedure CGUIProgressBar.Draw;
  var
    Rect : oeRect;
begin
if not Visible Then exit;

if Texture = nil Then
  begin
    case Status of
    gsDisable: Pr2D_Rect( Parent.X + X, Parent.Y + Y, Width, Height, DisableColor, Alpha, PR_FILL );
    gsNormal:
      begin
        Pr2D_Rect( Parent.X + X, Parent.Y + Y, Width, Height, Color, Alpha, PR_FILL );
        Pr2D_Rect( Parent.X + X, Parent.Y + Y, Width, Height, BorderColor, Alpha );
        if ( Progress > 0 ) and ( Width * ( Progress / MaxValue ) >= 1 ) then
          Pr2D_Rect( Parent.X + X + 1, Parent.Y + Y, M_Round( Progress * ( Width / MaxValue ) ) - 1, Height - 1, ProgressColor, Alpha, PR_FILL );
      end;
    end;
  end else
    begin
      case Status of
      gsDisable: ASprite_Draw( Texture, Parent.X + X, Parent.Y + Y, Width, Height, 1, Alpha );
      gsNormal:
        begin
          ASprite_Draw( Texture, Parent.X + X, Parent.Y + Y, Width, Height, 1, Alpha );
          Rect.X := 0;
          Rect.Y := Texture.Height div 2;
          Rect.Height := Rect.Y;
          Rect.Width := M_Round( Progress * ( Texture.Width / MaxValue ) );
          if ( Progress > 0 ) and ( Width * ( Progress / MaxValue ) >= 1 ) then
            CSprite_Draw( Texture, Parent.X + X, Parent.Y + Y, M_Round( Progress * ( Width / MaxValue ) ), Height, @Rect, Alpha );
        end;
      end;
    end;

if ( Font.fType <> nil ) and ( Caption <> '' ) Then
  Text_Draw( Font.fType,
             Parent.X + X + ( Width - Text_GetWidth( Font.fType, PChar( Caption ), Font.Scale, Font.Step ) ) div 2,
             Parent.Y + Y + ( Height - Font.fType.Height ) div 2,
             PChar( Caption ), Font.Scale, Font.Step, Font.Alpha, Font.Color );
end;

procedure CGUIProgressBar.Process;
begin
inherited;
if Mouse_Down( M_LBUTTON ) and PointInRect( mX, mY, Parent.X + X, Parent.Y + Y, Width, Height ) Then
  begin
    Parent.ResetFocus;
    Focused := TRUE;
  end;
if Progress > MaxValue then
  Progress := MaxValue;
end;

//----------------------------------------------------------------------------//
//-------------------------  G U I  B U T T O N  -----------------------------//
//----------------------------------------------------------------------------//

constructor CGUICheckBox.Create;
Begin
inherited;
Color := $888888;
IsUp  := TRUE;
End;

procedure CGUICheckBox.Draw;
Begin

if not Visible Then exit;

if Texture = nil Then
  begin
    if Status = gsDisable then
      begin
        Pr2D_Rect( Parent.X + X, Parent.Y + Y, Width, Height, DisableColor, Alpha, PR_FILL );
        Pr2D_Rect( Parent.X + X, Parent.Y + Y, Width, Height, BorderColor, Alpha );
      end else
        case Checked of
        FALSE :
          begin
            Pr2D_Rect( Parent.X + X, Parent.Y + Y, Width, Height, Color, Alpha, PR_FILL );
            Pr2D_Rect( Parent.X + X, Parent.Y + Y, Width, Height, BorderColor, Alpha );
          end;
        TRUE  :
          begin
            Pr2D_Rect( Parent.X + X, Parent.Y + Y, Width, Height, Color, Alpha, PR_FILL );
            Pr2D_Rect( Parent.X + X, Parent.Y + Y, Width, Height, BorderColor, Alpha );
            Pr2D_LineWidth( 1 );
            Pr2D_Line( Parent.X + X, Parent.Y + Y - 1, Parent.X + X + Width + 1, Parent.Y + Y + Height, BorderColor, Alpha );
            Pr2D_Line( Parent.X + X + Width, Parent.Y + Y, Parent.X + X, Parent.Y + Y + Height, BorderColor, Alpha );
          end;
      end;
  end else
    if Status = gsDisable then
      ASprite_Draw( Texture, Parent.X + X, Parent.Y + Y, Width, Height, 1, Alpha )
    else
      case Checked of
      FALSE : ASprite_Draw( Texture, Parent.X + X, Parent.Y + Y, Width, Height, 2, Alpha );
      TRUE  : ASprite_Draw( Texture, Parent.X + X, Parent.Y + Y, Width, Height, 3, Alpha );
      end;

if ( Font.fType <> nil ) and ( Caption <> '' ) Then
  Text_Draw( Font.fType,
             Parent.X + X + Width + 2,
             Parent.Y + Y + ( Height - Font.fType.Height ) div 2,
             PChar( Caption ), Font.Scale, Font.Step, Font.Alpha, Font.Color );

End;

procedure CGUICheckBox.Process;
Begin
inherited;
if Mouse_Down( M_LBUTTON ) and PointInRect( mX, mY, Parent.X + X, Parent.Y + Y, Width, Height ) Then
  begin
    Parent.ResetFocus;
    Focused := TRUE;
    if IsUp then
      Checked := not Checked;
    IsUp := FALSE;    
  end;
if Mouse_Press( M_LBUTTON ) then  
  IsUp := TRUE;
End;

//----------------------------------------------------------------------------//
//-------------------------  G U I  W I N D O W  -----------------------------//
//----------------------------------------------------------------------------//

procedure CGUIWindow.qSortN;
  var
    Lo, Hi, Mid, T: Integer;
begin

Lo := iLo;
Hi := iHi;
Mid := eList[ eDraw[ ( Lo + Hi ) shr 1 ] ].Z;

repeat
  while eList[ eDraw[ Lo ] ].Z > Mid do INC( Lo );
  while eList[ eDraw[ Hi ] ].Z < Mid do DEC( Hi );
  if Lo <= Hi then
    begin
      T              := eDraw[ Lo ];
      eDraw[ Lo ] := eDraw[ Hi ];
      eDraw[ Hi ] := T;
      INC( Lo );
      DEC( Hi );
    end;
until Lo > Hi;

if Hi > iLo Then qSortN( iLo, Hi );
if Lo < iHi Then qSortN( Lo, iHi );

end;

procedure CGUIWindow.Process;
  var
    i    : Integer;
    CanM : Boolean;
Begin

if not Visible Then exit;

if Mouse_Down( M_LBUTTON ) and PointInRect( mX, mY, X + X, Y + Y, Width, Height ) Then Focused := TRUE;

i := 0;

while i <= eCount - 1 do
  begin
    if eList[ i ].Kill Then
      begin
        DelElement( eList[ i ].ID );
        DEC( i );
      end else
        if eList[ eDraw[ i ] ].Visible Then
          eList[ i ].Process;
    INC( i );
  end;

if not CanMove then exit;

CanM := TRUE;
if CaptionHeight = Height Then
  for i := 0 to eCount - 1 do
    if PointInRect( mX, mY, eList[ i ].X + X - 2, eList[ i ].Y + Y - 2,
                            eList[ i ].Width + 2, eList[ i ].Height + 2 ) Then
      CanM := FALSE;

if not ( not PointInRect( mX, mY, X, Y, Width, CaptionHeight ) and ( not IsMoved ) ) and CanM Then
  if Mouse_Down( M_LBUTTON ) Then
    begin
      if IsMoved Then
        begin
          X := mX + MoveX;
          Y := mY + MoveY;
        end else
          IsMoved := TRUE;
    end else
      begin
        MoveX := 0;
        MoveY := 0;
        IsMoved := FALSE;
      end;
MoveX := X - mX;
MoveY := Y - mY;
End;

procedure CGUIWindow.Draw;
  var
    i : Integer;
Begin

if not Visible Then exit;

if Texture = nil Then
  begin
    Pr2D_Rect( X, Y, Width, Height, Color, Alpha, PR_FILL );
    if Height <> CaptionHeight then
      Pr2D_Rect( X, Y, Width, CaptionHeight, BorderColor, Alpha, PR_FILL );
    Pr2D_Rect( X, Y, Width - 1, Height, BorderColor, Alpha );
  end else
    SSprite_Draw( Texture, X, Y, Width, Height, Alpha );

if eCount > 1 Then
  qSortN( 0, eCount - 1 );

for i := 0 to eCount - 1 do
  if eList[ eDraw[ i ] ].Visible Then
    eList[ eDraw[ i ] ].Draw;

End;

procedure CGUIWindow.ResetFocus;
  var
    i : Integer;
Begin

for i := 0 to eCount - 1 do
  begin
    eList[ i ].Focused := FALSE;
    if eList[ i ].Status <> gsDisable then
      eList[ i ].Status := gsNormal;
  end;

End;

procedure CGUIWindow.DelElement;
  var
    i : Integer;
Begin
if eCount = 0 Then exit;
DEC( eCount );
eList[ ID ].Freeing;
eList[ ID ].Free;
for i := ID to eCount - 1 do
  begin
    eList[ i ]    := eList[ i + 1 ];
    eList[ i ].ID := eList[ i ].ID - 1;
  end;
SetLength( eList, eCount );

SetLength( eDraw, eCount );
for i := 0 to eCount - 1 do
  eDraw[ i ] := eList[ i ].ID;
End;

function CGUIWindow.AddButton;
Begin

INC( eCount );
INC( LastZ );

SetLength( eList, eCount );
SetLength( eDraw, eCount );

eDraw[ eCount - 1 ] := eCount - 1;

eList[ eCount - 1 ]         := CGUIButton.Create;
eList[ eCount - 1 ].ID      := eCount - 1;
eList[ eCount - 1 ].Texture := Texture;
eList[ eCount - 1 ].X       := X;
eList[ eCount - 1 ].Y       := Y;
eList[ eCount - 1 ].Z       := LastZ;
eList[ eCount - 1 ].Width   := Width;
eList[ eCount - 1 ].Height  := Height;
eList[ eCount - 1 ].Alpha   := Alpha;
eList[ eCount - 1 ].Parent  := Self;
eList[ eCount - 1 ].Caption := Caption;
eList[ eCount - 1 ].Font.fType := Font;
if OnClick <> nil Then
  eList[ eCount - 1 ].POnMouseUp := OnClick;

Result := eCount - 1;

End;

function CGUIWindow.AddLabel;
Begin

INC( eCount );
INC( LastZ );

SetLength( eList, eCount );
SetLength( eDraw, eCount );

eDraw[ eCount - 1 ] := eCount - 1;

eList[ eCount - 1 ]         := CGUILabel.Create;
eList[ eCount - 1 ].ID      := eCount - 1;
eList[ eCount - 1 ].X       := X;
eList[ eCount - 1 ].Y       := Y;
eList[ eCount - 1 ].Z       := LastZ;
eList[ eCount - 1 ].Alpha   := Alpha;
eList[ eCount - 1 ].Parent  := Self;
eList[ eCount - 1 ].Caption := Caption;
eList[ eCount - 1 ].Font.fType := Font;
eList[ eCount - 1 ].Process;

Result := eCount - 1;

End;

function CGUIWindow.AddEdit;
Begin

INC( eCount );
INC( LastZ );

SetLength( eList, eCount );
SetLength( eDraw, eCount );

eDraw[ eCount - 1 ] := eCount - 1;

eList[ eCount - 1 ]         := CGUIEdit.Create;
eList[ eCount - 1 ].ID      := eCount - 1;
eList[ eCount - 1 ].Texture := Texture;
eList[ eCount - 1 ].X       := X;
eList[ eCount - 1 ].Y       := Y;
eList[ eCount - 1 ].Z       := LastZ;
eList[ eCount - 1 ].Width   := Width;
eList[ eCount - 1 ].Height  := Height;
eList[ eCount - 1 ].Alpha   := Alpha;
eList[ eCount - 1 ].Parent  := Self;
eList[ eCount - 1 ].Caption := Caption;
eList[ eCount - 1 ].Font.fType := Font;
eList[ eCount - 1 ].Process;
( eList[ eCount - 1 ] as CGUIEdit ).Max := Max;

Result := eCount - 1;

End;

function CGUIWindow.AddImage;
Begin

INC( eCount );
INC( LastZ );

SetLength( eList, eCount );
SetLength( eDraw, eCount );

eDraw[ eCount - 1 ] := eCount - 1;

eList[ eCount - 1 ]         := CGUIImage.Create;
eList[ eCount - 1 ].ID      := eCount - 1;
eList[ eCount - 1 ].Texture := Texture;
eList[ eCount - 1 ].X       := X;
eList[ eCount - 1 ].Y       := Y;
eList[ eCount - 1 ].Z       := LastZ;
eList[ eCount - 1 ].Alpha   := Alpha;
eList[ eCount - 1 ].Parent  := Self;
eList[ eCount - 1 ].Process;

Result := eCount - 1;

End;

function CGUIWindow.AddCheckBox;
Begin

INC( eCount );
INC( LastZ );

SetLength( eList, eCount );
SetLength( eDraw, eCount );

eDraw[ eCount - 1 ] := eCount - 1;

eList[ eCount - 1 ]         := CGUICheckBox.Create;
eList[ eCount - 1 ].ID      := eCount - 1;
eList[ eCount - 1 ].Texture := Texture;
eList[ eCount - 1 ].X       := X;
eList[ eCount - 1 ].Y       := Y;
eList[ eCount - 1 ].Z       := LastZ;
eList[ eCount - 1 ].Width   := Width;
eList[ eCount - 1 ].Height  := Height;
eList[ eCount - 1 ].Alpha   := Alpha;
eList[ eCount - 1 ].Parent  := Self;
eList[ eCount - 1 ].Caption := Caption;
eList[ eCount - 1 ].Font.fType := Font;
( eList[ eCount - 1 ] as CGUICheckBox ).Checked := Checked;

Result := eCount - 1;

End;

function CGUIWindow.AddProgressBar;
Begin

INC( eCount );
INC( LastZ );

SetLength( eList, eCount );
SetLength( eDraw, eCount );

eDraw[ eCount - 1 ] := eCount - 1;

eList[ eCount - 1 ]         := CGUIProgressBar.Create;
eList[ eCount - 1 ].ID      := eCount - 1;
eList[ eCount - 1 ].Texture := Texture;
eList[ eCount - 1 ].X       := X;
eList[ eCount - 1 ].Y       := Y;
eList[ eCount - 1 ].Z       := LastZ;
eList[ eCount - 1 ].Width   := Width;
eList[ eCount - 1 ].Height  := Height;
eList[ eCount - 1 ].Alpha   := Alpha;
( eList[ eCount - 1 ] as CGUIProgressBar ).MaxValue := MaxValue;
eList[ eCount - 1 ].Parent  := Self;

Result := eCount - 1;

End;

//----------------------------------------------------------------------------//
//-------------------------  G U I  E N G I N E  -----------------------------//
//----------------------------------------------------------------------------//

constructor CGUIEngine.Create;
Begin
inherited;
WndActive := 0;
End;

procedure CGUIEngine.Draw;
Begin
inherited;

if Cursor.Texture <> nil Then
  SSprite_Draw( Cursor.Texture,
                Cursor.X, Cursor.Y,
                Cursor.Texture.Width, Cursor.Texture.Height );
End;

procedure CGUIEngine.Process;
  var
    i, j, z : Integer;
Begin

z := 0;
Cursor.X := Mouse_X;
Cursor.Y := Mouse_Y;
mX       := Cursor.X;
mY       := Cursor.Y;

if TabWindows Then
  begin
    for i := Count - 1 downto 0 do
      if ( List[ i ] as CGUIWindow ).Visible then
      if PointInRect( mX, mY,
                      List[ DrawList[ i ] ].X, List[ DrawList[ i ] ].Y,
                      List[ DrawList[ i ] ].Width, List[ DrawList[ i ] ].Height ) and
         Mouse_Click( M_LBUTTON ) Then
        begin
          List[ DrawList[ i ] ].Z := -1;
          WndActive               := i;
          for j := Count - 1 downto 0 do
            if List[ DrawList[ j ] ].Z <> -1 Then
              begin
                List[ DrawList[ j ] ].Z := z;
                ( List[ DrawList[ j ] ] as CGUIWindow ).ResetFocus;
                INC( z );
              end;
          break;
        end;
    for i := Count - 1 downto 0 do
      INC( List[ DrawList[ i ] ].Z );

    qSortN( 0, Count - 1 );
    List[ DrawList[ Count - 1 ] ].Process;
  end else inherited;

if Mouse_Click( M_LBUTTON ) Then;
if Mouse_Click( M_MBUTTON ) Then;
if Mouse_Click( M_RBUTTON ) Then;

if Mouse_Press( M_LBUTTON ) Then;
if Mouse_Press( M_MBUTTON ) Then;
if Mouse_Press( M_RBUTTON ) Then;
End;

function CGUIEngine.AddWindow;
  var
    i : Integer;
Begin

INC( LastZ );

i := AddNew;
List[ i ] := CGUIWindow.Create;
List[ i ].ID := i;

List[ i ].Texture := Texture;
List[ i ].X       := X;
List[ i ].Y       := Y;
List[ i ].Z       := LastZ;
List[ i ].Width   := Width;
List[ i ].Height  := Height;
List[ i ].Alpha   := Alpha;
( List[ i ] as CGUIWindow ).CaptionHeight := Height;

Result            := i; 

End;

procedure CGUIEngine.DelWindow;
Begin
Del( ID );
End;

end.
