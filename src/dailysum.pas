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
    procedure IncSum(var SumArray: array of integer; MealIndex: integer);
    function GetSum(var SumArray: array of integer; MealIndex: integer): integer;
    procedure FillArrayWithZeroes(Target: array of integer);
  public
    constructor Create(NrOfMeals: integer);
    procedure IncLunch1Sum(MealIndex: integer);
    procedure IncLunch2Sum(MealIndex: integer);
    procedure IncDinner1Sum(MealIndex: integer);
    procedure IncDinner2Sum(MealIndex: integer);
    procedure IncDinner3Sum(MealIndex: integer);

    function GetLunch1Sum(MealIndex: integer): integer;
    function GetLunch2Sum(MealIndex: integer): integer;
    function GetDinner1Sum(MealIndex: integer): integer;
    function GetDinner2Sum(MealIndex: integer): integer;
    function GetDinner3Sum(MealIndex: integer): integer;
  end;

implementation

constructor TDailySum.Create(NrOfMeals: integer);
begin
  SetLength(FLunch1Sums, NrOfMeals);
  FillArrayWithZeroes(FLunch1Sums);

  SetLength(FLunch2Sums, NrOfMeals);
  FillArrayWithZeroes(FLunch2Sums);

  SetLength(FDinner1Sums, NrOfMeals);
  FillArrayWithZeroes(FDinner1Sums);

  SetLength(FDinner2Sums, NrOfMeals);
  FillArrayWithZeroes(FDinner2Sums);

  SetLength(FDinner3Sums, NrOfMeals);
  FillArrayWithZeroes(FDinner3Sums);
end;

procedure TDailySum.FillArrayWithZeroes(Target: array of integer);
var
  Index: integer;
begin
  for Index := 0 to Length(Target) do
    begin
      Target[Index] := 0;
    end;
end;

procedure TDailySum.IncSum(var SumArray: array of integer; MealIndex: integer);
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

function TDailySum.GetSum(var SumArray: array of integer; MealIndex: integer): integer;
begin
  GetSum := SumArray[MealIndex];
end;

function TDailySum.GetLunch1Sum(MealIndex: integer): integer;
begin
  GetLunch1Sum := GetSum(FLunch1Sums, MealIndex);
end;

function TDailySum.GetLunch2Sum(MealIndex: integer): integer;
begin
  GetLunch2Sum := GetSum(FLunch2Sums, MealIndex);
end;

function TDailySum.GetDinner1Sum(MealIndex: integer): integer;
begin
  GetDinner1Sum := GetSum(FDinner1Sums, MealIndex);
end;

function TDailySum.GetDinner2Sum(MealIndex: integer): integer;
begin
  GetDinner2Sum := GetSum(FDinner2Sums, MealIndex);
end;

function TDailySum.GetDinner3Sum(MealIndex: integer): integer;
begin
  GetDinner3Sum := GetSum(FDinner3Sums, MealIndex);
end;
end.

