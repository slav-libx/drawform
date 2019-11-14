unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.UIConsts, FMX.Objects,
  FMX.StdCtrls, System.Classes, FMX.Types, FMX.Controls,
  FMX.Controls.Presentation, System.Variants,
  FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.Math.Vectors, FMX.Ani,
  FMX.Utils;

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
var
  I, J: Integer;
  R: TRectF;
  CallOnPaint, AllowPaint: Boolean;
  Control: TControl;
begin
  inherited;
  Exit;

  if Canvas = nil then
    Exit;

//  if not FDrawing then
//  begin

//    AddUpdateRects(UpdateRects);
//    PrepareForPaint;
//
//    FDrawing := True;
//    try

       R:=RectF(100,100,150,150);

      if Canvas.BeginScene(@UpdateRects, ContextHandle) then
      try

        Canvas.Clear(claNull);
        Canvas.Fill.Color:=claRed;
        Canvas.SetMatrix(TMatrix.CreateRotation(0.5));

        Canvas.FillRect(R,5,5,AllCorners,1);

      finally
        Canvas.EndScene;
      end;

//        PaintBackground;
//
//        CallOnPaint := False;
//
//        if Controls <> nil then
//          for I := 0 to Controls.Count - 1 do
//            if FControls[I].Visible or FControls[I].ShouldTestMouseHits then
//            begin
//              Control := FControls[I];
//              if Control = FResourceLink then
//              begin
//                if Self.Transparency then
//                  Continue;
//                if Self.Fill.Kind <> TBrushKind.None then
//                  Continue;
//                if (Self.Fill.Kind = TBrushKind.Solid) and (Self.Fill.Color <> Fill.DefaultColor) then
//                  Continue;
//              end;
//              if Control.UpdateRect.IsEmpty then
//                Continue;
//              AllowPaint := False;
//              if Control.InPaintTo then
//                AllowPaint := True;
//              if not AllowPaint then
//              begin
//                R := UnionRect(Control.ChildrenRect, Control.UpdateRect);
//                for J := 0 to High(FUpdateRects) do
//                  if IntersectRect(FUpdateRects[J], R) then
//                  begin
//                    AllowPaint := True;
//                    Break;
//                  end;
//              end;
//              if AllowPaint then
//                TOpenControl(Control).PaintInternal;
//
//              if Control = FResourceLink then
//              begin
//                Canvas.SetMatrix(TMatrix.Identity);
//                DoPaint(Self.Canvas, ClientRect);
//
//                {$IFDEF MSWINDOWS}
//                if (csDesigning in ComponentState) and (Designer <> nil) then
//                begin
//                  Canvas.SetMatrix(TMatrix.Identity);
//                  Designer.PaintGrid;
//                end;
//                {$ENDIF}
//
//                CallOnPaint := True;
//              end;
//            end;
//
//          if not CallOnPaint then
//          begin
//            Canvas.SetMatrix(TMatrix.Identity);
//            DoPaint(Canvas, ClientRect);
//          end;
//
//          {$IFDEF MSWINDOWS}
//          if (csDesigning in ComponentState) and (Designer <> nil) then
//            Designer.Decorate(nil);
//          {$ENDIF}
//      finally
//        Canvas.EndScene;
//      end;
//    finally
//      SetLength(FUpdateRects, 0);
//      FDrawing := False;
//    end;
//  end;
end;

end.

