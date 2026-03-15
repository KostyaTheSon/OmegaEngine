////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                           O M E G A  E N G I N E                           //
//                                  D E M O                                   //
//                                                                            //
//    Единственный пример для показа того что умеет модуль uGUIEngine         //
//                                                                            //
//  (C)2006 Andru 'aka' KEMKA ANDREY.                                         //
//  web  : HTTP://isada.mirgames.ru                                           //
//  eMail: Andru_@list.ru                                                     //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////
program Demo;

uses
  OMEGA in '..\..\..\headers\Delphi\OMEGA.pas', // подключаем хедер движка
  uSpriteEngine in '..\..\..\units\Delphi\uSpriteEngine.pas', // подключаем хедер спрайтового движка
  uGUIEngine in '..\..\..\units\Delphi\uGUIEngine.pas'; // подключаем хедер GUI

var
  MyTimer1 : PTimer;

  GUI    : CGUIEngine; // Наш движок GUI
  MyFont : PFont2D;

// Любай функция которую может вызвать "компонент" имеет свой синтаксис
// например тут это:
// mButton - кнопка мыши которой было нажато на кнопку
// два постоянных параметра:
// Sender, Parent - обьект на который было нажато и его родитель
procedure bExit( mButton : Byte; Sender, Parent : CGUIElement );
Begin
if mButton = M_LBUTTON Then OE_Quit;
End;

procedure Init;
  var
    id : Integer;
Begin

MyFont := Text_LoadFontFromFile( '..\..\Media\consoleFont.gif', '..\..\Media\consoleFontInfo.ofi' );

// Создаем GUI
GUI := CGUIEngine.Create;
// Разрешаем переключения между окнами
GUI.TabWindows  := TRUE;

// Создаем окно и получаем на него ID
id := GUI.AddWindow( nil,        // без текстуры
                     100, 100,   // X, Y
                     256, 256 ); // Ширина/высота
with GUI.List[ id ] as CGUIWindow do
  begin
    // ставим высоту шапки окна
    CaptionHeight := 20;
    // Разрешаем перемещение окна
    CanMove := TRUE;
    // Создаем кнопку
    id := AddButton( nil, 'Exit', MyFont, 100, 100, 56, 28, 255, @bExit );
    // после этого можно обратится к элементу например так:
    // with eList[ id ] as CGUIButton do
  end;

id := GUI.AddWindow( nil, 200, 200, 256, 256 );
with GUI.List[ id ] as CGUIWindow do
  begin
    // ставим высоту шапки окна
    CaptionHeight := 20;
    // Создаем кнопку
    id := AddButton( nil, 'Exit 2', MyFont, 100, 100, 56, 28, 255, @bExit );
  end;

End;

procedure Draw;
Begin

// Рисуем весь GUI
GUI.Draw;

End;

procedure Timer1;
Begin

// Обрабатываем все процесы GUI. Делать только после всех своих обработок, желательно.
GUI.Process;

End;

begin

MyTimer1 := Timer_Create( @Timer1, 16 );

// Назначаем "системные" процедуры
OE_RegProcedure( SYS_INIT,     @Init ); // Инициализация
OE_RegPRocedure( SYS_DRAW,     @Draw ); // Отрисовка

// Устанавливаем настройки экрана
OE_SetScreenOptions( 800, 600, 32, 0, TRUE, FALSE );
OE_ShowCursor( TRUE );

// И самое простое=) Запускаем движок
OE_Init;

end.

