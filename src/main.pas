unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, SynHighlighterPHP, Forms, Controls, LCLType,
  Dialogs, StdCtrls, Grids, ComCtrls, Menus, ExtCtrls, Day, Patient, DailySum;

type
  { TFormMain }

  TFormMain = class(TForm)
    ButtonSave: TButton;
    GridSums: TStringGrid;
    LabelCurrentPatientIndex: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    MenuFile: TMenuItem;
    MenuItemExit: TMenuItem;
    MenuItemSettings: TMenuItem;
    MenuItem2: TMenuItem;
    MenuMain: TMainMenu;
    ShapeCurrentDinner: TShape;
    ShapeLunchActive: TShape;
    ShapeDinnerActive: TShape;
    ShapeCurrentLunch: TShape;
    ShapeVerticalSelection: TShape;
    TabDayDisplay: TTabControl;
    TabInputDisplay: TTabControl;
    procedure ButtonSaveClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: char);
    procedure FormMainCreate(Sender: TObject);
    procedure MenuItemExitClick(Sender: TObject);
    procedure MenuItemSettingsClick(Sender: TObject);
    procedure ShapeDinnerActiveChangeBounds(Sender: TObject);
    procedure TabDayDisplayChange(Sender: TObject);
    procedure TabInputDisplayChange(Sender: TObject);

  private
    procedure SelectMeal(MealIndex: integer);
    procedure SelectMealChoice(ChoiceIndex: integer);
    procedure GoToNextMeal();
    function AskForSwitch(): boolean;
    procedure GoToPreviousMeal();
    procedure RenderInputDisplay();
    procedure RenderSumDisplay();
    procedure CreateNewPatient(NewPatientIndex: integer);
  public
    { public declarations }
  end;

var
  FormMain: TFormMain;
  PatientArray: array of TPatient;
  FoodLabelArray: array [1..9] of TLabel;
  LunchLabelArray: array [0..2] of TLabel;
  DinnerLabelArray: array [0..3] of TLabel;

  CurrentPatient: TPatient;
  CurrentMealIsLunch: boolean;

  CurrentPatientIndex: integer;
  CurrentInputDayIndex: integer;
  StartDay: integer;
  EndDay: integer;
  NrOfDays: integer;
  NrOfMeals: integer;
  SelectedMealIndex: integer;
  SelectedLunchIndex: integer;
  SelectedDinnerIndex: integer;

implementation

{$R *.lfm}

{ TFormMain }

procedure TFormMain.MenuItemSettingsClick(Sender: TObject);
begin

end;

procedure TFormMain.ShapeDinnerActiveChangeBounds(Sender: TObject);
begin

end;

procedure TFormMain.MenuItemExitClick(Sender: TObject);
begin
  Close();
end;

procedure TFormMain.TabDayDisplayChange(Sender: TObject);
begin
  RenderSumDisplay();
end;

procedure TFormMain.TabInputDisplayChange(Sender: TObject);
begin
  CurrentInputDayIndex := TabInputDisplay.TabIndex;

  RenderInputDisplay();
end;

procedure TFormMain.FormKeyPress(Sender: TObject; var Key: char);
var
  KeyByte: byte;
begin

  KeyByte := byte(Key);

  if ((KeyByte >= 97) and (KeyByte <= 105)) then
      begin
        SelectMeal(KeyByte - 96);
      end;

  if ((KeyByte >= 48) and (KeyByte <= 51)) then
      begin
        SelectMealChoice(KeyByte - 48);
      end;

  if (KeyByte = 13) then
      begin
        GoToNextMeal();
      end;

  if (KeyByte = 8) then
      begin
        GoToPreviousMeal();
      end;

end;

procedure TFormMain.ButtonSaveClick(Sender: TObject);
begin
end;

procedure TFormMain.SelectMeal(MealIndex: integer);
begin
  SelectedMealIndex:=MealIndex;
  RenderInputDisplay();
end;

procedure TFormMain.SelectMealChoice(ChoiceIndex: integer);
begin
  if (CurrentMealIsLunch) then
    begin
      if ChoiceIndex <= 2 then
        begin
          SelectedLunchIndex := ChoiceIndex;
        end;
    end else begin
      SelectedDinnerIndex := ChoiceIndex;
    end;

  RenderInputDisplay();
end;

procedure TFormMain.GoToNextMeal();
var
  NewInputIndex: integer;
  CurrentDay: TDay;
  SwitchToNextPatient: boolean;
  SwitchToNextDay: boolean;
  LastDayOfPatient: boolean;
begin
  CurrentDay := CurrentPatient.GetDay(CurrentInputDayIndex);

  CurrentDay.MealIdx := SelectedMealIndex;
  SwitchToNextPatient := false;
  SwitchToNextDay := true;

  if (not CurrentMealIsLunch) then
    begin
      CurrentDay.DinnerIdx:=SelectedDinnerIndex;
      NewInputIndex := CurrentInputDayIndex +1;

      LastDayOfPatient := NewInputIndex >= NrOfDays;
      if (LastDayOfPatient) then
        begin
          SwitchToNextPatient := AskForSwitch();
          if not SwitchToNextPatient then
            begin
              SwitchToNextDay := false;
            end;
        end;

      if SwitchToNextPatient then
        begin
          NewInputIndex := 0;
          CreateNewPatient(CurrentPatientIndex+1);
        end;

      if SwitchToNextDay then
        begin
          CurrentInputDayIndex := NewInputIndex;
        end;
    end else begin
      CurrentDay.LunchIdx:=SelectedLunchIndex;
    end;

  if SwitchToNextDay then
    begin
      CurrentMealIsLunch := not CurrentMealIsLunch;

      RenderInputDisplay();
    end;
end;

function TFormMain.AskForSwitch(): boolean;
var
  Reply: integer;
begin
  Reply := Application.MessageBox('Wollen Sie zum nächsten Patienten wechseln?', 'Alle Tage eingegeben', MB_ICONQUESTION + MB_YESNO);
  AskForSwitch := Reply = IDYES;
end;

procedure TFormMain.GoToPreviousMeal();
var
  SwitchMeals: boolean;
begin
  SwitchMeals := True;
  if (CurrentMealIsLunch) then
    begin
      if (CurrentInputDayIndex > 0) then
        begin
          CurrentInputDayIndex := CurrentInputDayIndex -1;
        end else begin
          SwitchMeals := False;
        end;
    end else begin

    end;

  if (SwitchMeals) then
    begin
      CurrentMealIsLunch := not CurrentMealIsLunch;
    end;

  RenderInputDisplay();
end;

procedure TFormMain.RenderInputDisplay();
var
  FoodLabel: TLabel;
  LunchLabel: TLabel;
  DinnerLabel: TLabel;
begin
  ShapeLunchActive.Visible := CurrentMealIsLunch;
  ShapeDinnerActive.Visible := not CurrentMealIsLunch;

  ShapeVerticalSelection.Visible := True;
  ShapeCurrentLunch.Visible := True;
  ShapeCurrentDinner.Visible := True;

  FoodLabel := FoodLabelArray[SelectedMealIndex];
  LunchLabel := LunchLabelArray[SelectedLunchIndex];
  DinnerLabel := DinnerLabelArray[SelectedDinnerIndex];

  ShapeVerticalSelection.Width := FoodLabel.Width;
  ShapeVerticalSelection.Left := FoodLabel.Left;

  ShapeCurrentLunch.Top := LunchLabel.Top;
  ShapeCurrentLunch.Height := LunchLabel.Height;

  ShapeCurrentDinner.Top := DinnerLabel.Top;
  ShapeCurrentDinner.Height := DinnerLabel.Height;

  TabDayDisplay.TabIndex := CurrentInputDayIndex;
  TabInputDisplay.TabIndex := CurrentInputDayIndex;
end;

procedure TFormMain.RenderSumDisplay();
var
  CalculatedDayIndex: integer;
  ItPatient: TPatient;
  ItDay: TDay;
  Sum: TDailySum;
  DayMealIndex: integer;
  CurMealIndex: integer;
begin
  CalculatedDayIndex := TabDayDisplay.TabIndex;

  Sum := TDailySum.Create(NrOfMeals);

  for ItPatient in PatientArray do
  begin
   ItDay := ItPatient.GetDay(CalculatedDayIndex);
   DayMealIndex := ItDay.MealIdx -1;
   if (ItDay.LunchIdx = 1) then
     begin
       Sum.IncLunch1Sum(DayMealIndex);
     end;
   if (ItDay.LunchIdx = 2) then
     begin
       Sum.IncLunch2Sum(DayMealIndex);
     end;
   if (ItDay.DinnerIdx = 1) then
     begin
       Sum.IncDinner1Sum(DayMealIndex);
     end;
   if (ItDay.DinnerIdx = 2) then
     begin
       Sum.IncDinner2Sum(DayMealIndex);
     end;
   if (ItDay.DinnerIdx = 3) then
     begin
       Sum.IncDinner3Sum(DayMealIndex);
     end;
  end;

  for CurMealIndex := 1 to NrOfMeals do
  begin
   GridSums.Cells[CurMealIndex, 1] := IntToStr(Sum.GetLunch1Sum(CurMealIndex-1));
   GridSums.Cells[CurMealIndex, 2] := IntToStr(Sum.GetLunch2Sum(CurMealIndex-1));

   GridSums.Cells[CurMealIndex, 5] := IntToStr(Sum.GetDinner1Sum(CurMealIndex-1));
   GridSums.Cells[CurMealIndex, 6] := IntToStr(Sum.GetDinner2Sum(CurMealIndex-1));
   GridSums.Cells[CurMealIndex, 7] := IntToStr(Sum.GetDinner3Sum(CurMealIndex-1));
  end;

end;

procedure TFormMain.FormMainCreate(Sender: TObject);
begin

  SelectedMealIndex := 1;
  SelectedLunchIndex := 0;
  SelectedDinnerIndex := 0;

  FoodLabelArray[1] := Label2;
  FoodLabelArray[2] := Label3;
  FoodLabelArray[3] := Label4;
  FoodLabelArray[4] := Label5;
  FoodLabelArray[5] := Label6;
  FoodLabelArray[6] := Label7;
  FoodLabelArray[7] := Label8;
  FoodLabelArray[8] := Label9;
  FoodLabelArray[9] := Label10;

  NrOfMeals := Length(FoodLabelArray);

  LunchLabelArray[0] := Label19;
  LunchLabelArray[1] := Label13;
  LunchLabelArray[2] := Label14;

  DinnerLabelArray[0] := Label18;
  DinnerLabelArray[1] := Label15;
  DinnerLabelArray[2] := Label16;
  DinnerLabelArray[3] := Label17;

  CurrentInputDayIndex := 0;
  StartDay := 4;
  EndDay := 10;
  NrOfDays := (EndDay - StartDay +1);
  CurrentPatientIndex := 0;
  CurrentMealIsLunch := True;

  CreateNewPatient(0);

  RenderSumDisplay();
end;

procedure TFormMain.CreateNewPatient(NewPatientIndex: integer);
begin
  CurrentPatient := TPatient.Create(NrOfDays);

  SetLength(PatientArray, NewPatientIndex+1);
  PatientArray[NewPatientIndex] := CurrentPatient;

  CurrentPatientIndex := NewPatientIndex;

  LabelCurrentPatientIndex.Caption := 'Patient ' + IntToStr(CurrentPatientIndex +1);
end;


end.

