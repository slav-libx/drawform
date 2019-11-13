unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, System.Math.Vectors, FMX.Ani,
  FMX.Objects, FMX.Utils;

type
  TForm1 = class(TForm)
    Button1: TButton;
    CheckBox1: TCheckBox;
    Image1: TImage;
    FloatAnimation1: TFloatAnimation;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    FShowAnimation: TAnimation;
  protected
    procedure CreateHandle; override;
    procedure PaintRects(const UpdateRects: array of TRectF); override;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

type
  TShowAnimation = class(TAnimation)
    Form: TForm;
    procedure ProcessAnimation; override;
  end;

procedure TShowAnimation.ProcessAnimation;
begin
  Form.Canvas.Offset:=PointF(InterpolateSingle(-Form.Width,0,NormalizedTime),0);
  Form.Invalidate;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 FShowAnimation.Start;
end;

procedure TForm1.FormCreate(Sender: TObject);
var A: TShowAnimation;
begin
  A:=TShowAnimation.Create(Self);
  A.Parent:=Self;
  A.Form:=Self;
  A.Duration:=5;
  FShowAnimation:=A;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  FShowAnimation.Start;
end;

procedure TForm1.CreateHandle;
begin
  inherited;
  Canvas.Offset:=PointF(-100000,0);
end;

procedure TForm1.PaintRects(const UpdateRects: array of TRectF);
begin
//  if FShowAnimation.Running then
//  Canvas.ClearRect(R,);
  inherited;
end;

end.

