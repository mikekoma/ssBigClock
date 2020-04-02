unit uSeupDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TSetupDialog = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private êÈåæ }
  public
    { Public êÈåæ }
  end;

var
  SetupDialog: TSetupDialog;

implementation

{$R *.dfm}

procedure TSetupDialog.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TSetupDialog.Button2Click(Sender: TObject);
begin
  Close;
end;

end.
