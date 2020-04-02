unit uFormSub;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls;

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
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  private
    { Private �錾 }
    bg_bmp: TBitmap;
    before_time: string;
    mouse_x, mouse_y: Integer;
    timer_count1: Integer;
  public
    { Public �錾 }
    EnableInput: boolean;
    procedure draw_screen(tgt_canvas: TCanvas);
    procedure WMSysCommand(var Msg: TWMSysCommand); message WM_SYSCOMMAND;
  end;

var
  FormSub: TFormSub;

implementation

{$R *.dfm}

uses uFormMain;

procedure TFormSub.CreateParams(var Params: TCreateParams);
begin
  Inherited;

  if hwndParam = 0 then
  begin
    Params.ExStyle := Params.ExStyle or WS_EX_TOPMOST; { �E�B���h�E���őO�ʂɔz�u }
  end
  else
  begin
    Params.WndParent := hwndParam; { �e�E�B���h�E�n���h�� }
    Params.Style := WS_CHILD or WS_DISABLED or WS_VISIBLE; { �^�C�g���o�[�̂Ȃ��E�B���h�E }
    Params.WindowClass.Style := CS_PARENTDC; { �e�E�B���h�E�̃f�o�C�X�R���e�L�X�g���p�� }
  end;
end;

procedure TFormSub.draw_screen(tgt_canvas: TCanvas);
var
  str: string;
begin
  // �`��p�����[�^
  bg_bmp.Canvas.Brush.Color := clBlack;
  bg_bmp.Canvas.Brush.Style := bsSolid;
  bg_bmp.Canvas.Font.Name := 'Segoe UI Black';
  bg_bmp.Canvas.Font.Color := $202020;
  bg_bmp.SetSize(Width, Height);

  // �h��Ԃ�
  bg_bmp.Canvas.FillRect(Rect(0, 0, Width, Height));

  // �`��
  DateTimeToString(str, 'hh:nn', Now);

  // �t�H���g�T�C�Y�v�Z
  bg_bmp.Canvas.Font.Height := bg_bmp.Canvas.TextHeight(str) * Width div bg_bmp.Canvas.TextWidth(str);
  if bg_bmp.Canvas.Font.Height > bg_bmp.Canvas.TextWidth(str) * Height div bg_bmp.Canvas.TextHeight(str) then
    bg_bmp.Canvas.Font.Height := bg_bmp.Canvas.TextWidth(str) * Height div bg_bmp.Canvas.TextHeight(str);

  // ������`��
  bg_bmp.Canvas.TextOut((Width - bg_bmp.Canvas.TextWidth(str)) div 2, (Height - bg_bmp.Canvas.TextHeight(str))
    div 2, str);
  tgt_canvas.Draw(0, 0, bg_bmp);
  // tgt_canvas.TextOut(0, 0, Tag.ToString);
end;

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

procedure TFormSub.FormCreate(Sender: TObject);
begin
  bg_bmp := TBitmap.Create;
  ShowCursor(false);
  { IME�E�B���h�E��\�������Ȃ� }
  ImeMode := imDisable;
  EnableInput := false;
  before_time := '';
  timer_count1 := 500;
end;

procedure TFormSub.FormDestroy(Sender: TObject);
begin
  ShowCursor(true);
  bg_bmp.Free;
end;

procedure TFormSub.FormPaint(Sender: TObject);
begin
  draw_screen(Canvas);
end;

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
    Invalidate;
  end;
end;

procedure TFormSub.WMSysCommand(var Msg: TWMSysCommand);
begin
  if Msg.CmdType = SC_SCREENSAVE then
    Msg.Result := 1
  else
    inherited;
end;

end.
