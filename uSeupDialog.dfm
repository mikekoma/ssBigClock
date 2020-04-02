object SetupDialog: TSetupDialog
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Setup'
  ClientHeight = 162
  ClientWidth = 257
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 25
    Top = 8
    Width = 207
    Height = 13
    Caption = 'Suns && Moon Laboratory ssBigClock Ver001'
  end
  object btnOk: TButton
    Left = 51
    Top = 125
    Width = 75
    Height = 25
    Caption = ' &Ok'
    Default = True
    TabOrder = 0
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 132
    Top = 125
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Cancel'
    TabOrder = 1
    OnClick = btnCancelClick
  end
  object btnFont: TButton
    Left = 9
    Top = 32
    Width = 240
    Height = 25
    Caption = 'Font'
    TabOrder = 2
    OnClick = btnFontClick
  end
  object btnFontColor: TButtonColor
    Left = 9
    Top = 63
    Width = 240
    Caption = 'Font Color'
    TabOrder = 3
  end
  object btnBGColor: TButtonColor
    Left = 9
    Top = 94
    Width = 240
    Caption = 'Back Ground Color'
    TabOrder = 4
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Left = 8
    Top = 88
  end
end
