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
program Demo;

uses
  OMEGA in '..\..\..\..\headers\Delphi\OMEGA.pas'; // подключаем хедер движка

var
  MyTimer : PTimer;
  Blur    : PTimer; // Таймер для просчета Blur-эффекта

  // Переменные, которые будут хранить идентификаторы текстур
  Texture : PTexture;
  Sprite  : PTexture;
  BlurTex : PTexture; // Текстура для рендеринга Blur-эффекта

  N       : Integer; // Текущий кадр спрайта
  Count   : Integer = 10; // Количество проходов blur 

procedure Load;
Begin
End;

procedure Init;
Begin

BlurTex := Tex_CreateZero( 256, 256,
                           TEX_DEFAULT_2D ); // Создаем пустую текстуру среднего
                                             // качества для blur-эффектов
                                             // Сделаю замечания - разрешение по
                                             // горизонтале и вертикали не должно
                                             // превышать разрешение экрана и должно
                                             // быть кратно двум!!!
// Назначаем текстуру
FX_Blur_SetTex( BlurTex );

// Загружаем текстуру Logo
Texture := Tex_LoadFromFile( '..\..\..\Media\Logo.gif', $FFFFFF, TEX_DEFAULT_2D );

// Загружаем текстуру параноика=)
Sprite := Tex_LoadFromFile( '..\..\..\Media\BadTexture.jpg', -1, TEX_DEFAULT_2D );

End;

// Функции надо разбить на те где происходит отрисовка того что надо заblur'ить...
procedure Draw;
Begin
//Рисуем Logo
SSprite_Draw( Texture, 800 - 128, 600 - 128, 128, 128, 255, 0, FX_DEFAULT );

// Устанавливаем коэфициент увеличение...
FX_SetScale( N / 5, N / 5 );
// ... и рисуем спрайт
SSprite_Draw( Sprite, 400 - 60, 300 - 45, 120, 90, 255, 0, FX_DEFAULT or FX_SCALE );
End;

// ...и отрисовка уже готовой сцены
procedure MainDraw;
Begin
Draw;
FX_SetBlendMode( FX_BLEND_ADD );
FX_Blur_Draw( $0000FF, 255 );
FX_SetBlendMode( FX_BLEND_NORMAL );
End;

procedure Quit;
Begin
End;

procedure Timer1;
Begin
// Инкрементируем=) текущий размер спрайта...
INC( N );
if N > 20 Then N := 1;

// Добавляем/убираем количество blur-проходов и указываем смещение по осям
if Key_Press( K_ADD ) Then INC( Count );
if Key_Press( K_SUBTRACT ) Then DEC( Count );
FX_Blur_SetParams( Count, 2, 0 );

// По нажатию Escape завершаем работу
if Key_Down( K_ESCAPE ) Then OE_Quit;
End;

procedure Blur_Timer;
Begin
// "Просчитываем" blur с постепенным уменьшением альфы на 55, т.е. каждый следующий
// проход рисуется с 255 - n. Второй элемент означает сколько "времени" ждать
// между каждым проходом
FX_Blur_Calc( @Draw, 1, 55 );
End;

begin

// Создаем таймер
MyTimer := Timer_Create( @Timer1, 33, 0 );
Blur    := Timer_Create( @Blur_Timer, 33, 0 );

// Назначаем "системные" процедуры
OE_RegProcedure( SYS_FASTINIT, @Load );
OE_RegProcedure( SYS_INIT,     @Init );
OE_RegPRocedure( SYS_DRAW,     @MainDraw );
OE_RegPRocedure( SYS_QUIT,     @Quit );

OE_SetScreenOptions( 800, 600, 32, 0, TRUE, FALSE );

//Запускаем движок
OE_Init;

end.

