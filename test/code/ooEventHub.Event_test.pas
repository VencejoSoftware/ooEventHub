{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooEventHub.Event_test;

interface

uses
  SysUtils,
  StringEvent,
  ooEventHub.Event,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TStringEventTest = class sealed(TTestCase)
  published
    procedure IDIsTESTID;
    procedure ContentIsTestContent;
    procedure TimestampIsNow;
  end;

  TEventTest = class sealed(TTestCase)
  published
    procedure IDIsTESTID;
    procedure ContentIsTestContent;
    procedure TimestampIsNow;
  end;

implementation

procedure TStringEventTest.ContentIsTestContent;
var
  Event: IStringEvent;
begin
  Event := TStringEvent.Create('TESTID', 'test content');
  CheckEquals('test content', Event.Content);
end;

procedure TStringEventTest.IDIsTESTID;
var
  Event: IStringEvent;
begin
  Event := TStringEvent.Create('TESTID', 'test content');
  CheckEquals('TESTID', Event.ID);
end;

procedure TStringEventTest.TimestampIsNow;
var
  Event: IStringEvent;
begin
  Event := TStringEvent.Create('TESTID', 'test content');
  CheckEquals(Date, Trunc(Event.TimeStamp));
end;

{ TEventTest }

procedure TEventTest.IDIsTESTID;
var
  Event: IEvent<String>;
begin
  Event := TEvent<String>.Create('TESTID', 'test content');
  CheckEquals('TESTID', Event.ID);
end;

procedure TEventTest.ContentIsTestContent;
var
  Event: IEvent<String>;
begin
  Event := TEvent<String>.Create('TESTID', 'test content');
  CheckEquals('test content', Event.Content);
end;

procedure TEventTest.TimestampIsNow;
var
  Event: IEvent<String>;
begin
  Event := TEvent<String>.Create('TESTID', 'test content');
  CheckEquals(Date, Trunc(Event.TimeStamp));
end;

initialization

RegisterTest(TStringEventTest {$IFNDEF FPC}.Suite {$ENDIF});
RegisterTest(TEventTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
