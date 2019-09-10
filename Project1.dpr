program Project1;

uses
  Forms,
  Unit2 in 'Unit2.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'get RGB pixels by SpawN';
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
