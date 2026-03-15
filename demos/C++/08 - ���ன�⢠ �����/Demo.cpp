////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                           O M E G A  E N G I N E                           //
//                                  D E M O                                   //
//                                                                            //
//    За более подробным описанием функций для обработки устройств ввода      //
//  обращайтесь в справку.                                                    //
//  спрайтами                                                                 //
//                                                                            //
//  (C)2006 Andru 'aka' KEMKA ANDREY.                                         //
//  web  : HTTP://isada.mirgames.ru                                           //
//  eMail: Andru_@list.ru                                                     //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

#include "..\..\..\headers\C++\OMEGA_code.cpp" // подключаем хедер движка
#include "..\..\..\headers\C++\OMEGA_functions.h" // для функций с параметрами поумолчанию
#include <stdlib.h>

PTimer MyTimer;

  // Переменные, которые будут хранить идентификаторы текстур
PTexture Texture;

  // Будут координаты спрайта, чтоб с помощью устройств ввода его перемещать
int X;
int Y;

void Load()
{
}

void Init()
{


// Загружаем текстуру Logo
Texture = Tex_LoadFromFile( "..\\..\\Media\\Logo.gif", 0xFFFFFF, TEX_DEFAULT_2D );
}

void Draw()
{
//Рисуем уже немного знакомой командой статичный спрайт Logo
SSprite_Draw( Texture, X, Y, 128, 128, 255, 0, FX_DEFAULT );
}

void Timer1()
{

// Мучаем клаву=)
if ( Key_Down( K_RIGHT ) ) X = X + 1;
if ( Key_Down( K_LEFT  ) ) X = X - 1;
if ( Key_Down( K_UP    ) ) Y = Y - 1;
if ( Key_Down( K_DOWN  ) ) Y = Y + 1;
// Press означает что клавиатура была нажата полностью, т.е. с отпуском
if ( Key_Press( K_SPACE ) )
  {
    X = rand()%(800-128);
    Y = rand()%(600-128);
  }

// Теперь грызуна
if ( Mouse_Move() )
  {
    X = Mouse_X();
    Y = Mouse_Y();
  }

// Джойстки обрабатывается аналогично клавиатуре, например:
//if Joy_Down( JOY_0, JOY_BUTTON01 ) Then...
// но все оставляю в комментариях, потому как при отсутствии джойстика ответы
// могут быть неправильными насчет команд вроде этой Joy_AxePos( JOY_0, JOY_XLEFT );

// По нажатию Escape завершаем работу
if ( Key_Down( K_ESCAPE ) ) OE_Quit();
}

void Quit()
{
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

//Запускаем движок, пока в тестовом режиме
OE_Init();

}

