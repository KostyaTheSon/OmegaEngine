////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                           O M E G A  E N G I N E                           //
//                                  D E M O                                   //
//                                                                            //
//    Ну а эта демка демонстрирует как "рисовать" тайлы.                      //
//                                                                            //
//  (C)2006 Andru 'aka' KEMKA ANDREY.                                         //
//  web  : HTTP://isada.mirgames.ru                                           //
//  eMail: Andru_@list.ru                                                     //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

#include "..\..\..\headers\C++\OMEGA_code.cpp" // подключаем хедер движка
#include "..\..\..\headers\C++\OMEGA_functions.h" // для функций с параметрами поумолчанию

PTimer MyTimer;

  // Переменные, которые будут хранить идентификаторы текстур
PTexture Texture;
PTexture AnimTile;

int N; // Текущий кадр анимированного тайла

void Load()
{
}

void Init()
{
// Загружаем текстуру Logo
Texture = Tex_LoadFromFile( "..\\..\\Media\\Logo.gif", 0xFFFFFF, TEX_DEFAULT_2D );

// Загружаем текстуру с кадрами анимации
AnimTile = Tex_LoadFromFile( "..\\..\\Media\\Sprite.tga", -1, TEX_DEFAULT_2D );
// Теперь очень важный момент. Указываем для текстуры размеры одного кадра
Tex_SetFramesSize( AnimTile,    // Текстура которую надо разделить на кадры
                   100, 100 ); // Ширина и высота одного кадра

}

void Draw()
{
//Рисуем тайлы с текстурой Logo
STile_Draw( Texture,      // Текстура
            0, 0,         // Координаты начала тайлов
            128, 128,     // Ширина и высота одного тайла
            7, 65,        // Количество тайлов по горизонтале и вертикали
            255,          // Альфа
            FX_DEFAULT ); // Флаги

// Теперь рисуем анимированные тайлы абсолютно также за исключением одного параметра
ATile_Draw( AnimTile,
            0, 0,
            100, 100,
            8, 7,
            N,            // Вот этого, который отвечает за текущий кадр
            255,
            FX_DEFAULT );
}

void Quit()
{
}

void Timer1()
{
// Инкрементируем=) текущий кадр спрайта...
N++;
//... и проверяем не выходит ли он за границы(хотя это делает и сам движок)
if ( N > 10 ) N = 1;
// По нажатию Escape завершаем работу
if ( Key_Down( K_ESCAPE ) ) OE_Quit();
}

int main()
{

// получаем адреса на функции
LoadOMEGA();

// Создаем таймер
MyTimer = Timer_Create( (void*)Timer1, 33, 0 );

// Назначаем "системные" процедуры
OE_RegProcedure( SYS_FASTINIT, (void*)Load );
OE_RegProcedure( SYS_INIT,     (void*)Init );
OE_RegProcedure( SYS_DRAW,     (void*)Draw );
OE_RegProcedure( SYS_QUIT,     (void*)Quit );

OE_SetScreenOptions( 800, 600, 32, 0, true, false );

//Запускаем движок, пока в тестовом режиме
OE_Init();

}

