////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                           O M E G A  E N G I N E                           //
//                                  D E M O                                   //
//                                                                            //
//    Демонстрируется как использовать 2D-камеры                              //
//                                                                            //
//  (C)2006 Andru 'aka' KEMKA ANDREY.                                         //
//  web  : HTTP://isada.mirgames.ru                                           //
//  eMail: Andru_@list.ru                                                     //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

#include "..\..\..\headers\C++\OMEGA_code.cpp" // подключаем хедер движка
#include "..\..\..\headers\C++\OMEGA_functions.h"
#include <string>


PTimer MyTimer;

// Переменная, которая будет хранить идентификатор текстуры
PTexture Texture;

// Шрифт
PFont2D Font;

//По сути указатель на текущую 2D-камеру которую использует движок
PCamera2D Camera;

void Load()
{
}

void Init()
{

// Загружаем текстуру Logo
Texture = Tex_LoadFromFile( "..\\..\\Media\\Logo.gif", 0xFFFFFF, TEX_DEFAULT_2D );

// Загружаем шрифт
Font = Text_LoadFontFromFile( "..\\..\\Media\\Font.gif",
                              "..\\..\\Media\\FontInfo.ofi" );

// Создаем камеру
Camera = Cam2D_Create();
Cam2D_Set( Camera );
}

void Draw()
{
char buffer[256];

//Рисуем уже Logo в нулевых координатах, так как все остальное делает камера
SSprite_Draw( Texture, 0, 0, 128, 128, 255, 0, FX_DEFAULT );

sprintf( buffer, "FPS: %d", OE_GetFPS() );
// Отключаем камеру на момент вывода текста
Camera->Active = false;
Text_Draw( Font, 0, 0, buffer );
Camera->Active = true;

}

void Quit()
{
}

void Timer1()
{

// Двигаем камеру за грызуном, только инвертируем координаты чтоб левый угол
// спрайта "весел" на грызуне
Camera->X = -Mouse_X();
Camera->Y = -Mouse_Y();

// По нажатию Escape завершаем работу
if ( Key_Down( K_ESCAPE ) ) OE_Quit();
}

int main()
{

LoadOMEGA();

// Создаем таймер
MyTimer = Timer_Create( (void*)Timer1, 10, 0 );

// Назначаем "системные" процедуры
OE_RegProcedure( SYS_FASTINIT, (void*)Load );
OE_RegProcedure( SYS_INIT,     (void*)Init );
OE_RegProcedure( SYS_DRAW,     (void*)Draw );
OE_RegProcedure( SYS_QUIT,     (void*)Quit );

OE_SetScreenOptions( 800, 600, 32, 0, true, false );

//Запускаем движок
OE_Init();

}

