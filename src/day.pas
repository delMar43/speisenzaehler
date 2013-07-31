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
  public
    constructor Create();
    function GetMealIdx(): integer;
    procedure SetMealIdx(value: integer);
    function GetDinnerIdx(): integer;
    procedure SetDinnerIdx(value: integer);
    function GetLunchIdx(): integer;
    procedure SetLunchIdx(value: integer);
  published
    property MealIdx: integer read GetMealIdx write SetMealIdx default 0;
    property DinnerIdx: integer read GetDinnerIdx write SetDinnerIdx default 0;
    property LunchIdx: integer read GetLunchIdx write SetLunchIdx default 0;
  end;

implementation

  constructor TDay.Create();
  begin
    FMealIdx := 1;
    FDinnerIdx := 0;
    FLunchIdx := 0;
  end;

  function TDay.GetMealIdx(): integer;
  begin
    GetMealIdx := FMealIdx;
  end;

  procedure TDay.SetMealIdx(value: integer);
  begin
    FMealIdx := value;
  end;

  function TDay.GetDinnerIdx(): integer;
  begin
    GetDinnerIdx := FDinnerIdx;
  end;

  procedure TDay.SetDinnerIdx(value: integer);
  begin
    if (value <= 3) then
    begin
      FDinnerIdx := value;
    end;

  end;

  function TDay.GetLunchIdx(): integer;
  begin
    GetLunchIdx := FLunchIdx;
  end;

  procedure TDay.SetLunchIdx(value: integer);
  begin
    if (value <= 2) then
    begin
      FLunchIdx := value;
    end;

  end;

end.

