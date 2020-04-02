unit uFormMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Generics.Collections, uFormSub,
  Vcl.StdCtrls, Vcl.ExtCtrls, IxPainter;

{$DEFINE xDEBUG_TOP_SHIFT}

type
  TFormMain = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
  private
    { Private 宣言 }
    Forms: TObjectList<TFormSub>;
    before_time: string;
    mouse_x, mouse_y: Integer;
    timer_count1: Integer;
    Painter: TIxPainter;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public 宣言 }
    EnableInput: boolean;
    procedure show_screensaver;
    procedure show_preview;
    procedure WMSysCommand(var Msg: TWMSysCommand); message WM_SYSCOMMAND;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
  end;

var
  FormMain: TFormMain;
  hwndParam: THandle;

implementation

{$R *.dfm}

// ====================================================================
//
// ====================================================================
procedure TFormMain.CreateParams(var Params: TCreateParams);
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
procedure TFormMain.FormCreate(Sender: TObject);
begin
  Forms := TObjectList<TFormSub>.Create;
  Painter := TIxPainter.Create;

  EnableInput := false;
  timer_count1 := 500;

  if hwndParam = 0 then
  begin
    ShowCursor(false); // カーソル非表示
    ImeMode := imDisable; // IMEウィンドウを表示させない
    show_screensaver;
  end
  else
  begin
    show_preview;
  end;

  before_time := '';
  Timer1.Enabled := true;
end;

// ====================================================================
//
// ====================================================================
procedure TFormMain.FormDestroy(Sender: TObject);
begin
  Painter.Free;
  Forms.Free;
end;

// ====================================================================
//
// ====================================================================
procedure TFormMain.FormResize(Sender: TObject);
begin
  Painter.SetSize(Width, Height);
end;

// ====================================================================
// 二重起動防止
// ====================================================================
procedure TFormMain.WMSysCommand(var Msg: TWMSysCommand);
begin
  if Msg.CmdType = SC_SCREENSAVE then
    Msg.Result := 1
  else
    inherited;
end;

// ====================================================================
// ちらつき防止
// ====================================================================
procedure TFormMain.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  // ちらつき防止
end;

// ====================================================================
//
// ====================================================================
procedure TFormMain.FormClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFormMain.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  Application.Terminate;
end;

procedure TFormMain.FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
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
procedure TFormMain.FormPaint(Sender: TObject);
begin
  Painter.Paint(Canvas);
end;

// ====================================================================
//
// ====================================================================
procedure TFormMain.Timer1Timer(Sender: TObject);
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
    Invalidate;
  end;
end;

// ====================================================================
// スクリーンセーバーの設定ダイアログ上に表示
// ====================================================================
procedure TFormMain.show_preview;
var
  r: TRect;
  preview_w, preview_h: Integer;
begin
  GetWindowRect(hwndParam, r);
  preview_w := r.Right - r.Left;
  preview_h := r.Bottom - r.Top;
  Width := preview_w;
  Height := preview_h;
end;

// ====================================================================
// スクリーンセーバー表示
// ====================================================================
procedure TFormMain.show_screensaver;
var
  i: Integer;
  form_sub: TFormSub;
  monitor: TMonitor;
begin
  for i := 0 to Screen.MonitorCount - 1 do
  begin
    monitor := Screen.Monitors[i];
    if i = 0 then
    begin
      Show;
{$IFDEF DEBUG_TOP_SHIFT}
      Top := monitor.Height div 4 * 1; // デバッグ用にウィンドウを下へずらす
{$ELSE}
      Top := monitor.Top;
{$ENDIF}
      Left := monitor.Left;
      Width := monitor.Width;
      Height := monitor.Height;
    end
    else
    begin
      form_sub := TFormSub.Create(self);
      form_sub.Show;
{$IFDEF DEBUG_TOP_SHIFT}
      form_sub.Top := monitor.Height div 4 * 1; // デバッグ用にウィンドウを下へずらす
{$ELSE}
      form_sub.Top := monitor.Top;
{$ENDIF}
      form_sub.Left := monitor.Left;
      form_sub.Width := monitor.Width;
      form_sub.Height := monitor.Height;
      form_sub.Tag := i;
      Forms.Add(form_sub);
    end;
  end;
end;

end.
