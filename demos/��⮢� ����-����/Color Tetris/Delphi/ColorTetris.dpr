////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//    ##### ##### #     ##### ####     ##### ##### ##### ####   ###  #####    //
//    #     #   # #     #   # #   #      #   #       #   #   #   #  #         //
//    #     #   # #     #   # #   #      #   ###     #   #   #   #   ####     //
//    #     #   # #     #   # ####       #   #       #   ####    #       #    //
//    ##### ##### ##### ##### #   #      #   #####   #   #   #  ### #####     //
//                                                                            //
//                             V E R S O N  1 . 1                             //
////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//  Автор: Шпилько Константин 'aka' Armorer                                   //
//  Почта: admin@armorer.fatal.ru                                             //
//                                                                            //
//  Версия 1.1                                                                //
//  Автор: Andru 'aka' Кемка Андрей                                           //
//  eMail: Andru_@list.ru                                                     //
//                                                                            //
//  Если увидите какие ошибки относительно алгоритмов игры, то обращайтесь к  //
//  автору оригинала                                                          //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////
program ColorTetris;

{$R ColorTetris.res}    //Подключает иконку

uses
  OMEGA in '..\..\..\..\headers\Delphi\OMEGA.pas';

type
  TRecord = record       // Тип рекорда
    Name  : String[20];  // Имя рекордсмена
    Point : WORD;        // Набранные очки
end;

TGame = class
  Ar     : array[ 0..9, 0..16 ] of Byte;   // Массив, в котором хранится игровое поле
  Scene  : 0..3;        // Состояние игры: 0 - Ничего, 1 - Идет игра, 2 - Ввод имени победителем, 3 - Пауза
  Sound  : Boolean;     // вкл/вык Звук
  Tic    : WORD;        // Эта переменная нужна для установки уровня сложности
  Point  : WORD;        // Очки, набранные игроком
  Lavel  : Byte;        // Уровень сложности
  sLavel : Byte;        // Измененный уровень сложности
  Text   : String[20];  // Текст, который должен выводится на экран (Вроде "Game Over")

  Rec    : TRecord;     //Последний лучший результат
  Fig : record
    X1, Y, Num : Byte;    // Координаты падающей фигуры и размер
    ifMove     : Boolean; // Может ли фигура двигаться влево и вправо игроком
  end;
  Texture : record      // Идентификаторы текстур
    Fon, Brick : PTexture;
  end;
  Font : PFont2D;
end;

var
 Game      : TGame;
 GameTimer : PTimer;

 Sound1 : PSound;
 Sound2 : PSound;
 Sound3 : PSound;

 EnterText : Boolean;

{Процедура воспроизведения звука}
procedure Sound_Play( Sound : PSound );
begin
if Game.Sound Then   // Если звук включён
  Snd_Play( Sound ); // проигрывать звук
end;

{Процедура загрузки и сохранения рекорда  }
procedure LoadSaveRecord( Sav : Boolean );  //True - Save, False - Load
  var
    F : File of TRecord;
begin
AssignFile( F, 'score.dat' );
if Sav Then
  begin
    Rewrite( F );
    Write( F, Game.Rec );
  end else
    begin
      Reset( F);
      Read( F, Game.Rec );
    end;
CloseFile( F );
end;

{Процедура, происходящая при инициализации движка}
procedure Init;
begin
Game := TGame.Create;  // Создание главного игрового объекта

{ЗАГРУЗКА ТЕКСТУР}
Game.Font          := Text_LoadFontFromFile( '..\Media\Font.gif', '..\Media\FontInfo.ofi', 0 );
Game.Texture.Fon   := Tex_LoadFromFile( '..\Media\BackGround.jpg', -1,      TEX_DEFAULT_2D );
Game.Texture.Brick := Tex_LoadFromFile( '..\Media\Brick.bmp',      $000000, TEX_DEFAULT_2D );

{ЗАГРУЗКА ЗВУКОВ}
Snd_Init; // Инициализация звуковой подсистемы (Необходимо сделать перед загрузкой звуков)
Sound1 := Snd_LoadFromFile( '..\Media\sound1.wav', 2 );
Sound2 := Snd_LoadFromFile( '..\Media\sound2.wav', 2 );
Sound3 := Snd_LoadFromFile( '..\Media\sound3.wav', 2 );

Game.sLavel := 5;        // Установка уровня сложности
Game.Text := ' ';        // Не выводить текст на экран
Game.Sound := TRUE;      // Включить звук
LoadSaveRecord( FALSE ); // Загрузка рекорда
end;

{Процедура, происходящая при завершении работы программы}
procedure Quit;
begin
Game.Free;
Game := nil;
// Очистку остальных ресурсов сделает движок
end;

{Процедура, которая рисует}
procedure Draw;
  var
   i, j : Integer;
   Str  : String;
begin

SSprite_Draw( Game.Texture.Fon, 0, 0, 800, 600 ); // Рисование фона

for i := 0 to 9 do      //Прогоняем в цикле  весь массив
  for j := 0 to 16 do
    if Game.Ar[ i, j ] > 0 Then // Если не пусто
      begin
        Case Game.Ar[ i, j ] of      //Рисует квадратик нужного цвета, по специальной формуле
        1 : FX_SetColorMix( $0000FF );
        2 : FX_SetColorMix( $00FF00 );
        3 : FX_SetColorMix( $FF0000 );
        end; //Case
        SSprite_Draw( Game.Texture.Brick, i * 35 + 226, j * 35 + 1, 34, 34, 255, 0, FX_DEFAULT or FX_COLORMIX );
      end;

Text_Draw( Game.Font, 680, 30, U_IntToStr( Game.Point ), 1, 0, 255, $FFFFFF ); // Выводит количесво набранных очков
Text_Draw( Game.Font, 753, 63, U_IntToStr( Game.sLavel ), 1, 0, 255, $FFFFFF ); // Выводит уровень сложности

Str := Game.Rec.Name;
Text_Draw( Game.Font, 610, 138, PChar(Str), 1, 0, 255, $FFFFFF ); // Выводит последний рекорд
Text_Draw( Game.Font, 610, 162, U_IntToStr( Game.Rec.Point ), 1, 0, 255, $FFFFFF );

Str := Game.Text;
Text_Draw( Game.Font, 240, 20, PChar(Str), 1, 0, 255, $FFFFFF );//Выводит текст
end;

{Процедура, в которой появляется новая фигура}
procedure Next;
  var
    X, i, j : Integer;
begin

for j := 0 to 16 do   // Сначала проверяем, нет ли линии из 4 квадратиков одного цвета по горизонтали
  for i := 0 to 7 do
    if ( Game.Ar[ i, j ] > 0 )                   and
       ( Game.Ar[ i, j ] = Game.Ar[ i + 1, j ] ) and
       ( Game.Ar[ i, j ] = Game.Ar[ i + 2, j ] ) and
       ( Game.Ar[ i, j ] = Game.Ar[ i + 3, j ] ) Then
      begin
        if Game.Ar[ i, j ] = Game.Ar[ i + 4, j ] Then  // Если квадратиков 5
          begin
            Game.Ar[ i + 4, j ] := 0;      // Убрать пятый
            INC( Game.Point, Game.Lavel ); // Добавить очки
            if Game.Ar[ i, j ] = Game.Ar[ i + 5, j ] Then // Тоже если 6 квадратов
              begin
                Game.Ar[ i + 5, j ] := 0;
                INC( Game.Point, Game.Lavel );
              end;
          end;
        Game.Ar[ i,     j ] := 0;      // Убрать 4 квадрата
        Game.Ar[ i + 1, j ] := 0;
        Game.Ar[ i + 2, j ] := 0;
        Game.Ar[ i + 3, j ] := 0;
        INC( Game.Point, Game.Lavel ); // Увеличить очки
        Sound_Play( Sound1 );          // Воспроизвести звук
      end;

for i := 0 to 9 do // Аналогично по вертикали
  for j := 0 to 14 do
    if ( Game.Ar[ i, j ] > 0 )                   and
       ( Game.Ar[ i, j ] = Game.Ar[ i, j + 1 ] ) and
       ( Game.Ar[ i, j ] = Game.Ar[ i, j + 2 ] ) and
       ( Game.Ar[ i, j ] = Game.Ar[ i, j + 3 ] ) Then
      begin
        if Game.Ar[ i, j ] = Game.Ar[ i, j + 4 ] Then
          begin
            Game.Ar[ i, j + 4 ] := 0;
            INC( Game.Point, Game.Lavel );
            if Game.Ar[ i, j ] = Game.Ar[ i, j + 5 ] Then
              begin
                Game.Ar[ i, j + 5 ] := 0;
                INC( Game.Point, Game.Lavel );
              end;
          end;
        Game.Ar[ i, j     ] := 0;
        Game.Ar[ i, j + 1 ] := 0;
        Game.Ar[ i, j + 2 ] := 0;
        Game.Ar[ i, j + 3 ] := 0;
        INC( Game.Point, Game.Lavel );
        Sound_Play( Sound1 );
      end;

Case Random( 3 ) of // Случайным образом получить новую фигуру
  0:
    begin
      X               := Random( 10 );
      Game.Ar[ X, 0 ] := Random( 3 ) + 1;
      Game.Fig.Num    := 0;
    end;
  1:
    begin
      X                   := Random( 9 );
      Game.Ar[ X,     0 ] := Random( 3 ) + 1;
      Game.Ar[ X + 1, 0 ] := Random( 3 ) + 1;
      Game.Fig.Num        := 1;
    end;
  2:
    begin
      X                   := Random( 8 );
      Game.Ar[ X,     0 ] := Random( 3 ) + 1;
      Game.Ar[ X + 1, 0 ] := Random( 3 ) + 1;
      Game.Ar[ X + 2, 0 ] := Random( 3 ) + 1;
      Game.Fig.Num        := 2;
    end;
end; //Case

Game.Fig.X1     := X;    // Установка координат на положение новой фигуры
Game.Fig.Y      := 0;
Game.Fig.ifMove := TRUE; // Фигуру можно двигать
end;

{Процедура, возникающая при проигрыше}
procedure GameOver;
begin
Game.Scene := 0;    // Установка состояния игры в положение "Ничего"
if Game.Rec.Point < Game.Point then   //Если игрок набрал больше очков, чем был предыдущий рекорд
  begin
    Game.Text := 'Введите ваше имя';

    Game.Scene     := 2;           // Читать введенное пользователем имя
    Game.Rec.Point := Game.Point;
    Game.Rec.Name  := ' ';         // Перед чтением стереть предыдущее имя
  end else                         // Если нет вывести текст: 'GameOver'
    Game.Text := 'GameOver';
end;

{Процедура, которая возникает при ускорении}
procedure Tic1;
  var
   i, j : Integer;
begin
for i := 9 downto 0 do         //Проходит по всему массиву
  for j := 15 downto 0 do
    if ( Game.Ar[ i, j ] > 0 ) Then           // Если клетка не пустая и...
      if not ( Game.Ar[ i, j + 1 ] > 0) Then  // ...под ней пусто
        begin
          Game.Ar[ i, j + 1 ] := Game.Ar[ i, j ]; // Переместить квадратик
          Game.Ar[ i, j ] := 0;                   //Отчистить предыдущее его место
        end else
        {если под клеткой с квадратиком не пусто и эта клетка является частью
         фигуры то запретить перемещение фигуры
         Это делается, для того чтобы, когда одна часть фигуры
         не может двигаться вниз (из-за того, что там место занято),
         а другая продолжает движение, игрок не мог перемещать её. }
          if ( Game.Fig.Y = j ) and
             ( ( Game.Fig.Num = 1 ) and ( ( Game.Fig.X1 = i ) or ( Game.Fig.X1 + 1 = i ) ) or
             ( ( Game.Fig.Num = 2 ) and ( ( Game.Fig.X1 = i ) or ( Game.Fig.X1 + 1 = i ) ) or ( Game.Fig.X1 + 2 = i ) ) )
          Then
            Game.Fig.ifMove := FALSE;

INC( Game.Fig.Y ); // Изменить координаты фигуры
end;

{Процедура без названия :) }
procedure Tic;
  var
    i, j : Integer;
    L    : Boolean; // Определяет, упала ли предыдущая фигура
begin
L := TRUE;
for i := 9 downto 0 do
  for j := 15 downto 0 do
    if ( Game.Ar[ i, j ] > 0 ) Then
      if not( Game.Ar[ i, j + 1 ] > 0) Then
        begin
          Game.Ar[ i, j + 1 ] := Game.Ar[ i, j ];
          Game.Ar[ i, j ]     := 0;
          L := FALSE; // Если что-то может двигаться вниз, значит, фигура не упала
        end else
          if ( Game.Fig.Y = j ) and
             ( ( Game.Fig.Num = 1 ) and ( ( Game.Fig.X1 = i ) or ( Game.Fig.X1 + 1 = i ) ) or
             ( ( Game.Fig.Num = 2 ) and ( ( Game.Fig.X1 = i ) or ( Game.Fig.X1 + 1 = i ) ) or ( Game.Fig.X1 + 2 = i ) ) )
          Then
            Game.Fig.ifMove := FALSE;

for I := 0 to 9 do        // Если на самом верху остались квадраты
  if Game.Ar[ i, 0 ] > 0 Then
    begin
      GameOver;           // Значит игра закончена
      Sound_Play( Sound3 );
    end;

INC( Game.Fig.Y );  // Изменить координаты фигуры
if L then           // Если фигура упала, значит, нужна новая
  Next;
end;

{Происходит при начале новой игры}
procedure NewGame;
  var
    i, j : Integer;
begin
if Game.Sound Then
  Media_Play( '..\media\music.mid', TRUE );
for i := 0 to 9 do      // Отчистка поля
  for j := 0 to 16 do
    Game.Ar[ i, j ] := 0;

Game.Lavel := Game.sLavel;  // Установка уровня сложности
Game.Scene := 1;
Game.Point := 0;            // Обнуление очков
Game.Text  := ' ';
Next;
end;

{Перемещение игроком фигуры влево}
procedure Left;
  var
    i : Integer;
begin
if Game.Scene = 1 Then    // Если сейчас идет игра
  with Game.Fig do
    begin
      if X1 > 0 Then                //Если фигура не в крайнем левом положении
        if not( Game.Ar[ X1 - 1, Y ] > 0 ) Then    //Если слева от фигуры ничего нет
          begin
            for I := 0 to Num do                   // Передвинуть фигуру
              Game.Ar[ X1 - 1 + i, Y ] := Game.Ar[ X1 + i, Y ];

            Game.Ar[ X1 + Num, Y ] := 0;
            DEC( X1 );      // Изменить координаты фигуры
          end;
    end;  // With

end;

{Перемещение игроком фигуры вправо}
procedure Right;
  var
    i : Integer;
begin
if Game.Scene = 1 Then
  with Game.Fig do
    begin
      if X1 < 9 - Num Then
        if not ( Game.Ar[ X1 + 1 + Num, Y ] > 0 ) Then
          begin
            for i := 0 to Num do
              Game.Ar[ X1 + 1 - i + Num, Y ] := Game.Ar[ X1 - I + Num, Y ];

            Game.Ar[ X1, Y ] := 0;
            INC( X1 );
          end;
    end; //With
end;

{Процедура, обработки ввода и игровой таймер}
procedure Timer;
begin
INC( Game.Tic );     // Увеличить значение таймера

if Key_Press( K_ESCAPE ) Then   //Если нажат Esc закрыть программу
  OE_Quit;

if Game.Scene <> 2 then  // Если сейчас игрок не вводит своё имя
  begin
    if Key_Press( K_S ) Then
      NewGame;

    if Key_Press( K_A ) Then         // вкл/выключение звука
      begin
        Game.Sound := not( Game.Sound );
        Snd_Play( Sound2 );
        if Game.Sound Then
          Media_Resume
        else
          Media_Pause;
      end;

    if ( Key_Down( K_LEFT ) ) and Game.Fig.ifMove Then
      Left;

    if ( Key_Down( K_RIGHT ) ) and Game.Fig.ifMove Then
      Right;

    if Key_Down( K_DOWN ) and ( Game.Scene = 1 ) Then // если зажата клавиша Down и идёт игра
      Tic1;

    if ( Key_Press( K_SUBTRACT ) ) and ( Game.sLavel > 1 ) Then // Изменение уровня сложности
      begin
        DEC( Game.sLavel );
        Sound_Play( Sound2 );
      end;
    if ( Key_Press( K_ADD ) ) and ( Game.sLavel < 10 ) Then
      begin
        INC( Game.sLavel );
        Sound_Play( Sound2 );
      end;

    if ( Key_Press( K_P ) ) and not ( Game.Scene = 0 ) Then // Если нажата клавиша P и идёт игра
      if Game.Scene = 1 Then    // Если идет игра
        begin
          Game.Text := 'Pause'; // Вывести сообщение
          Game.Scene := 3;      // Остановить игру
        end else
          begin               // Если игра не идет
            Game.Text := ' '; // Убрать сообщение
            Game.Scene := 1;  // Возобновить игру
          end;
  end else // Если идёт ввод
    begin
      if not EnterText Then
        begin
          Key_BeginReadText( nil );
          EnterText := TRUE;
        end;
      if Key_Press( K_ENTER ) Then // Если нажат Enter
        begin
          Game.Scene := 0;         // Остановить ввод
          LoadSaveRecord( TRUE );  // Сохранить рекорд
          Game.Rec.Name := Key_EndReadText;
          EnterText     := FALSE;
        end;
      Game.Rec.Name := Key_EndReadText;
    end;

  if ( Game.Scene = 1 ) and ( Game.Tic >= 10 - Game.Lavel ) Then   // Если идет игра,
    begin               // в зависимости от уровня сложности опускать квадратики
      Tic;
      Game.Tic := 0; // Обнулить таймер
    end;
end;


begin

Randomize;

OE_SetScreenOptions( 800, 600, 32, 0, TRUE, TRUE  );   //Установка параметров экрана

//Регистрация процедур
OE_RegProcedure( SYS_INIT, @Init ); // Надо иногда читать справку к движку :)
OE_RegProcedure( SYS_DRAW, @Draw );
OE_RegProcedure( SYS_QUIT, @Quit );

GameTimer := Timer_Create( @Timer, 40 );

OE_Disable( FLAG_CLEAR_COLOR_BUFFER ); // Выключаем очистку буфера цвета для оптимизации
OE_Disable( FLAG_CROP_UNVISIBLE_OBJ ); // Выключаем отрезку невидных обьектов,
                                       // потому как все в пределах одного экрана

OE_SetAdvancedOptions( TRUE ); //Включить движковый лог
OE_Init; // Запуск движка
end.
