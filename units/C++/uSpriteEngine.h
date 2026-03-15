#ifndef _uSPRITEENGINE_
#define _uSPRITEENGINE_

// CSprite Class

class CSprite
{
public:
  int      ID;
  int      X, Y, Z;
  int      Width, Height;
  unsigned char Alpha;
  int      Angle;
  int      FX;
  bool     Animated;
  float    AnimSpeed;
  float    Frame;
  bool     Kill;
  PTexture Texture;

  CSprite();
  virtual void Freeing(void);

  virtual void Draw(void);
  virtual void Process(void);
};

class CSpriteEngine
{
public:
  CSprite** List;
  int*      DrawList;
  int       Count;

  bool InvertSort;

  int  AddNew(void);
  int  CreateNew(void);
  void Del( int ID );

  void qSortN( int iLo, int iHi );
  void qSortI( int iLo, int iHi );

  void Draw(void);
  void Process(void);
};

#endif