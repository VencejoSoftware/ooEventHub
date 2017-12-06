{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooEventHub.Subscriber_test;

interface

uses
  SysUtils,
  StringEvent,
  StringSubscriber,
  ooEventHub.Event,
  ooEventHub.Subscriber,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TStringSubscriberTest = class sealed(TTestCase)
  published
    procedure IDIsAssigned;
    procedure CallbackCalled;
  end;

  TSubscriberTest = class sealed(TTestCase)
  published
    procedure IDIsAssigned;
    procedure CallbackCalled;
  end;

implementation

procedure TStringSubscriberTest.CallbackCalled;
var
  Subscriber: IStringSubscriber;
  Callback: TStringSubscriberCalback;
begin
  Callback := procedure(const Event: IEvent<String>)
    begin
      CheckEquals('TESTID', Event.ID);
      CheckEquals('test content', Event.Content);
    end;
  Subscriber := TStringSubscriber.New(Callback);
  Subscriber.HandleEvent(TStringEvent.New('TESTID', 'test content'));
end;

procedure TStringSubscriberTest.IDIsAssigned;
var
  Subscriber: IStringSubscriber;
begin
  Subscriber := TStringSubscriber.New(nil);
  CheckNotEquals(EmptyStr, Subscriber.ID.ToString);
end;

{ TSubscriberTest }

procedure TSubscriberTest.CallbackCalled;
var
  Subscriber: ISubscriber<String>;
  Callback: TStringSubscriberCalback;
begin
  Callback := procedure(const Event: IEvent<String>)
    begin
      CheckEquals('TESTID', Event.ID);
      CheckEquals('test content', Event.Content);
    end;
  Subscriber := TSubscriber<String>.New(Callback);
  Subscriber.HandleEvent(TStringEvent.New('TESTID', 'test content'));
end;

procedure TSubscriberTest.IDIsAssigned;
var
  Subscriber: ISubscriber<String>;
begin
  Subscriber := TSubscriber<String>.New(nil);
  CheckNotEquals(EmptyStr, Subscriber.ID.ToString);
end;

initialization

RegisterTest(TStringSubscriberTest {$IFNDEF FPC}.Suite {$ENDIF});
RegisterTest(TSubscriberTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
