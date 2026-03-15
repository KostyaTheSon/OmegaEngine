////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                           O M E G A  E N G I N E                           //
//                                  D E M O                                   //
//                                                                            //
//    Тут описывается три новых команды, которые понадобяться при работе со   //
//  спрайтами                                                                 //
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
PTexture Sprite;

int N; // Текущий кадр спрайта

void Load()
{
}

void Init()
{
// Загружаем текстуру Logo
Texture = Tex_LoadFromFile( "..\\..\\Media\\Logo.gif", 0xFFFFFF, TEX_DEFAULT_2D );

// Загружаем текстуру с кадрами анимации
Sprite = Tex_LoadFromFile( "..\\..\\Media\\Sprite.tga", -1, TEX_DEFAULT_2D );
// Теперь очень важный момент. Указываем для текстуры размеры одного кадра
Tex_SetFramesSize( Sprite,     // Текстура которую надо разделить на кадры
                   100, 100 ); // Ширина и высота одного кадра

}

void Draw()
{
//Рисуем уже немного знакомой командой статичный спрайт Logo
SSprite_Draw( Texture,               // Текстура коорую надо рисовать
              800 - 128, 600 - 128,  // Координаты верхнего левого угла
              128, 128,              // Ширина и высота спрайта
              255,                   // Альфа
              0,                     // Угол поворота, значения от 0..360
              FX_DEFAULT );          // Флаги

// Теперь рисуем анимированный спрайт абсолютно также за исключением одного параметра
ASprite_Draw( Sprite,
              400 - 50, 300 - 50,
              100, 100,
              N,                 // Вот этого, который отвечает за текущий кадр
              255,
              0,
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

// Получаем адреса на функции
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

