unit Day;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  TDay = class
  private
    FMealIdx: integer;
    FDinnerIdx: integer;
    FLunchIdx: integer;
    procedure SetDinnerIdx(value: integer);
    procedure SetLunchIdx(value: integer);
  public
    constructor Create();
  published
    property MealIdx: integer read FMealIdx write FMealIdx default 0;
    property DinnerIdx: integer read FDinnerIdx write SetDinnerIdx default 0;
    property LunchIdx: integer read FLunchIdx write SetLunchIdx default 0;
  end;

implementation

  constructor TDay.Create();
  begin
    FMealIdx := 1;
    FDinnerIdx := 0;
    FLunchIdx := 0;
  end;

  procedure TDay.SetDinnerIdx(value: integer);
  begin
    if (value <= 3) then
    begin
      FDinnerIdx := value;
    end;

  end;

  procedure TDay.SetLunchIdx(value: integer);
  begin
    if (value <= 2) then
    begin
      FLunchIdx := value;
    end;

  end;

end.

