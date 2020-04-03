unit IxPainter;

interface

uses System.Classes, System.SysUtils, Vcl.Forms, Vcl.Graphics, IxSettings;

type
  TIxPainter = class(TObject)
  protected
    Bitmap: TBitmap;
  public
    Settings: TIxSettings;
    constructor Create;
    destructor Destroy; override;
    procedure SetSize(w, h: Integer);
    procedure DrawBackground;
    procedure Paint(Canvas: TCanvas);
  end;

implementation

{ TIxPainter }

constructor TIxPainter.Create;
begin
  Bitmap := TBitmap.Create;
end;

destructor TIxPainter.Destroy;
begin
  Bitmap.Free;
  inherited;
end;

procedure TIxPainter.DrawBackground;
var
  str: string;
  Width, Height: Integer;
begin
  Width := Bitmap.Width;
  Height := Bitmap.Height;

  // •`‰æƒpƒ‰ƒ[ƒ^
  Bitmap.Canvas.Brush.Color := Settings.BGColor;
  Bitmap.Canvas.Brush.Style := bsSolid;
  Bitmap.Canvas.Font.Name := Settings.FontName;
  Bitmap.Canvas.Font.Color := Settings.FontColor;
  Bitmap.SetSize(Width, Height);

  // “h‚è‚Â‚Ô‚µ
  Bitmap.Canvas.FillRect(Rect(0, 0, Width, Height));

  // •`‰æ
  DateTimeToString(str, 'hh:nn', Now);

  // ƒtƒHƒ“ƒgƒTƒCƒYŒvŽZ
  Bitmap.Canvas.Font.Height := Bitmap.Canvas.TextHeight(str) * Width div Bitmap.Canvas.TextWidth(str);
  if Bitmap.Canvas.Font.Height > Bitmap.Canvas.TextWidth(str) * Height div Bitmap.Canvas.TextHeight(str) then
    Bitmap.Canvas.Font.Height := Bitmap.Canvas.TextWidth(str) * Height div Bitmap.Canvas.TextHeight(str);

  // •¶Žš—ñ•`‰æ
  Bitmap.Canvas.TextOut((Width - Bitmap.Canvas.TextWidth(str)) div 2, (Height - Bitmap.Canvas.TextHeight(str))
    div 2, str);
end;

procedure TIxPainter.Paint(Canvas: TCanvas);
begin
  Canvas.Draw(0, 0, Bitmap);
  // Canvas.TextOut(0, 0, Tag.ToString);
end;

procedure TIxPainter.SetSize(w, h: Integer);
begin
  Bitmap.SetSize(w, h);
  DrawBackground;
end;

end.
