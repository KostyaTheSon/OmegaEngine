////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                           O M E G A  E N G I N E                           //
//                                  D E M O                                   //
//                                                                            //
//    Простой пример демонстрирующий наложение эффектов на текстуры в момент  //
//  загрузки                                                                  //
//                                                                            //
//  (C)2006 Andru 'aka' KEMKA ANDREY.                                         //
//  web  : HTTP://isada.mirgames.ru                                           //
//  eMail: Andru_@list.ru                                                     //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

#include "..\..\..\..\headers\C++\OMEGA_code.cpp" // подключаем хедер движка
#include "..\..\..\..\headers\C++\OMEGA_functions.h" // для функций с параметрами поумолчанию


PTimer MyTimer;
  
  // Переменные, которые будут хранить идентификаторы текстур
PTexture TexGray;
PTexture TexInvert;
PTexture TexNormal;

void Load()
{
}

void Init()
{
// Загружаем текстуры
TexGray = Tex_LoadFromFile( "..\\..\\..\\Media\\BadTexture.jpg", -1,
                            TEX_DEFAULT_2D |
                            TEX_GRAYSCALE ); // Конвертация в градации серого
                                             // через добавление флага TEX_INVERT

TexInvert = Tex_LoadFromFile( "..\\..\\..\\Media\\BadTexture.jpg", -1,
                             TEX_DEFAULT_2D |
                             TEX_INVERT ); // Инвертируем значение цветов
                                           // через добавление флага TEX_INVERT

TexNormal = Tex_LoadFromFile( "..\\..\\..\\Media\\BadTexture.jpg", -1,
                              TEX_DEFAULT_2D );


}

void Draw()
{
//Чтоб скучно не было рисуем эти текстуры
SSprite_Draw( TexGray,   400 - 190, 300 - 45, 120, 90, 255, 0, FX_DEFAULT );
SSprite_Draw( TexInvert, 400 - 60, 300 - 45, 120, 90, 255, 0, FX_DEFAULT );
SSprite_Draw( TexNormal, 400 + 60, 300 - 45, 120, 90, 255, 0, FX_DEFAULT );
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

//Запускаем движок, пока в тестовом режиме
OE_Init();

}

