////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                           O M E G A  E N G I N E                           //
//                                  D E M O                                   //
//                                                                            //
//    Демонстрация загрузки текстуры с использованием предварительно          //
//  загруженной маской                                                        //
//                                                                            //
//  (C)2006 Andru 'aka' KEMKA ANDREY.                                         //
//  web  : HTTP://isada.mirgames.ru                                           //
//  eMail: Andru_@list.ru                                                     //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

#include "..\..\..\..\headers\C++\OMEGA_code.cpp" // подключаем хедер движка
#include "..\..\..\..\headers\C++\OMEGA_functions.h" // для функций с параметрами поумолчанию

PTimer MyTimer;

  // Переменная, которая будут хранить идентификатор текстуры
PTexture Texture;

void Load()
{
}

void Init()
{
// Загружаем маску указывая только имя файла
Tex_LoadMaskFromFile( "..\\..\\..\\Media\\Mask.gif" );

// Загружаем текстуру.
//ВНИМАНИЕ: Если размеры маски и текстуры не совпадают - это грозит ошибками
// в памяти!
Texture = Tex_LoadFromFile( "..\\..\\..\\Media\\Texture01.jpg", -1,
                            TEX_DEFAULT_2D |
                            TEX_USEMASK ); // Добавляя флаг TEX_USEMASK движок
                                           // будет использовать последнюю
                                           // загруженную маску

// Если будут загружаться другие маски, то следует сперва очистить эту
Tex_FreeMask();
}

void Draw()
{
//Чтоб скучно не было рисуем эти текстуры
SSprite_Draw( Texture, 400 - 320, 300 - 125, 640, 250, 255, 0, FX_DEFAULT );
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

// Получаем адреса для функций
LoadOMEGA();

// Создаем таймер
MyTimer = Timer_Create( (void*)Timer1, 10, 0 );

// Назначаем "системные" процедуры
OE_RegProcedure( SYS_FASTINIT, (void*)Load );
OE_RegProcedure( SYS_INIT,     (void*)Init );
OE_RegProcedure( SYS_DRAW,     (void*)Draw );
OE_RegProcedure( SYS_QUIT,     (void*)Quit );

OE_SetScreenOptions( 800, 600, 32, 0, true, false );

//Запускаем движок, пока в тестовом режиме
OE_Init();

}

