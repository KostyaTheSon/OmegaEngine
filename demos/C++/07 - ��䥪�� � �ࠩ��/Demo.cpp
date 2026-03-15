////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                           O M E G A  E N G I N E                           //
//                                  D E M O                                   //
//                                                                            //
//    Здесь показывается какие флаги можно использовать чтоб наложить простые //
//  эффекты(отражение, масштабирование, наложение цвета и т.д.) и какие       //
//  "подготовительные" функции надо вызывать.                                 //
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
Tex_SetFramesSize( Sprite, 100, 100 );

}

void Draw()
{
//Рисуем Logo
SSprite_Draw( Texture, 800 - 128, 600 - 128, 128, 128, 255, 0, FX_DEFAULT );

// Теперь рисуем анимированный спрайт с отражением по оси X
ASprite_Draw( Sprite, 400 - 100, 300 - 50, 100, 100, N, 255, 0,
              FX_DEFAULT | FX_FLIPX ); // Добавляем нужный флаг через or

// Устанавливаем цвет смешивания
FX_SetColorMix( 0x0000FF );
ASprite_Draw( Sprite, 400 - 50, 300 - 50, 100, 100, N, 255, 0,
              FX_DEFAULT | FX_COLORMIX ); // Добавляем флаг наложения цвета через or

// Устанавливаем цвет смешивания для каждой отдельной вершины
FX_SetVCA( 0xFF0000, 0x00FF00, 0x0000FF, 0xFFFF00, 255, 255, 255, 255 );
ASprite_Draw( Sprite, 400, 300 - 50, 100, 100, N, 255, 0,
              FX_DEFAULT | FX_VCA ); // Добавляем через or

// Устанавливаем коэфициент увеличение
FX_SetScale( 2, 2 );
ASprite_Draw( Sprite, 400 - 50, 300 + 50 * 2, 100, 100, N, 255, 0,
              FX_DEFAULT | FX_SCALE ); // Добавляем через or
}

void Quit()
{
}

void Timer1()
{
// Инкрементируем=) текущий кадр спрайта...
N++;
//... и проверяем не выходит ли он за границы(хотя это делает и сам движок)
if( N > 10 ) N = 1;
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

