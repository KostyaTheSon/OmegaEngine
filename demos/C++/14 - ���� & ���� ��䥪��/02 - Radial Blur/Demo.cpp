////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                           O M E G A  E N G I N E                           //
//                                  D E M O                                   //
//                                                                            //
//    Данная демка показывает как организовать создание blur-эффекта еще      //
//  одним способом. Я решил назвать его Radial Blur так как все рисуется за   //
//  несколько проходов не используя предыдущее состояние. Качество подобной   //
//  реализации лучше но скорость...                                           //
//                                                                            //
//  (C)2006 Andru 'aka' KEMKA ANDREY.                                         //
//  web  : HTTP://isada.mirgames.ru                                           //
//  eMail: Andru_@list.ru                                                     //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

#include "..\..\..\..\headers\C++\OMEGA_code.cpp" // подключаем хедер движка
#include "..\..\..\..\headers\C++\OMEGA_functions.h" // для функций с параметрами поумолчанию


PTimer MyTimer;
PTimer Blur; // Таймер для просчета Blur-эффекта

// Переменные, которые будут хранить идентификаторы текстур
PTexture Texture;
PTexture Sprite;
PTexture BlurTex; // Текстура для рендеринга Blur-эффекта

int N; // Текущий кадр спрайта
int Count = 10; // Количество проходов blur

void Load()
{
}

void Init()
{

BlurTex = Tex_CreateZero( 256, 256,
                          TEX_DEFAULT_2D ); // Создаем пустую текстуру среднего
                                            // качества для blur-эффектов
                                            // Сделаю замечания - разрешение по
                                            // горизонтале и вертикали не должно
                                            // превышать разрешение экрана и должно
                                            // быть кратно двум!!!
// Назначаем текстуру
FX_RadBlur_SetTex( BlurTex );

// Загружаем текстуру Logo
Texture = Tex_LoadFromFile( "..\\..\\..\\Media\\Logo.gif", 0xFFFFFF, TEX_DEFAULT_2D );

// Загружаем текстуру параноика=)
Sprite = Tex_LoadFromFile( "..\\..\\..\\Media\\BadTexture.jpg", -1, TEX_DEFAULT_2D );

}

// Функции надо разбить на те где происходит отрисовка того что надо заblur'ить...
void Draw()
{
//Рисуем Logo
SSprite_Draw( Texture, 800 - 128, 600 - 128, 128, 128, 255, 0, FX_DEFAULT );

//рисуем спрайт
SSprite_Draw( Sprite, 400 - 120, 300 - 90, 240, 180, 255, N );
}

// ...и отрисовка уже готовой сцены
void MainDraw()
{
Draw();
FX_SetBlendMode( FX_BLEND_ADD ); // С альфой эксперементируйте сами
FX_RadBlur_Draw( 0x0000FF, 255 );
FX_SetBlendMode( FX_BLEND_NORMAL );
}

void Quit()
{
}

void Timer1()
{
// Инкрементируем=) текущий градус поворота спрайта
N++;
if ( N > 360 ) N = 0;

// Добавляем/убираем количество blur-проходов и указываем смещения по осям
if ( Key_Press( K_ADD ) ) Count++;
if ( Key_Press( K_SUBTRACT ) ) Count--;
FX_RadBlur_SetParams( Count, 1, 1 );

// По нажатию Escape завершаем работу
if ( Key_Down( K_ESCAPE ) ) OE_Quit();
}

void Blur_Timer()
{
// "Просчитываем" blur с постепенным уменьшением альфы на 55, т.е. каждый следующий
// проход рисуется с 255 - n
FX_RadBlur_Calc( (void*)Draw, 55 );
}

int main()
{

LoadOMEGA();

// Создаем таймер
MyTimer = Timer_Create( (void*)Timer1, 33, 0 );
Blur    = Timer_Create( (void*)Blur_Timer, 33, 0 );

// Назначаем "системные" процедуры
OE_RegProcedure( SYS_FASTINIT, (void*)Load );
OE_RegProcedure( SYS_INIT,     (void*)Init );
OE_RegProcedure( SYS_DRAW,     (void*)MainDraw );
OE_RegProcedure( SYS_QUIT,     (void*)Quit );

OE_SetScreenOptions( 800, 600, 32, 0, true, false );

//Запускаем движок
OE_Init();

}

