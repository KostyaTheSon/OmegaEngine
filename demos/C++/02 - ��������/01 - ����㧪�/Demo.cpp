////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                           O M E G A  E N G I N E                           //
//                                  D E M O                                   //
//                                                                            //
//    Простой пример демонстрирующий загрузку текстур с "нормальным "размером //
//  и размером не кратным 2.                                                  //
//                                                                            //
//  (C)2006 Andru 'aka' KEMKA ANDREY.                                         //
//  web  : HTTP://isada.mirgames.ru                                           //
//  eMail: Andru_@list.ru                                                     //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

#include "..\..\..\..\headers\C++\OMEGA_code.cpp" // подключаем хедер движка
#include "..\..\..\..\headers\C++\OMEGA_functions.h" // для функций с параметрами поумолчанию


PTimer MyTimer;

// Переменные, которые будут хранить идентификаторы текстур
PTexture Texture;
PTexture TexBad;
PTexture TexBadN;

void Load()
{
}

void Init()
{
// Загружаем текстуру
Texture = Tex_LoadFromFile( "..\\..\\..\\Media\\Logo.gif", // Где файл текстуры
                            0xFFFFFF,         // Цвет прозрачности - белый
                            TEX_DEFAULT_2D ); // Загрузка со стандартными
                                              // параметрами для OpenGL

// Загружаем текстуру которую OpenGL не любит=)
TexBadN = Tex_LoadFromFile( "..\\..\\..\\Media\\BadTexture.jpg",
                             -1,              // Без прозрачности
                             TEX_DEFAULT_2D );// Стандартные опции TEX_DEFAULT_2D
                                              // настроены таким образом чтоб
                                              // текстуры с размерами не кратными двум
                                              // загружались без "мыла"

// Для наглядности загрузим тектстуру опять но со стандартными параметрами для OpenGL,
// правда с удалением "неправильных краев"
TexBad = Tex_LoadFromFile( "..\\..\\..\\Media\\BadTexture.jpg", -1,
                           TEX_MIPMAP | TEX_FILTER_LINEAR | TEX_CLAMP );

}

void Draw()
{
//Чтоб скучно не было рисуем эти текстуры
SSprite_Draw( Texture, 800 - 128, 600 - 128, 128, 128, 255, 0, FX_DEFAULT );
SSprite_Draw( TexBad,  400 - 120, 300 - 45,  120,  90, 255, 0, FX_DEFAULT );
SSprite_Draw( TexBadN, 400,       300 - 45,  120,  90, 255, 0, FX_DEFAULT );
}

void Quit(void)
{
}

void Timer1()
{
// По нажатию Escape завершаем работу
if ( Key_Down( K_ESCAPE ) ) OE_Quit();
}

int main()
{

// Получаем адреса на функции
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
