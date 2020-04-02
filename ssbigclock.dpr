program ssbigclock;

uses
  Windows,
  SysUtils,
  Vcl.Forms,
  uFormMain in 'uFormMain.pas' {FormMain} ,
  uFormSub in 'uFormSub.pas' {FormSub} ,
  uSeupDialog in 'uSeupDialog.pas' {SetupDialog};

{$R *.res}

var
  s: string;
  setdlg: TSetupDialog;

begin
  if ParamCount = 0 then
    { �G�N�X�v���[���̉E�N���b�N�Őݒ��I�������ꍇ�A�����͂Ȃ� }
    s := '/C'
  else
    s := UpperCase(ParamStr(1));

  hwndParam := 0;
  case s[2] of
    'C':
      begin
        { �ݒ�_�C�A���O }
        ShowWindow(Application.Handle, SW_HIDE);
        setdlg := TSetupDialog.Create(nil);
        setdlg.ShowModal;
        setdlg.Free;
      end;
    'P':
      begin
{$IF false}
        { �v���r���[ }
        ShowWindow(Application.Handle, SW_HIDE);
        try
          hwndParam := StrToInt(ParamStr(2));
        except
          hwndParam := 0;
        end;
        Application.Initialize;
        Application.CreateForm(TFormMain, FormMain);
        Application.Run;
{$ENDIF}
      end;
  else
    begin
      { /S }
      Application.Initialize;
      Application.MainFormOnTaskbar := False;
      Application.CreateForm(TFormMain, FormMain);
      Application.Run;
    end;
  end;

end.
