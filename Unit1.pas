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
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
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

uses Unit2;

type
  TShowAnimation = class(TAnimation)
  private
    Left: Integer;
  public
    Form: TForm;
    procedure Start; override;
    procedure ProcessAnimation; override;
  end;

procedure TShowAnimation.Start;
begin
  Left:=Form.Left;
  inherited;
end;

procedure TShowAnimation.ProcessAnimation;
begin
  //Form.Left:=Round(InterpolateSingle(Left-Form.Width,Left,NormalizedTime));
  Form.Canvas.Offset:=PointF(InterpolateSingle(-Form.Width,0,NormalizedTime),0);
  Form.Canvas.SetMatrix(TMatrix.CreateRotation(20));// Scale:=0.5;
  Form.Invalidate;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 FShowAnimation.Start;
end;

procedure TForm1.FormCreate(Sender: TObject);
var A: TShowAnimation;
begin
  {$IFDEF ANDROID}
  Width:=Screen.Width;
  Height:=Screen.Height;
  {$ENDIF}
  A:=TShowAnimation.Create(Self);
  A.Parent:=Self;
  A.Form:=Self;
  //A.Left:=Left;
  A.Duration:=1;
  FShowAnimation:=A;

end;

procedure TForm1.FormShow(Sender: TObject);
begin
  FShowAnimation.Start;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  //form2.ParentForm:=self;
  form2.Parent:=self;
  form2.show;
end;

procedure TForm1.CreateHandle;
begin
  inherited;
  Canvas.Offset:=PointF(-100000,0);
end;

procedure TForm1.PaintRects(const UpdateRects: array of TRectF);
begin
//  if FShowAnimation.Running or (Canvas.Offset.X=0) then
//  Canvas.ClearRect(R,);
  inherited;
end;

end.

