unit Patient;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Day;

type
  TPatient = class
  private
    FDayArray: array of TDay;
    FAddedDays: integer;
  public
    constructor Create(NrOfDays: integer);
    procedure AddDay(Day: TDay);
    function GetDay(Index: integer) : TDay;
  end;

implementation

constructor TPatient.Create(NrOfDays: integer);
begin
  SetLength(FDayArray, NrOfDays);
end;

procedure TPatient.AddDay(Day: TDay);
var
  Index: integer;
begin
  Index := FAddedDays;
  FDayArray[Index] := Day;

  FAddedDays := FAddedDays +1;
end;

function TPatient.GetDay(Index: integer) : TDay;
begin
  GetDay := FDayArray[Index];
end;

end.

