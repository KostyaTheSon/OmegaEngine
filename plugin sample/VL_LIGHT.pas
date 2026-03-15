////////////////////////////
// V E R T E X  L I G H T //
// OMEGA ENGINE PLUGIN    //
////////////////////////////
unit VL_LIGHT;

interface
uses OpenGL, OMEGA;

procedure VL_ClearLight;
procedure VL_ProcLight( ID : Integer );
procedure VL_DrawLight;

const
  LSX = 49;
  LSY = 39;

  _1div255 = 0.00392;

var
  BlocksArrayL : array[ 0..LSX, 0..LSY ] of array[ 0..3 ] of Byte;

  //Параметры освещения
  L_SizeX    : Integer = LSX; //Количество кубиков по оси X
  L_SizeY    : Integer = LSY; //Количество кубиков по оси Y
  L_RectSize : Integer = 16;  //Размер одного кубика

implementation
uses VL_MAIN, VL_MANAGER;

procedure VL_ClearLight;
  var
    i, j : Integer;
Begin
for i := 0 to L_SizeX do
  for j := 0 to L_SizeY do
    begin
      BlocksArrayL[ i, j ][ 0 ] := 225;
      BlocksArrayL[ i, j ][ 1 ] := 225;
      BlocksArrayL[ i, j ][ 2 ] := 225;
      BlocksArrayL[ i, j ][ 3 ] := 225;
    end;
End;

procedure VL_ProcLight( ID : Integer );
  var
    Circ  : oeCircle;
    Power : Integer;

    i, j : Integer;
    iFrom, iTo,
    jFrom, jTo : Integer;
Begin

Circ  := LightsArray[ ID ].Circ;
Power := LightsArray[ ID ].Power;

iFrom := ( Circ.cX - Circ.Radius ) div L_RectSize - 1;
if iFrom < 0 Then iFrom := 0 else
if iFrom > L_SizeX Then iFrom := L_SizeX;

iTo   := ( Circ.cX + Circ.Radius ) div L_RectSize;
if iTo < 0 Then iTo := 0 else
if iTo > L_SizeX Then iTo := L_SizeX;

jFrom := ( Circ.cY - Circ.Radius ) div L_Rectsize - 1;
if jFrom < 0 Then jFrom := 0 else
if jFrom > L_SizeY Then jFrom := L_SizeY;

jTo   := ( Circ.cY + Circ.Radius ) div L_Rectsize;
if jTo < 0 Then jTo := 0 else
if jTo > L_SizeY Then jTo := L_SizeY;

//Обработка источника света
for i := iFrom to iTo do
  for j := jFrom to jTo do
    begin
      if Col_PointInCircle( i * L_RectSize + Cam2D^.X, j * L_RectSize + Cam2D^.Y, @Circ ) Then
        begin
          if BlocksArrayL[ i, j ][ 0 ] >= Power Then
          BlocksArrayL[ i, j ][ 0 ] := BlocksArrayL[ i, j ][ 0 ] - Power else
          BlocksArrayL[ i, j ][ 0 ] := 0;
        end;
      if Col_PointInCircle( i * L_RectSize + L_RectSize + Cam2D^.X, j * L_RectSize + Cam2D^.Y, @Circ ) Then
        begin
          if BlocksArrayL[ i, j ][ 1 ] >= Power then
          BlocksArrayL[ i, j ][ 1 ] := BlocksArrayL[ i, j ][ 1 ] - Power else
          BlocksArrayL[ i, j ][ 1 ] := 0;
        end;
      if Col_PointInCircle( i * L_RectSize + L_RectSize + Cam2D^.X, j * L_RectSize + L_RectSize + Cam2D^.Y, @Circ ) Then
        begin
          if BlocksArrayL[ i, j ][ 2 ] >= Power Then
          BlocksArrayL[ i, j ][ 2 ] := BlocksArrayL[ i, j ][ 2 ] - Power else
          BlocksArrayL[ i, j ][ 2 ] := 0;
        end;
      if Col_PointInCircle( i * L_RectSize + Cam2D^.X, j * L_RectSize + L_RectSize + Cam2D^.Y, @Circ ) Then
        begin
          if BlocksArrayL[ i, j ][ 3 ] >= Power Then
          BlocksArrayL[ i, j ][ 3 ] := BlocksArrayL[ i, j ][ 3 ] - Power else
          BlocksArrayL[ i, j ][ 3 ] := 0;
        end;
    end;
End;

procedure VL_DrawLight;
  var
    i, j : Integer;
Begin
glEnable( GL_BLEND );
glPushMatrix;
for i := 0 to L_SizeX do
  for j := 0 to L_SizeY do
    begin
        glBegin( GL_QUADS );
          glColor4f ( 0, 0, 0, BlocksArrayL[ i, j ][ 0 ] * _1div255 );
          glVertex2f( i * L_RectSize,              j * L_RectSize );

          glColor4f ( 0, 0, 0, BlocksArrayL[ i, j ][ 1 ] * _1div255 );
          glVertex2f( i * L_RectSize + L_RectSize, j * L_RectSize );

          glColor4f ( 0, 0, 0, BlocksArrayL[ i, j ][ 2 ] * _1div255 );
          glVertex2f( i * L_RectSize + L_RectSize, j * L_RectSize + L_RectSize );

          glColor4f ( 0, 0, 0, BlocksArrayL[ i, j ][ 3 ] * _1div255 );
          glVertex2f( i * L_RectSize,              j * L_RectSize +L_RectSize );
        glEnd;
    end;
glPopMatrix;
glDisable( GL_BLEND );
End;

end.
