unit uSeupDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  VCLTee.TeCanvas, IxSettings;

type
  TSetupDialog = class(TForm)
    btnOk: TButton;
    btnCancel: TButton;
    FontDialog1: TFontDialog;
    btnFont: TButton;
    btnFontColor: TButtonColor;
    btnBGColor: TButtonColor;
    Label1: TLabel;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnFontClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private êÈåæ }
    Settings: TIxSettings;
  public
    { Public êÈåæ }
  end;

var
  SetupDialog: TSetupDialog;

implementation

{$R *.dfm}

procedure TSetupDialog.btnFontClick(Sender: TObject);
begin
  FontDialog1.Font.Name := btnFont.Caption;
  if FontDialog1.Execute then
  begin
    btnFont.Caption := FontDialog1.Font.Name;
  end;
end;

procedure TSetupDialog.FormCreate(Sender: TObject);
begin
  Settings := TIxSettings.Create;

  btnFont.Caption := Settings.FontName;
  btnFontColor.SymbolColor := Settings.FontColor;
  btnBGColor.SymbolColor := Settings.BGColor;
end;

procedure TSetupDialog.btnOkClick(Sender: TObject);
begin
  Settings.FontName := btnFont.Caption;
  Settings.FontColor := btnFontColor.SymbolColor;
  Settings.BGColor := btnBGColor.SymbolColor;
  Settings.Save;
  Settings.Free;

  Close;
end;

procedure TSetupDialog.btnCancelClick(Sender: TObject);
begin
  Settings.Free;
  Close;
end;

end.
