////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                           O M E G A  E N G I N E                           //
//                                  D E M O                                   //
//                                                                            //
//    Текст... комментарии не требуются=)                                     //
//                                                                            //
//  (C)2006 Andru 'aka' KEMKA ANDREY.                                         //
//  web  : HTTP://isada.mirgames.ru                                           //
//  eMail: Andru_@list.ru                                                     //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

#include "..\..\..\headers\C++\OMEGA_code.cpp" // подключаем хедер движка
#include "..\..\..\headers\C++\OMEGA_functions.h" // для функций с параметрами поумолчанию
#include <string>


PTimer MyTimer;

// Переменная, которая будет хранить идентификатор шрифта
PFont2D Font;

void Load()
{
}

void Init()
{
// Загружаем шрифт
Font = Text_LoadFontFromFile( "..\\..\\Media\\Font.gif",    // Где текстура шрифта
                              "..\\..\\Media\\FontInfo.ofi",// Где параметры шрифта
                              0,                                // Цвет прозрачности - черный
                              TEX_DEFAULT_2D | TEX_FILTER_NEAREST ); // Для ауентичности не будем использовать фильтрацию

}

void Draw()
{
char buffer[256];

sprintf( buffer, "FPS: %d", OE_GetFPS() );
//Рисуем его=)
Text_Draw( Font,      // Наш идентификатор
           0, 0,      // Координаты
           buffer,    // Сам текст
           1,         // Клэффициент увеличения
           0,         // Дополнительное растояние между символами
           255,       // Альфа
           0xFFFFFF );// Ну и цвет

// А теперь проявите соображалку=) и поймите чего тут делается
Text_Draw( Font, 400 - Text_GetWidth( Font, "Hello, World!", 6, 0 ) / 2, 300 - 98,
           "Hello, World!", 6, 0, 255, 0x0000FF );

// Еще движок воспринимает символы перевода строки
Text_Draw( Font, 0, 18, "this is a string with symbol \n\\n" );
}

void Quit()
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

