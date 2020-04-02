unit uFormMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Generics.Collections, uFormSub,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFormMain = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private êÈåæ }
    Forms: TObjectList<TFormSub>;
  public
    { Public êÈåæ }
    procedure memo(str: string);
    procedure show_sub;
  end;

var
  FormMain: TFormMain;
  hwndParam: THandle;

implementation

{$R *.dfm}

procedure TFormMain.Button1Click(Sender: TObject);
begin
  show_sub;
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  Forms := TObjectList<TFormSub>.Create;
  Hide;
  show_sub;
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  Forms.Free;
end;

procedure TFormMain.memo(str: string);
begin
  Memo1.Lines.Add(str);
end;

procedure TFormMain.show_sub;
var
  i: integer;
  form_sub: TFormSub;
  monitor: TMonitor;
begin
  for i := 0 to Screen.MonitorCount - 1 do
  begin
    monitor := Screen.Monitors[i];
    form_sub := TFormSub.Create(self);
    form_sub.Show;
    form_sub.Top := monitor.Top;
    // form_sub.Top := monitor.Height div 4 * 3; // monitor.Top;
    form_sub.Left := monitor.Left;
    form_sub.Width := monitor.Width;
    form_sub.Height := monitor.Height;
    form_sub.Tag := i;
    Forms.Add(form_sub);

    memo(monitor.Top.ToString + ' ' + monitor.Left.ToString);
  end;
end;

end.
