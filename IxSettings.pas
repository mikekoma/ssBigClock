unit IxSettings;

interface

uses System.Classes, System.IniFiles, System.IOUtils, System.SysUtils, Vcl.Graphics;

const
  SECT_SETTINGS = 'Settings';
  IDENT_FONTNAME = 'FontName';
  IDENT_FONTCOLOR = 'FontColor';
  IDENT_BGCOLOR = 'BGColor';

type
  TIxSettings = Class(TObject)
  protected
    function ini_fname: string;
  public
    FontName: string;
    FontColor: TColor;
    BGColor: TColor;
    Constructor Create;
    procedure Load;
    procedure Save;
  End;

implementation

{ TIxSettings }

constructor TIxSettings.Create;
begin
  Load;
end;

function TIxSettings.ini_fname: string;
var
  str: string;
begin
  str := TPath.Combine(TPath.GetHomePath, 'SSSM');
  str := TPath.Combine(str, 'ssBigClock');
  Result := TPath.Combine(str, 'ssbigclock.ini');
end;

procedure TIxSettings.Load;
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(ini_fname);
  try
    FontName := ini.ReadString(SECT_SETTINGS, IDENT_FONTNAME, 'Tahoma');
    FontColor := ini.ReadInteger(SECT_SETTINGS, IDENT_FONTCOLOR, $202020);
    BGColor := ini.ReadInteger(SECT_SETTINGS, IDENT_BGCOLOR, 0);
  finally
    ini.Free;
  end;
end;

procedure TIxSettings.Save;
var
  ini: TIniFile;
  path: string;
begin
  path := ExtractFilePath(ini_fname);
  if not DirectoryExists(path) then
    ForceDirectories(path);

  ini := TIniFile.Create(ini_fname);
  try
    ini.WriteString(SECT_SETTINGS, IDENT_FONTNAME, FontName);
    ini.WriteInteger(SECT_SETTINGS, IDENT_FONTCOLOR, FontColor);
    ini.WriteInteger(SECT_SETTINGS, IDENT_BGCOLOR, BGColor);
  finally
    ini.Free;
  end;
end;

end.
