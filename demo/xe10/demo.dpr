{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
program demo;

uses
  Forms,
  ooEventHub.BroadcastHub,
  ooEventHub.BroadcastHub.Filtered,
  MainForm in '..\code\form\MainForm.pas' {MainForm},
  Subscriber1 in '..\code\Subscriber1.pas',
  Subscriber2 in '..\code\Subscriber2.pas';

{$R *.res}

var
  BroadcastHub: IBroadcastHubFiltered<String>;

begin
{$WARN SYMBOL_PLATFORM OFF}
  ReportMemoryLeaksOnShutdown := (DebugHook <> 0);
{$WARN SYMBOL_PLATFORM ON}
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  BroadcastHub := TBroadcastHubFiltered<String>.New(TBroadcastHub<String>.New);
  NewMainForm := TMainForm.Create(Application, BroadcastHub);
  NewMainForm.ShowModal;
  Application.Run;

end.
