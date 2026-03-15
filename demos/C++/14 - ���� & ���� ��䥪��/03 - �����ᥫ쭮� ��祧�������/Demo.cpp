////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                           O M E G A  E N G I N E                           //
//                                  D E M O                                   //
//                                                                            //
//    Пример демонстрирующий простенький эффект который можно реализовать     //
//  используя лишь один режим блендинга и рендер в текстуру                   //
//                                                                            //
//  (C)2006 Andru 'aka' KEMKA ANDREY.                                         //
//  web  : HTTP://isada.mirgames.ru                                           //
//  eMail: Andru_@list.ru                                                     //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

#include "..\..\..\..\headers\C++\OMEGA_code.cpp"
#include "..\..\..\..\headers\C++\OMEGA_functions.h" // для функций с параметрами поумолчанию

PTimer MyTimer;

// Переменные, которые будут хранить идентификаторы текстур
PTexture Texture;
PTexture Effect;

void Load()
{
}

void Init()
{
// Загружаем текстуру
Texture = Tex_LoadFromFile( "..\\..\\..\\Media\\Logo.gif", 0xFFFFFF, TEX_DEFAULT_2D );


// Создаем пустую текстуру 512x512
Effect = Tex_CreateZero( 512, 512, 0 );
// Рисуем на ней белый прямоугольник
Tex_BeginRenderIn( Effect, true, true );
Pr2D_Rect( 0, 0, 512, 512, 0xFFFFFF, 255, PR_FILL );
Tex_EndRenderIn();
}

void Draw()
{
//Рисуем тайлы
STile_Draw( Texture, 0, 0, 128, 128, 7, 6, 255, FX_DEFAULT );

// Указываем блендинг как маску
FX_SetBlendMode( FX_BLEND_MASK );
// Рисуем нашу текстуру эффекта, где все черные области делают изображение "позади"
// невидимым... покрытым черным цветом
SSprite_Draw( Effect, 0, 0, 800, 600 );
// Возвращаем нормлаьный бленд
FX_SetBlendMode( FX_BLEND_NORMAL );
}

void Quit()
{
}

void Timer1()
{
int i;
// Рисуем случайным образом на текстуе эффекта черные пикселы
Tex_BeginRenderIn( Effect, true, true );
for ( i = 0; i <= 1000; i++ )
  Pr2D_Pixel( rand()%512, rand()%512, 0 );
Tex_EndRenderIn();

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

OE_SetScreenOptions( 800, 600, 32, 0, false, false );

//Запускаем движок
OE_Init();

}

