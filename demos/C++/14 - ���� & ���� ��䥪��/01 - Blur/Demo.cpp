////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                           O M E G A  E N G I N E                           //
//                                  D E M O                                   //
//                                                                            //
//    Данная демка показывает ка организовать создание blur-эффекта средствами//
//  движка. Рассмотренный здесь эффект(размытость влево и вправо красным      //
//  цветом) называется иногда Beast-blur(хотя возможно я заблуждаюсь=) На     //
//  данном примере он смотрится вообще не так как хотелось бы, но             //
//  организовывать насыщенную сцену - уже ваше дело=)                         //
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
FX_Blur_SetTex( BlurTex );

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

// Устанавливаем коэфициент увеличение...
FX_SetScale( (float)N / 5, (float)N / 5 );
// ... и рисуем спрайт
SSprite_Draw( Sprite, 400 - 60, 300 - 45, 120, 90, 255, 0, FX_DEFAULT | FX_SCALE );
}

// ...и отрисовка уже готовой сцены
void MainDraw()
{
Draw();
FX_SetBlendMode( FX_BLEND_ADD );
FX_Blur_Draw( 0x0000FF, 255 );
FX_SetBlendMode( FX_BLEND_NORMAL );
}

void Quit()
{
}

void Timer1()
{
// Инкрементируем=) текущий размер спрайта...
N++;
if ( N > 20 ) N = 1;

// Добавляем/убираем количество blur-проходов и указываем смещение по осям
if ( Key_Press( K_ADD ) ) Count++;
if ( Key_Press( K_SUBTRACT ) ) Count--;
FX_Blur_SetParams( Count, 2, 0 );

// По нажатию Escape завершаем работу
if ( Key_Down( K_ESCAPE ) ) OE_Quit();
}

void Blur_Timer()
{
// "Просчитываем" blur с постепенным уменьшением альфы на 55, т.е. каждый следующий
// проход рисуется с 255 - n. Второй элемент означает сколько "времени" ждать
// между каждым проходом
FX_Blur_Calc( (void*)Draw, 1, 55 );
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

