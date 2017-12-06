{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
program test;

uses
  ooRunTest,
  ooAppInfo.Parameter.Parser_test in '..\code\ooAppInfo.Parameter.Parser_test.pas',
  ooAppInfo.Parameter_test in '..\code\ooAppInfo.Parameter_test.pas',
  ooAppInfo_test in '..\code\ooAppInfo_test.pas',
  ooAppInfo.Version_test in '..\code\ooAppInfo.Version_test.pas',
  ooAppInfo.Parameter.Mock in '..\code\ooAppInfo.Parameter.Mock.pas',
  ooAppInfo.ParameterList_test in '..\code\ooAppInfo.ParameterList_test.pas';

{$R *.RES}

begin
  Run;

end.
