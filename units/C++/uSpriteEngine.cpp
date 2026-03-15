#include "OMEGA_functions.h"
#include "uSpriteEngine.h"
#include "stdlib.h"

//----------------------------------------------------------------------------//
//------------------------------  S P R I T E  -------------------------------//
//----------------------------------------------------------------------------//

CSprite::CSprite()
{
X         = 0;
Y         = 0;
Z         = 0;
Width     = 0;
Height    = 0;
Alpha     = 255;
Angle     = 0;
Animated  = false;
AnimSpeed = 0;
FX        = FX_DEFAULT;
Frame     = 1;
Kill      = false;
Texture   = NULL;
}

void CSprite::Freeing()
{
}

void CSprite::Draw(void)
{
if ( Texure == NULL ) return;
if ( Animated )
  ASprite_Draw( Texture, X, Y, Width, Height, M_Round( Frame ), Alpha, Angle, FX );
else
  SSprite_Draw( Texture, X, Y, Width, Height, Alpha, Angle, FX );
}

void CSprite::Process(void)
{
if ( Animated )
  {
    Frame = Frame + AnimSpeed;
    if ( Frame - 1 > (*Texture).FramesX * (*Texture).FramesY )
      Frame = 1;
  }
}

//----------------------------------------------------------------------------//
//------------------------  S P R I T E  E N G I N E  ------------------------//
//----------------------------------------------------------------------------//

int CSpriteEngine::CreateNew(void)
{
Count++;

List     = (CSprite**)realloc( List,     sizeof(CSprite) * Count );
DrawList = (int*)     realloc( DrawList, sizeof(int)     * Count );

List[ Count - 1 ] = new CSprite;

List[ Count - 1 ]->ID  = Count - 1;
DrawList[ Count - 1 ]  = Count - 1;
return Count - 1;
}

int CSpriteEngine::AddNew(void)
{
Count++;

List     = (CSprite**)realloc( List,     sizeof(CSprite) * Count );
DrawList = (int*)     realloc( DrawList, sizeof(int)     * Count );

DrawList[ Count - 1 ] = Count - 1;

return Count - 1;
}

void CSpriteEngine::Del( int ID )
{
int i;

if ( Count == 0 ) return;
Count--;
List[ ID ]->Freeing();
List[ ID ]->~CSprite();
for ( i = ID; i <= Count - 1; i++ )
  {
    (*List[ i ])  = (*List[ i + 1 ]);
    List[ i ]->ID = (*List[ i ]).ID - 1;
  }
List = (CSprite**)realloc( List, sizeof(CSprite) * Count );

DrawList = (int*)realloc( DrawList, sizeof(int) * Count );
for ( i = 0; i <= Count - 1; i++ )
  DrawList[ i ] = List[ i ]->ID;
}

void CSpriteEngine::qSortN( int iLo, int iHi )
{    
int Lo, Hi, Mid, T;

Lo = iLo;
Hi = iHi;
Mid = List[ DrawList[ ( Lo + Hi ) >> 1 ] ]->Z;

do
{
  while ( List[ DrawList[ Lo ] ]->Z > Mid ) Lo++;
  while ( List[ DrawList[ Hi ] ]->Z < Mid ) Hi--;
  if ( Lo <= Hi )
    {
      T              = DrawList[ Lo ];
      DrawList[ Lo ] = DrawList[ Hi ];
      DrawList[ Hi ] = T;
      Lo++;
      Hi--;
    }
}
while ( Lo <= Hi );

if ( Hi > iLo ) qSortN( iLo, Hi );
if ( Lo < iHi ) qSortN( Lo, iHi );

}

void CSpriteEngine::qSortI( int iLo, int iHi )
{    
int Lo, Hi, Mid, T;

Lo = iLo;
Hi = iHi;
Mid = List[ DrawList[ ( Lo + Hi ) >> 1 ] ]->Z;

do
{
  while ( List[ DrawList[ Lo ] ]->Z < Mid ) Lo++;
  while ( List[ DrawList[ Hi ] ]->Z > Mid ) Hi--;
  if ( Lo <= Hi )
    {
      T              = DrawList[ Lo ];
      DrawList[ Lo ] = DrawList[ Hi ];
      DrawList[ Hi ] = T;
      Lo++;
      Hi--;
    }
}
while ( Lo <= Hi );

if ( Hi > iLo ) qSortI( iLo, Hi );
if ( Lo < iHi ) qSortI( Lo, iHi );

}

void CSpriteEngine::Draw(void)
{
if ( Count > 1 )
if ( InvertSort )
  qSortI( 0, Count - 1 );
else
  qSortN( 0, Count - 1 );

int i;
for ( i = 0; i <= Count - 1; i++ )
  List[ DrawList[ i ] ]->Draw();
}

void CSpriteEngine::Process(void)
{
int i;
i = 0;
while ( i <= Count - 1 )
  {
    if ( List[ i ]->Kill )
      {
        Del( List[ i ]->ID );
        i--;
      } else
        List[ i ]->Process();
    i++;
  }
}
