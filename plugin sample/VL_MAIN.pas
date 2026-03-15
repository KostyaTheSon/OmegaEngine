////////////////////////////
// V E R T E X  L I G H T //
// OMEGA ENGINE PLUGIN    //
////////////////////////////
unit VL_MAIN;

interface
uses OMEGA, PLUGIN;

//Процедура инициализации которую должен будет вызвать пользователь
procedure VL_Init;
//Процедура отрисовки плагина де будет проводится отрисовка вертексного освещения
procedure VL_Draw;
//Процедура обработки "источников" света
procedure VL_Proc;

var
  Timer : PTimer; // Таймер плагина

  Cam2D : ^PCamera2D; // Ссылка на текущую камеру пользователя

  gl_Width, gl_Height : PInteger; // Размеры области вывода OpenGL

implementation
uses VL_LIGHT, VL_MANAGER;

procedure VL_Init;
Begin

//Получаем идентификатор
Timer := Timer_Create( @VL_Proc, 16, 0 );

//Получим ссылки на параметры движковой камеры
Cam2D := P_GetParams( gCURRENT_CAM2D );

//Получим размеры области вывода изображения
gl_Width  := P_GetParams( gOGL_WIDTH );
gl_Height := P_GetParams( gOGL_HEIGHT );

//Для того чтоб "свет" рисовался независимо от разрешения экрана устанавливаем
//размер одного блока освещения
L_RectSize := M_Round( gl_Width^ / L_SizeX );

End;

procedure VL_Draw;
Begin

//Рисуем "освещение"
VL_DrawLight;

End;

procedure VL_Proc;
  var
    i : Integer;
Begin

//Очищаем предыдущее состояние "света"
VL_ClearLight;

//Просчитываем новое
if LightsCount <= 0 Then exit;
for i := 0 to LightsCount - 1 do
  if LightsArray[ i ].Active Then
    VL_ProcLight( i );

End;

end.
