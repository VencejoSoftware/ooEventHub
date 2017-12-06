{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooEventHub.BroadcastHub_test;

interface

uses
  SysUtils,
  StringEvent,
  StringSubscriber,
  StringBroadcastHub,
  ooEventHub.Event,
  ooEventHub.Subscriber,
  ooEventHub.BroadcastHub,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TStringBroadcastTest = class sealed(TTestCase)
  const
    EVENT_ID1 = '{86AAA00A-7981-4738-9155-700047ECD0EA}';
    EVENT_ID2 = '{8B3FDD54-D1A2-40C6-B371-42F8E6A3C768}';
  published
    procedure AttachOfNewSubscriberReturnTrue;
    procedure AttachOfRepeatSubscriberReturnFalse;
    procedure DeattachOfNewSubscriberReturnFalse;
    procedure DeattachOfRepeatSubscriberReturnTrue;
    procedure DeattachOfSubscriberWithOtherEventIDReturnFalse;
    procedure PropagateToSubscribersAB;
    procedure PropagateToSubscribersC;
    procedure SendEventFilteringSubscriberA;
  end;

implementation

procedure TStringBroadcastTest.AttachOfNewSubscriberReturnTrue;
var
  BroadcastHub: IStringBroadcastHub;
begin
  BroadcastHub := TStringBroadcastHub.New;
  CheckTrue(BroadcastHub.Attach(EVENT_ID1, TStringSubscriber.New(nil)));
end;

procedure TStringBroadcastTest.AttachOfRepeatSubscriberReturnFalse;
var
  BroadcastHub: IStringBroadcastHub;
  Subscriber: IStringSubscriber;
begin
  BroadcastHub := TStringBroadcastHub.New;
  Subscriber := TStringSubscriber.New(nil);
  CheckTrue(BroadcastHub.Attach(EVENT_ID1, Subscriber));
  CheckFalse(BroadcastHub.Attach(EVENT_ID1, Subscriber));
end;

procedure TStringBroadcastTest.DeattachOfNewSubscriberReturnFalse;
var
  BroadcastHub: IStringBroadcastHub;
begin
  BroadcastHub := TStringBroadcastHub.New;
  CheckFalse(BroadcastHub.Deattach(EVENT_ID1, TStringSubscriber.New(nil)));
end;

procedure TStringBroadcastTest.DeattachOfRepeatSubscriberReturnTrue;
var
  BroadcastHub: IStringBroadcastHub;
  Subscriber: IStringSubscriber;
begin
  BroadcastHub := TStringBroadcastHub.New;
  Subscriber := TStringSubscriber.New(nil);
  CheckTrue(BroadcastHub.Attach(EVENT_ID1, Subscriber));
  CheckTrue(BroadcastHub.Deattach(EVENT_ID1, Subscriber));
end;

procedure TStringBroadcastTest.DeattachOfSubscriberWithOtherEventIDReturnFalse;
var
  BroadcastHub: IStringBroadcastHub;
  Subscriber: IStringSubscriber;
begin
  BroadcastHub := TStringBroadcastHub.New;
  Subscriber := TStringSubscriber.New(nil);
  CheckTrue(BroadcastHub.Attach(EVENT_ID1, Subscriber));
  CheckFalse(BroadcastHub.Deattach(EVENT_ID2, Subscriber));
end;

procedure TStringBroadcastTest.PropagateToSubscribersAB;
var
  BroadcastHub: IStringBroadcastHub;
  SubscriberA, SubscriberB, SubscriberC: IStringSubscriber;
  CallbackA, CallbackB, CallbackC: TStringSubscriberCalback;
begin
  BroadcastHub := TStringBroadcastHub.New;
  CallbackA := procedure(const Event: IEvent<String>)
    begin
      CheckEquals(EVENT_ID1, Event.ID);
      CheckEquals('test content A', Event.Content);
    end;
  CallbackB := procedure(const Event: IEvent<String>)
    begin
      CheckTrue(False);
    end;
  CallbackC := procedure(const Event: IEvent<String>)
    begin
      CheckEquals(EVENT_ID1, Event.ID);
      CheckEquals('test content A', Event.Content);
    end;
  SubscriberA := TStringSubscriber.New(CallbackA);
  SubscriberB := TStringSubscriber.New(CallbackB);
  SubscriberC := TStringSubscriber.New(CallbackC);
  BroadcastHub.Attach(EVENT_ID1, SubscriberA);
  BroadcastHub.Attach(EVENT_ID2, SubscriberB);
  BroadcastHub.Attach(EVENT_ID1, SubscriberC);
  BroadcastHub.Send(Self, TStringEvent.New(EVENT_ID1, 'test content A'));
end;

procedure TStringBroadcastTest.PropagateToSubscribersC;
var
  BroadcastHub: IStringBroadcastHub;
  SubscriberA, SubscriberB, SubscriberC: IStringSubscriber;
  CallbackA, CallbackB, CallbackC: TStringSubscriberCalback;
begin
  BroadcastHub := TStringBroadcastHub.New;
  CallbackA := procedure(const Event: IEvent<String>)
    begin
      CheckTrue(False);
    end;
  CallbackB := procedure(const Event: IEvent<String>)
    begin
      CheckEquals(EVENT_ID2, Event.ID);
      CheckEquals('test content B', Event.Content);
    end;
  CallbackC := procedure(const Event: IEvent<String>)
    begin
      CheckTrue(False);
    end;
  SubscriberA := TStringSubscriber.New(CallbackA);
  SubscriberB := TStringSubscriber.New(CallbackB);
  SubscriberC := TStringSubscriber.New(CallbackC);
  BroadcastHub.Attach(EVENT_ID1, SubscriberA);
  BroadcastHub.Attach(EVENT_ID2, SubscriberB);
  BroadcastHub.Attach(EVENT_ID1, SubscriberC);
  BroadcastHub.Send(Self, TStringEvent.New(EVENT_ID2, 'test content B'));
end;

procedure TStringBroadcastTest.SendEventFilteringSubscriberA;
const
  SUBSCRIBER_ID_A: TGUID = '{6E9A5BA0-601A-49E3-B1BB-4043102D877A}';
  SUBSCRIBER_ID_B: TGUID = '{B101BCC6-FD7B-4C56-8262-F89A215240C9}';
  SUBSCRIBER_ID_C: TGUID = '{0E83B7D3-5BCC-4882-AC62-27ED96F59DAE}';
var
  BroadcastHub: IStringBroadcastHub;
  SubscriberA, SubscriberB, SubscriberC: IStringSubscriber;
  CallbackA, CallbackB, CallbackC: TStringSubscriberCalback;
//  OnFilterCallback: TStringOnBroadcastFilter;
begin
  BroadcastHub := TStringBroadcastHub.New;
  CallbackA := procedure(const Event: IEvent<String>)
    begin
      CheckTrue(False);
    end;
  CallbackB := procedure(const Event: IEvent<String>)
    begin
      CheckTrue(False);
    end;
  CallbackC := procedure(const Event: IEvent<String>)
    begin
      CheckEquals(EVENT_ID1, Event.ID);
      CheckEquals('test content A', Event.Content);
    end;
  SubscriberA := TStringSubscriber.NewWithID(SUBSCRIBER_ID_A, CallbackA);
  SubscriberB := TStringSubscriber.NewWithID(SUBSCRIBER_ID_B, CallbackB);
  SubscriberC := TStringSubscriber.NewWithID(SUBSCRIBER_ID_C, CallbackC);
  BroadcastHub.Attach(EVENT_ID1, SubscriberA);
  BroadcastHub.Attach(EVENT_ID2, SubscriberB);
  BroadcastHub.Attach(EVENT_ID1, SubscriberC);
//  OnFilterCallback :=
//      function(const Sender: TObject; const Subscriber: ISubscriber<String>; const Event: IEvent<String>): Boolean
//    begin
//      Result := Subscriber.ID <> SUBSCRIBER_ID_A;
//    end;
//  BroadcastHub.Send(Self, TStringEvent.New(EVENT_ID1, 'test content A'), OnFilterCallback);
end;

initialization

RegisterTest(TStringBroadcastTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
