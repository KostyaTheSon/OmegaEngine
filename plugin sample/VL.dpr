////////////////////////////
// V E R T E X  L I G H T //
// OMEGA ENGINE PLUGIN    //
////////////////////////////
library VL;

{$R VL.res}

uses
  OMEGA in '..\headers\Delphi\OMEGA.pas',
  PLUGIN in '..\headers\Delphi\PLUGIN.pas'
  PLUGIN,
  VL_MAIN in 'VL_MAIN.pas',
  VL_LIGHT in 'VL_LIGHT.pas',
  VL_MANAGER in 'VL_MANAGER.pas';

//Экспортируем функции плагина
exports
  VL_Init,
  VL_Draw,

  VL_AddLight,
  VL_FreeLight,

  VL_MoveLight,
  VL_ResizeLight,
  VL_SetPower
  ;

begin
end.
 