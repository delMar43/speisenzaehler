unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, SynHighlighterPHP, Forms, Controls,
  Dialogs, StdCtrls, Grids, ComCtrls, Menus, ExtCtrls, Day, Patient;

type

  { TFormMain }

  TFormMain = class(TForm)
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
    procedure GoToPreviousMeal();
    procedure RenderCurrentDay();
    procedure CreateNewPatient();
  public
    { public declarations }
  end;

var
  FormMain: TFormMain;
  PatientList: TList;
  FoodLabelArray: array [1..9] of TLabel;
  LunchLabelArray: array [0..2] of TLabel;
  DinnerLabelArray: array [0..3] of TLabel;

  CurrentPatient: TPatient;
  CurrentMealIsLunch: boolean;

  CurrentPatientIndex: integer;
  CurrentInputIndex: integer;
  StartDay: integer;
  EndDay: integer;
  NrOfDays: integer;

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

end;

procedure TFormMain.TabInputDisplayChange(Sender: TObject);
begin

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

procedure TFormMain.SelectMeal(MealIndex: integer);
begin
  CurrentPatient.GetDay(CurrentInputIndex).MealIdx := MealIndex;
  RenderCurrentDay();
end;

procedure TFormMain.SelectMealChoice(ChoiceIndex: integer);
begin
  if (CurrentMealIsLunch) then
    begin
      CurrentPatient.GetDay(CurrentInputIndex).LunchIdx := ChoiceIndex;
    end else begin
      CurrentPatient.GetDay(CurrentInputIndex).DinnerIdx := ChoiceIndex;
    end;

  RenderCurrentDay();
end;

procedure TFormMain.GoToNextMeal();
var
  NewInputIndex: integer;
begin

  if (not CurrentMealIsLunch) then
    begin
      NewInputIndex := CurrentInputIndex +1;

      if (NewInputIndex >= NrOfDays) then
        begin
          NewInputIndex := 0;

          CreateNewPatient();
          //new patient
        end;

      TabDayDisplay.TabIndex := NewInputIndex;
      TabInputDisplay.TabIndex := NewInputIndex;

      CurrentInputIndex := NewInputIndex;

      //if not last day go to next day, set lunch as active meal

      //if last day goto next patient, first day, set lunch as active meal
    end;

  CurrentMealIsLunch := not CurrentMealIsLunch;

  RenderCurrentDay();
end;

procedure TFormMain.GoToPreviousMeal();
begin

  if (CurrentMealIsLunch) then
    begin
      //if not first day, go to previous day, set dinner as active meal

      //if first day, do nothing
    end else begin

    end;
  CurrentMealIsLunch := not CurrentMealIsLunch;

  RenderCurrentDay();
end;

procedure TFormMain.RenderCurrentDay();
var
  CurrentDay: TDay;
  FoodLabel: TLabel;
  LunchLabel: TLabel;
  DinnerLabel: TLabel;
begin

  ShapeLunchActive.Visible := CurrentMealIsLunch;
  ShapeDinnerActive.Visible := not CurrentMealIsLunch;

  CurrentDay := CurrentPatient.GetDay(CurrentInputIndex);

  ShapeVerticalSelection.Visible := True;
  ShapeCurrentLunch.Visible := True;
  ShapeCurrentDinner.Visible := True;

  FoodLabel := FoodLabelArray[CurrentDay.MealIdx];
  LunchLabel := LunchLabelArray[CurrentDay.LunchIdx];
  DinnerLabel := DinnerLabelArray[CurrentDay.DinnerIdx];

  LabelCurrentPatientIndex.Caption := 'Patient ' + IntToStr(CurrentPatientIndex +1);

  ShapeVerticalSelection.Width := FoodLabel.Width;
  ShapeVerticalSelection.Left := FoodLabel.Left;

  ShapeCurrentLunch.Top := LunchLabel.Top;
  ShapeCurrentLunch.Height := LunchLabel.Height;

  ShapeCurrentDinner.Top := DinnerLabel.Top;
  ShapeCurrentDinner.Height := DinnerLabel.Height;
end;

procedure TFormMain.FormMainCreate(Sender: TObject);
begin
  FoodLabelArray[1] := Label2;
  FoodLabelArray[2] := Label3;
  FoodLabelArray[3] := Label4;
  FoodLabelArray[4] := Label5;
  FoodLabelArray[5] := Label6;
  FoodLabelArray[6] := Label7;
  FoodLabelArray[7] := Label8;
  FoodLabelArray[8] := Label9;
  FoodLabelArray[9] := Label10;

  LunchLabelArray[0] := Label19;
  LunchLabelArray[1] := Label13;
  LunchLabelArray[2] := Label14;

  DinnerLabelArray[0] := Label18;
  DinnerLabelArray[1] := Label15;
  DinnerLabelArray[2] := Label16;
  DinnerLabelArray[3] := Label17;

  PatientList := TList.Create();

  CurrentInputIndex := 0;
  StartDay := 4;
  EndDay := 10;
  NrOfDays := (EndDay - StartDay +1);
  CurrentPatientIndex := 0;
  CurrentMealIsLunch := True;

  CreateNewPatient();
  CurrentPatientIndex := 0;

  RenderCurrentDay();
end;

procedure TFormMain.CreateNewPatient();
var
  NewPatient: TPatient;
begin
  NewPatient := TPatient.Create(NrOfDays);
  PatientList.Add(NewPatient);

  CurrentPatient := NewPatient;

  CurrentPatientIndex := CurrentPatientIndex +1;
end;

end.

