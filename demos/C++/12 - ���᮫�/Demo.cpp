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

PTimer MyTimer;

// Переменная, которая будет хранить идентификатор шрифта для консоли
PFont2D Font;

void Load()
{
}

void Init()
{
// Загружаем шрифт
Font = Text_LoadFontFromFile( "..\\..\\Media\\consoleFont.gif",
                              "..\\..\\Media\\consoleFontInfo.ofi" );

Console_SetOptions( Font,     // Задаем шрифт
                    NULL,     // Если значение nil, то будет фон цвета...
                    0,        // указанного тут
                    155,      // Альфа консоли
                    0xFFFFFF, // Цвет шрифта
                    255 );    // Альфа шрифта
Console_Active( true ); // Разрешаем использовать консоль

// В качестве примера зарегистрируем движковую функцию выхода как команду Quit
Console_RegCommand( "quit", (void*)OE_Quit );

// Добавим информацию о приложении
Console_AddString( "###########################" );
Console_AddString( "# Simple console application v.1.0 #" );
Console_AddString( "###########################" );

}

void Draw()
{
Console_Draw(); // Рисуем консоль, ее надо вставить в конце всех отрисовок
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

