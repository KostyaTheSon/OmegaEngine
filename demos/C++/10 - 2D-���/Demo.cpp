////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                           O M E G A  E N G I N E                           //
//                                  D E M O                                   //
//                                                                            //
//    Хотя приведенный тут "алгоритм позиционирования звука" считать          //
//  правильным не стоит, но решить простые задачи он позволит. И маленькое    //
//  пояснение: координаты 400/300 являются координатами слушателя.            //
//                                                                            //
//  (C)2006 Andru 'aka' KEMKA ANDREY.                                         //
//  web  : HTTP://isada.mirgames.ru                                           //
//  eMail: Andru_@list.ru                                                     //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

#include "..\..\..\headers\C++\OMEGA_code.cpp" // подключаем хедер движка
#include "..\..\..\headers\C++\OMEGA_functions.h" // для функций с параметрами поумолчанию


PTimer MyTimer;

//Идентификатор звука
PSound Sound;
int    ID; // Идентификатор для измены параметров проигрывания

// Вообще поэксперементируйте сами...
int CalcX( int X )
{
  return ( ( X - 400 ) * 5 );
}

int CalcY( int Y )
{
  return ( -( 300 - Y ) );
}

void Load()
{
}

void Init()
{

Snd_Init(); // Инициализируем звуковую подсистему
// Загружаем звук
Sound = Snd_LoadFromFile( "..\\..\\Media\\snd.wav", // Где наш сэмпл
                          1 );                          // Нам хватит и одного буфера
// Зацыкленно воспроизводим
ID = Snd_Play( Sound,  // Идентификатор звука
               0,      // Значение Pan
               0,      // "Громксоть"
               0,      // Частота проигрывания
               true ); // Зацикленно ли играть
// Ну и еще, 0 - это значения по-умолчанию

}

void Draw()
{

Pr2D_Circle( 400, 300, 16, 0x00FF00, 255, 32, PR_FILL );

Pr2D_Circle( Mouse_X(), Mouse_Y(), 8, 0xFF0000, 255, 32, PR_FILL );

}

void Quit()
{
}

void Timer1()
{

// Меняем параметры звук
Snd_ChangeParam( Sound,              // Знакомый параметр
                 ID,                 // Идентификатор буфера который играет
                 CalcX( Mouse_X() ), // Новые "X-координаты"
                 CalcY( Mouse_Y() ), // Новые "Y-координаты"
                 0 );                // Частоту оставляем без измен

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

