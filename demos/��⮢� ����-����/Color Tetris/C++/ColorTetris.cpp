////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//    ##### ##### #     ##### ####     ##### ##### ##### ####   ###  #####    //
//    #     #   # #     #   # #   #      #   #       #   #   #   #  #         //
//    #     #   # #     #   # #   #      #   ###     #   #   #   #   ####     //
//    #     #   # #     #   # ####       #   #       #   ####    #       #    //
//    ##### ##### ##### ##### #   #      #   #####   #   #   #  ### #####     //
//                                                                            //
//                         V E R S O N  1 . 1  C++ Edition                    //
////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//  Автор: Шпилько Константин 'aka' Armorer                                   //
//  Почта: admin@armorer.fatal.ru                                             //
//                                                                            //
//  Версия 1.1 и портирование под C++:                                        //
//  Автор: Andru 'aka' Кемка Андрей                                           //
//  eMail: Andru_@list.ru                                                     //
//                                                                            //
//  Реализацию сохранения/загрузки рекордов делайте сами=)                    //
//                                                                            //
//  Если увидите какие ошибки относительно алгоритмов игры, то обращайтесь к  //
//  автору оригинала                                                          //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

#include "..\..\..\..\headers\C++\OMEGA_code.cpp"
#include "..\..\..\..\headers\C++\OMEGA_functions.h"
#include <iostream.h>
#include <fstream.h>

struct TRecord
{
  char Name[20];  // Имя рекордсмена
  WORD Point; // Набранные очки
};

struct TFigure
{
  int  X1;// Координаты падающей фигуры и размер
  int  Y;
  int  Num;
  bool ifMove; // Может ли фигура двигаться влево и вправо игроком
};

struct TTextures
{
  PTexture Fon;
  PTexture Brick;
};

class TGame
{
public:
  int       Ar[ 10 ][ 17 ];   // Массив, в котором хранится игровое поле
  int       Scene;            // Состояние игры: 0 - Ничего, 1 - Идет игра, 2 - Ввод имени победителем, 3 - Пауза
  bool      Sound;            // вкл/вык Звук
  WORD      Tics;             // Эта переменная нужна для установки уровня сложности
  WORD      Point;            // Очки, набранные игроком
  int       Lavel;            // Уровень сложности
  int       sLavel;           // Измененный уровень сложности
  char*     Text;             // Текст, который должен выводится на экран (Вроде "Game Over")

  TRecord   Rec;              // Последний лучший результат
  TFigure   Fig;              // Текущая фигура
  TTextures Texture;          // Идентификаторы текстур
  PFont2D   Font;
};


TGame  Game;
PTimer GameTimer;

PSound Sound1;
PSound Sound2;
PSound Sound3;

bool EnterText;

//Процедура воспроизведения звука
void Sound_Play( PSound Sound )
{
if ( Game.Sound )    // Если звук включён
  Snd_Play( Sound ); // проигрывать звук
}

//Процедура загрзки/сохранения рекордов
void LoadRecord( bool Sav )
{
fstream f;
if ( Sav )
  {
    f.open( "score.dat", ios::out | ios::binary );
    f.write( Game.Rec.Name, 20 );
    f.write( (char*)&Game.Rec.Point, 4 );
  }
else
  {
    f.open( "score.dat", ios::in | ios::binary );
    f.read( Game.Rec.Name, 20 );
    f.read( (char*)&Game.Rec.Point, 4 );
  }
f.close();
}

//Процедура, происходящая при инициализации движка
void Init()
{

//ЗАГРУЗКА ТЕКСТУР
Game.Font  = Text_LoadFontFromFile( "..\\Media\\Font.gif", "..\\Media\\FontInfo.ofi", 0 );
Game.Texture.Fon   = Tex_LoadFromFile( "..\\Media\\BackGround.jpg", -1,       TEX_DEFAULT_2D );
Game.Texture.Brick = Tex_LoadFromFile( "..\\Media\\Brick.bmp",      0x000000, TEX_DEFAULT_2D );

//ЗАГРУЗКА ЗВУКОВ
Snd_Init(); // Инициализация звуковой подсистемы (Необходимо сделать перед загрузкой звуков)
Sound1 = Snd_LoadFromFile( "..\\Media\\sound1.wav", 2 );
Sound2 = Snd_LoadFromFile( "..\\Media\\sound2.wav", 2 );
Sound3 = Snd_LoadFromFile( "..\\Media\\sound3.wav", 2 );

Game.sLavel  = 5;        // Установка уровня сложности
Game.Text    = " ";      // Не выводить текст на экран
Game.Sound   = true;     // Включить звук
LoadRecord( false );
}

//Процедура, происходящая при завершении работы программы
void Quit()
{
Game.~TGame();
// Очистку остальных ресурсов сделает движок
}

//Процедура, которая рисует
void Draw()
{
int i, j;

SSprite_Draw( Game.Texture.Fon, 0, 0, 800, 600 ); // Рисование фона

for ( i = 0; i <= 9; i++ )      //Прогоняем в цикле  весь массив
  for ( j = 0; j <= 16; j++ )
    if ( Game.Ar[ i ][ j ] > 0 ) // Если не пусто
      {
        switch (Game.Ar[ i ][ j ])
        {
        case 1 : FX_SetColorMix( 0x0000FF ); break;
        case 2 : FX_SetColorMix( 0x00FF00 ); break;
        case 3 : FX_SetColorMix( 0xFF0000 ); break;
        }  //switch
        SSprite_Draw( Game.Texture.Brick, i * 35 + 226, j * 35 + 1, 34, 34, 255, 0, FX_DEFAULT | FX_COLORMIX );
      }

Text_Draw( Game.Font, 680, 30, U_IntToStr( Game.Point ), 1, 0, 255, 0xFFFFFF ); // Выводит количесво набранных очков
Text_Draw( Game.Font, 750, 62, U_IntToStr( Game.sLavel ), 1, 0, 255, 0xFFFFFF ); // Выводит уровень сложности

char* str = Game.Rec.Name;
Text_Draw( Game.Font, 610, 140, str, 0.9, 0, 255, 0xFFFFFF ); // Выводит последний рекорд
Text_Draw( Game.Font, 610, 165, U_IntToStr( Game.Rec.Point ), 0.9, 0, 255, 0xFFFFFF );

Text_Draw( Game.Font, 240, 20, Game.Text, 1, 0, 255, 0xFFFFFF );//Выводит текст
}

//Процедура, в которой появляется новая фигура
void Next()
{
int X, i, j;

for ( j = 0; j <= 16; j++ )  // Сначала проверяем, нет ли линии из 4 квадратиков одного цвета по горизонтали
  for ( i = 0; i <= 7; i++ )
    if ( ( Game.Ar[ i ][ j ] > 0 )                      &&
         ( Game.Ar[ i ][ j ] == Game.Ar[ i + 1 ][ j ] ) &&
         ( Game.Ar[ i ][ j ] == Game.Ar[ i + 2 ][ j ] ) &&
         ( Game.Ar[ i ][ j ] == Game.Ar[ i + 3 ][ j ] ) )
      {
        if ( Game.Ar[ i ][ j ] == Game.Ar[ i + 4 ][ j ] )  // Если квадратиков 5
          {
            Game.Ar[ i + 4 ][ j ] = 0;  // Убрать пятый
            Game.Point += Game.Lavel; // Добавить очки
            if ( Game.Ar[ i ][ j ] == Game.Ar[ i + 5 ][ j ] ) // Тоже если 6 квадратов
              {
                Game.Ar[ i + 5 ][ j ] = 0;
                Game.Point += Game.Lavel;
              };
          };
        Game.Ar[ i ][ j ]     = 0; // Убрать 4 квадрата
        Game.Ar[ i + 1 ][ j ] = 0;
        Game.Ar[ i + 2 ][ j ] = 0;
        Game.Ar[ i + 3 ][ j ] = 0;
        Game.Point += Game.Lavel; // Увеличить очки
        Sound_Play( Sound1 );     // Воспроизвести звук
      };

for ( i = 0; i <= 9; i++ ) // Аналогично по вертикали
  for ( j = 0; j <= 14; j++ )
    if ( ( Game.Ar[ i ][ j ] > 0 )                    &&
         ( Game.Ar[ i ][ j ] == Game.Ar[ i ][ j + 1 ] ) &&
         ( Game.Ar[ i ][ j ] == Game.Ar[ i ][ j + 2 ] ) &&
         ( Game.Ar[ i ][ j ] == Game.Ar[ i ][ j + 3 ] ) )
      {
        if ( Game.Ar[ i ][ j ] == Game.Ar[ i ][ j + 4 ] )
          {
            Game.Ar[ i ][ j + 4 ] = 0;
            Game.Point += Game.Lavel;
            if ( Game.Ar[ i ][ j ] == Game.Ar[ i ][ j + 5 ] )
              {
                Game.Ar[ i ][ j + 5 ] = 0;
                Game.Point += Game.Lavel;
              };
          };
        Game.Ar[ i ][ j     ] = 0;
        Game.Ar[ i ][ j + 1 ] = 0;
        Game.Ar[ i ][ j + 2 ] = 0;
        Game.Ar[ i ][ j + 3 ] = 0;
        Game.Point += Game.Lavel;
        Sound_Play( Sound1 );
      };

int r = rand()%3;
switch ( r ) // Случайным образом получить новую фигуру
{
  case 0:
      X                 = rand()%10;
      Game.Ar[ X ][ 0 ] = rand()%3 + 1;
      Game.Fig.Num      = 0;
      break;
  case 1:
      X                     = rand()%9;
      Game.Ar[ X ][ 0 ]     = rand()%3 + 1;
      Game.Ar[ X + 1 ][ 0 ] = rand()%3 + 1;
      Game.Fig.Num          = 1;
      break;
  case 2:
      X                     = rand()%8;
      Game.Ar[ X ][ 0 ]     = rand()%3 + 1;
      Game.Ar[ X + 1 ][ 0 ] = rand()%3 + 1;
      Game.Ar[ X + 2 ][ 0 ] = rand()%3 + 1;
      Game.Fig.Num          = 2;
      break;
}; //switch

Game.Fig.X1     = X;    // Установка координат на положение новой фигуры
Game.Fig.Y      = 0;
Game.Fig.ifMove = true; // Фигуру можно двигать
}

//Процедура, возникающая при проигрыше
void GameOver()
{
Game.Scene = 0;    // Установка состояния игры в положение "Ничего"
if ( Game.Rec.Point < Game.Point )   //Если игрок набрал больше очков, чем был предыдущий рекорд
  {
    Game.Text = "Введите ваше имя";

    Game.Scene     = 2;           // Читать введенное пользователем имя
    Game.Rec.Point = Game.Point;
    int i;
    for ( i = 0; i < 20; i++ )
      Game.Rec.Name[i] = ' ';      // Перед чтением стереть предыдущее имя
  }
else                         // Если нет вывести текст: 'GameOver'
  Game.Text = "GameOver";
}

//Процедура, которая возникает при ускорении
void Tic1()
{
int i, j;

for ( i = 9; i >= 0; i-- )         //Проходит по всему массиву
  for ( j = 15; j >= 0; j-- )
    if ( Game.Ar[ i ][ j ] > 0 )     // Если клетка не пустая и...
      if ( Game.Ar[ i ][ j + 1 ] == 0) // ...под ней пусто
        {
          Game.Ar[ i ][ j + 1 ] = Game.Ar[ i ][ j ]; // Переместить квадратик
          Game.Ar[ i ][ j ]     = 0;               //Отчистить предыдущее его место
        }
      else
        /*если под клеткой с квадратиком не пусто и эта клетка является частью
         фигуры то запретить перемещение фигуры
         Это делается, для того чтобы, когда одна часть фигуры
         не может двигаться вниз (из-за того, что там место занято),
         а другая продолжает движение, игрок не мог перемещать её. */
          if ( ( Game.Fig.Y == j )     &&
               ( ( Game.Fig.Num == 1 ) && ( ( Game.Fig.X1 == i ) || ( Game.Fig.X1 + 1 == i ) ) ||
               ( ( Game.Fig.Num == 2 ) && ( ( Game.Fig.X1 == i ) || ( Game.Fig.X1 + 1 == i ) ) || ( Game.Fig.X1 + 2 == i ) ) ) )
            Game.Fig.ifMove = false;

Game.Fig.Y++; // Изменить координаты фигуры
}

//Процедура без названия :)
void Tic()
{
int i, j;
bool L; // Определяет, упала ли предыдущая фигура

L = true;
for ( i = 9; i >= 0; i-- )
  for ( j = 15; j >= 0; j-- )
    if ( Game.Ar[ i ][ j ] > 0 )
      if ( Game.Ar[ i ][ j + 1 ] == 0 )
      {
        Game.Ar[ i ][ j + 1 ] = Game.Ar[ i ][ j ];
        Game.Ar[ i ][ j ]     = 0;
        L = false; // Если что-то может двигаться вниз, значит, фигура не упала
      }
     else
      if ( ( Game.Fig.Y == j )     &&
           ( ( Game.Fig.Num == 1 ) && ( ( Game.Fig.X1 == i ) || ( Game.Fig.X1 + 1 == i ) ) ||
           ( ( Game.Fig.Num == 2 ) && ( ( Game.Fig.X1 == i ) || ( Game.Fig.X1 + 1 == i ) ) || ( Game.Fig.X1 + 2 == i ) ) ) )
        Game.Fig.ifMove = false;

for ( i = 0; i <= 9; i++ ) // Если на самом верху остались квадраты
  if ( Game.Ar[ i ][ 0  ] > 0 )
    {
      GameOver(); // Значит игра закончена
      Sound_Play( Sound3 );
    };

Game.Fig.Y++;  // Изменить координаты фигуры
if ( L )       // Если фигура упала, значит, нужна новая
  Next();
}

//Происходит при начале новой игры
void NewGame()
{
int i, j;

if ( Game.Sound )
  Media_Play( "..\\media\\music.mid", true );

for ( i = 0; i <= 9; i++ ) // Отчистка поля
  for ( j = 0; j <= 16; j++ )
    Game.Ar[ i ][ j ] = 0;

Game.Lavel = Game.sLavel;  // Установка уровня сложности
Game.Scene = 1;
Game.Point = 0;            // Обнуление очков
Game.Text  = " ";
Next();
}

//Перемещение игроком фигуры влево
void Left()
{
int i;

if ( Game.Scene == 1 ) // Если сейчас идет игра
  {
  if ( Game.Fig.X1 > 0  ) // Если фигура не в крайнем левом положении
    if ( Game.Ar[ Game.Fig.X1 - 1 ][ Game.Fig.Y ] == 0 ) //Если слева от фигуры ничего нет
      {
        for ( i = 0; i <= Game.Fig.Num; i++ ) // Передвинуть фигуру
          Game.Ar[ Game.Fig.X1 - 1 + i ][ Game.Fig.Y ] = Game.Ar[ Game.Fig.X1 + i ][ Game.Fig.Y ];

        Game.Ar[ Game.Fig.X1 + Game.Fig.Num ][ Game.Fig.Y ] = 0;
        Game.Fig.X1--;      // Изменить координаты фигуры
      };
  };

}

//Перемещение игроком фигуры вправо
void Right()
{
int i;

if ( Game.Scene == 1 )
  {
    if ( Game.Fig.X1 < 9 - Game.Fig.Num )
      if ( Game.Ar[  Game.Fig.X1 + 1 + Game.Fig.Num ][ Game.Fig.Y ] == 0 )
        {
          for ( i = 0; i <= Game.Fig.Num; i++ )
            Game.Ar[ Game.Fig.X1 + 1 - i + Game.Fig.Num ][ Game.Fig.Y ] =
            Game.Ar[ Game.Fig.X1 - i + Game.Fig.Num ][ Game.Fig.Y ];

            Game.Ar[ Game.Fig.X1 ][ Game.Fig.Y ] = 0;
            Game.Fig.X1++;
        };
  };
}

//Процедура, обработки ввода и игровой таймер
void Timer()
{
Game.Tics++;     // Увеличить значение таймера

if ( Key_Press( K_ESCAPE ) )   //Если нажат Esc закрыть программу
  OE_Quit();

if ( Game.Scene != 2 ) // Если сейчас игрок не вводит своё имя
  {
    if ( Key_Press( K_S ) )
      NewGame();

    if ( Key_Press( K_A ) )         // вкл/выключение звука
      {
        Game.Sound = !Game.Sound;
        Snd_Play( Sound2 );
        if ( Game.Sound )
          Media_Resume();
        else
          Media_Pause();
      };

    if ( Key_Down( K_LEFT ) && ( Game.Fig.ifMove ) )
      Left();

    if ( Key_Down( K_RIGHT ) && Game.Fig.ifMove )
      Right();

    if ( Key_Down( K_DOWN ) && ( Game.Scene == 1 ) ) // если зажата клавиша Down и идёт игра
      Tic1();

    if ( Key_Press( K_SUBTRACT ) && ( Game.sLavel > 1 ) ) // Изменение уровня сложности
      {
        Game.sLavel--;
        Sound_Play( Sound2 );
      };
    if ( Key_Press( K_ADD ) && ( Game.sLavel < 10 ) )
      {
        Game.sLavel++;
        Sound_Play( Sound2 );
      };

    if ( Key_Press( K_P ) && ( Game.Scene != 0 ) ) // Если нажата клавиша P и идёт игра
      if ( Game.Scene == 1 )  // Если идет игра
        {
          Game.Text  = "Pause"; // Вывести сообщение
          Game.Scene = 3;      // Остановить игру
        }
      else
        {               // Если игра не идет
          Game.Text  = " "; // Убрать сообщение
          Game.Scene = 1;  // Возобновить игру
        }
  }
else // Если идёт ввод
  {
    if ( !EnterText )
      {
        Key_BeginReadText( NULL );
        EnterText = true;
      };
     if ( Key_Press( K_ENTER ) ) // Если нажат Enter
      {
        Game.Scene    = 0;         // Остановить ввод
        char* str     = Key_EndReadText();
        int i;
        for ( i = 0; i < 20; i++ )
          Game.Rec.Name[i] = str[i];
        EnterText     = false;
      };
    char* str = Key_EndReadText();
    int i;
    for ( i = 0; i < 20; i++ )
      Game.Rec.Name[i] = str[i];
    LoadRecord( true ); //сохраняем результат
  };

if ( ( Game.Scene == 1 ) && ( Game.Tics >= 10 - Game.Lavel ) )   // Если идет игра,
  {               // в зависимости от уровня сложности опускать квадратики
    Tic();
    Game.Tics = 0; // Обнулить таймер
  };
};



int main()
{
LoadOMEGA();

OE_SetScreenOptions( 800, 600, 32, 0, true, true  );   //Установка параметров экрана

GameTimer = Timer_Create( (void*)Timer, 40 );

//Регистрация процедур
OE_RegProcedure( SYS_INIT, (void*)Init ); // Надо иногда читать справку к движку :)
OE_RegProcedure( SYS_DRAW, (void*)Draw );
OE_RegProcedure( SYS_QUIT, (void*)Quit );

//OE_Disable( FLAG_CLEAR_COLOR_BUFFER ); // Выключаем очистку буфера цвета для оптимизации
//OE_Disable( FLAG_CROP_UNVISIBLE_OBJ ); // Выключаем отрезку невидных обьектов,
                                       // потому как все в пределах одного экрана

OE_SetAdvancedOptions( true ); //Включить движковый лог
OE_Init(); // Запуск движка
}
