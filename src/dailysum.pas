unit DailySum;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  TDailySum = class

  private
    FLunch1Sums: array of integer;
    FLunch2Sums: array of integer;
    FDinner1Sums: array of integer;
    FDinner2Sums: array of integer;
    FDinner3Sums: array of integer;
    procedure IncSum(SumArray: array of integer; MealIndex: integer);
  public
    procedure IncLunch1Sum(MealIndex: integer);
    procedure IncLunch2Sum(MealIndex: integer);
    procedure IncDinner1Sum(MealIndex: integer);
    procedure IncDinner2Sum(MealIndex: integer);
    procedure IncDinner3Sum(MealIndex: integer);
  end;

implementation

procedure TDailySum.IncSum(SumArray: array of integer; MealIndex: integer);
begin
  SumArray[MealIndex] := SumArray[MealIndex] +1;
end;

procedure TDailySum.IncLunch1Sum(MealIndex: integer);
begin
  IncSum(FLunch1Sums, MealIndex);
end;

procedure TDailySum.IncLunch2Sum(MealIndex: integer);
begin
  IncSum(FLunch2Sums, MealIndex);
end;

procedure TDailySum.IncDinner1Sum(MealIndex: integer);
begin
  IncSum(FDinner1Sums, MealIndex);
end;

procedure TDailySum.IncDinner2Sum(MealIndex: integer);
begin
  IncSum(FDinner2Sums, MealIndex);
end;

procedure TDailySum.IncDinner3Sum(MealIndex: integer);
begin
  IncSum(FDinner3Sums, MealIndex);
end;

end.

