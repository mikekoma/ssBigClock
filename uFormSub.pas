unit uFormSub;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, IxPainter, IxSettings;

type
  TFormSub = class(TForm)
    Timer1: TTimer;
    procedure FormPaint(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure Timer1Timer(Sender: TObject);
    procedure FormResize(Sender: TObject);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  private
    { Private 宣言 }
    before_time: string;
    mouse_x, mouse_y: Integer;
    timer_count1: Integer;
    EnableInput: boolean;
  public
    { Public 宣言 }
    Painter: TIxPainter;
    procedure WMSysCommand(var Msg: TWMSysCommand); message WM_SYSCOMMAND;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
  end;

var
  FormSub: TFormSub;

implementation

{$R *.dfm}

uses uFormMain;

// ====================================================================
//
// ====================================================================
procedure TFormSub.CreateParams(var Params: TCreateParams);
begin
  Inherited;

  if hwndParam = 0 then
  begin
    Params.ExStyle := Params.ExStyle or WS_EX_TOPMOST; { ウィンドウを最前面に配置 }
  end
  else
  begin
    Params.WndParent := hwndParam; { 親ウィンドウハンドル }
    Params.Style := WS_CHILD or WS_DISABLED or WS_VISIBLE; { タイトルバーのないウィンドウ }
    Params.WindowClass.Style := CS_PARENTDC; { 親ウィンドウのデバイスコンテキストを継承 }
  end;
end;

// ====================================================================
//
// ====================================================================
procedure TFormSub.FormCreate(Sender: TObject);
begin
  Painter := TIxPainter.Create;

  EnableInput := false;
  timer_count1 := 500;

  if hwndParam = 0 then
  begin
    ShowCursor(false); // カーソル非表示
    ImeMode := imDisable; // IMEウィンドウを表示させない
  end;

  before_time := '';
  Timer1.Enabled := true;
end;

// ====================================================================
//
// ====================================================================
procedure TFormSub.FormDestroy(Sender: TObject);
begin
  ShowCursor(true);
  Painter.Free;
end;

// ====================================================================
//
// ====================================================================
procedure TFormSub.FormResize(Sender: TObject);
begin
  Painter.SetSize(Width, Height);
end;

// ====================================================================
// 二重起動防止
// ====================================================================
procedure TFormSub.WMSysCommand(var Msg: TWMSysCommand);
begin
  if Msg.CmdType = SC_SCREENSAVE then
    Msg.Result := 1
  else
    inherited;
end;

// ====================================================================
// ちらつき防止
// ====================================================================
procedure TFormSub.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  // ちらつき防止
end;

// ====================================================================
//
// ====================================================================
procedure TFormSub.FormClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFormSub.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  Application.Terminate;
end;

procedure TFormSub.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if EnableInput then
  begin
    if (mouse_x <> X) or (mouse_y <> Y) then
      Application.Terminate;
  end;
  mouse_x := X;
  mouse_y := Y;
end;

// ====================================================================
//
// ====================================================================
procedure TFormSub.FormPaint(Sender: TObject);
begin
  Painter.Paint(Canvas);
end;

// ====================================================================
//
// ====================================================================
procedure TFormSub.Timer1Timer(Sender: TObject);
var
  str: string;
begin
  if timer_count1 > 0 then
  begin
    dec(timer_count1, Timer1.Interval);
    if timer_count1 <= 0 then
    begin
      EnableInput := true;
    end;
  end;

  DateTimeToString(str, 'nn', Now);
  if before_time <> str then
  begin
    before_time := str;
    Painter.DrawBackground;
  end;

  Invalidate;
end;

end.
