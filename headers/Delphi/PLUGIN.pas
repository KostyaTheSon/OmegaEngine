unit PLUGIN;

interface
uses OMEGA;

const
  gENGINE_HWND   = $000000; //PDWORD
  gENGINE_DC     = $000001; //PDWORD
  gENGINE_GLRC   = $000002; //PDWORD

  gOGL_WIDTH     = $000003; //PInteger
  gOGL_HEIGHT    = $000004; //PInteger

  gCURRENT_CAM2D = $000005; //^PCamera2D
  
function P_GetParams( What : Integer ) : Pointer; external OMEGA_DLL;

function Tex_PostProcess( var pData        : Pointer;
                          var Info         : TTexture;
                          TransparentColor : Integer ) : PTexture; stdcall; external OMEGA_DLL;

//----------------------------------------------------------------------------//
                                 IMPLEMENTATION
//----------------------------------------------------------------------------//

end.
