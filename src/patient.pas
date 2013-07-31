unit Patient;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Day;

type
  TPatient = class
  private
    FDayArray: array of TDay;
  public
    constructor Create(NrOfDays: integer);
    function GetDay(Index: integer): TDay;
  end;

implementation

constructor TPatient.Create(NrOfDays: integer);
var
  DayIdx: integer;
  NewDay: TDay;
begin
  SetLength(FDayArray, NrOfDays);
  for DayIdx := 0 to NrOfDays do
  begin
    NewDay := TDay.Create();
    FDayArray[DayIdx] := NewDay;
  end;
end;

function TPatient.GetDay(Index: integer) : TDay;
begin
  GetDay := FDayArray[Index];
end;

end.

