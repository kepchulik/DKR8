unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Math;

type

  { TForm1 }

  TForm1 = class(TForm)
    ButCalc: TButton;
    ButClear: TButton;
    EditResultSum: TEdit;
    EditResultPercent: TEdit;
    EditSum: TEdit;
    EditRate: TEdit;
    EditYears: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    MemoInfo: TMemo;
    RadioSimple: TRadioButton;
    RadioHard: TRadioButton;
    procedure ButCalcClick(Sender: TObject);
    procedure ButClearClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label2Click(Sender: TObject);
    procedure MemoInfoChange(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Label2Click(Sender: TObject);
begin

end;

procedure TForm1.MemoInfoChange(Sender: TObject);
begin

end;

procedure TForm1.ButCalcClick(Sender: TObject);
var
  Sum, Rate, Years: Double;
  ResultSum, PercentSum: Double;
begin
  if not TryStrToFloat(EditSum.Text, Sum) then
  begin
    ShowMessage('Введите корректную начальную сумму');
    Exit;
  end;

  if not TryStrToFloat(EditRate.Text, Rate) then
  begin
    ShowMessage('Введите корректную процентную ставку');
    Exit;
  end;

  if not TryStrToFloat(EditYears.Text, Years) then
  begin
    ShowMessage('Введите корректное количество лет');
    Exit;
  end;

  if (Sum < 0) or (Rate < 0) or (Years < 0) then
  begin
    ShowMessage('Значения не должны быть отрицательными');
    Exit;
  end;

  if RadioSimple.Checked then
  begin
    ResultSum := Sum * (1 + Rate / 100 * Years);
    PercentSum := ResultSum - Sum;

    MemoInfo.Clear;
    MemoInfo.Lines.Add('Расчёт простых процентов:');
    MemoInfo.Lines.Add('Итоговая сумма = Сумма * (1 + Ставка / 100 * Годы)');
    MemoInfo.Lines.Add('Итоговая сумма = ' + FloatToStr(Sum) + ' * (1 + ' +
      FloatToStr(Rate) + ' / 100 * ' + FloatToStr(Years) + ')');
  end

  else if RadioHard.Checked then
  begin
    ResultSum := Sum * Power(1 + Rate / 100, Years);
    PercentSum := ResultSum - Sum;

    MemoInfo.Clear;
    MemoInfo.Lines.Add('Расчёт сложных процентов:');
    MemoInfo.Lines.Add('Итоговая сумма = Сумма * (1 + Ставка / 100) ^ Годы');
    MemoInfo.Lines.Add('Итоговая сумма = ' + FloatToStr(Sum) + ' * (1 + ' +
      FloatToStr(Rate) + ' / 100) ^ ' + FloatToStr(Years));
  end

  else
  begin
    ShowMessage('Выберите тип процентов');
    Exit;
  end;

  EditResultSum.Text := FloatToStrF(ResultSum, ffFixed, 10, 2);
  EditResultPercent.Text := FloatToStrF(PercentSum, ffFixed, 10, 2);

  MemoInfo.Lines.Add('');
  MemoInfo.Lines.Add('Итоговая сумма: ' + EditResultSum.Text);
  MemoInfo.Lines.Add('Начисленные проценты: ' + EditResultPercent.Text);
end;

procedure TForm1.ButClearClick(Sender: TObject);
begin
  EditSum.Clear;
  EditRate.Clear;
  EditYears.Clear;
  EditResultSum.Clear;
  EditResultPercent.Clear;
  MemoInfo.Clear;

  RadioSimple.Checked := True;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  RadioSimple.Checked := True;

  EditResultSum.ReadOnly := True;
  EditResultPercent.ReadOnly := True;

  MemoInfo.ReadOnly := True;

  Color := clMoneyGreen;
  Font.Name := 'Segoe UI';
  Font.Size := 10;
end;

end.

