////////////////////////////
// V E R T E X  L I G H T //
// OMEGA ENGINE PLUGIN    //
////////////////////////////
unit VL_MANAGER;

interface
uses OMEGA;

//Добавить новый источник света
function  VL_AddLight( X, Y, Radius, Power : Integer ) : Integer;
//Удалить источник света
procedure VL_FreeLight( ID : Integer );

//Переместить источник света
procedure VL_MoveLight( ID, X, Y : Integer );
//Изменить размер источника света
procedure VL_ResizeLight( ID, Radius : Integer );
//Изменить силу источника света
procedure VL_SetPower( ID, Power : Integer );

//Так как можно сделать разные источники света то лучше иметь отдельную запись
//А в будущем добавить конусные и прямоугольние источники осещения
type
  TLight = record
    Active : Boolean; //Активный ли, т.е. если нет то его можно заменить новым

    Circ : oeCircle;  //Круговой источник света

    Power : Integer;  //Сила освещения
end;

var
  LightsCount : Integer = 0;

  LightsArray : array of TLight;

implementation

function VL_AddLight( X, Y, Radius, Power : Integer ) : Integer;
  var
    i : Integer;
Begin

for i := 0 to LightsCount - 1 do
  if not LightsArray[ i ].Active Then
    begin
      LightsArray[ i ].Active      := TRUE;
      LightsArray[ i ].Power       := Power;
      LightsArray[ i ].Circ.cX     := X;
      LightsArray[ i ].Circ.cY     := Y;
      LightsArray[ i ].Circ.Radius := Radius;
      Result := i;
      exit;
    end;

INC( LightsCount );
SetLength( LightsArray, LightsCount );

LightsArray[ LightsCount - 1 ].Active      := TRUE;
LightsArray[ LightsCount - 1 ].Power       := Power;
LightsArray[ LightsCount - 1 ].Circ.cX     := X;
LightsArray[ LightsCount - 1 ].Circ.cY     := Y;
LightsArray[ LightsCount - 1 ].Circ.Radius := Radius;
Result := LightsCount - 1;
End;

procedure VL_FreeLight( ID : Integer );
Begin

LightsArray[ ID ].Active := FALSE;

End;

procedure VL_MoveLight( ID, X, Y : Integer );
Begin

LightsArray[ ID ].Circ.cX := X;
LightsArray[ ID ].Circ.cY := Y;

End;

procedure VL_ResizeLight( ID, Radius : Integer );
Begin

LightsArray[ ID ].Circ.Radius := Radius;

End;

procedure VL_SetPower( ID, Power : Integer );
Begin

LightsArray[ ID ].Power := Power;

End;

end.
