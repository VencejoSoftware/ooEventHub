{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooEventHub.Subscription.Path_test;

interface

uses
  SysUtils,
  StringEvent,
  StringSubscriber,
  StringSubscriber.List,
  StringSubscriptionPath,
  ooEventHub.Event,
  ooEventHub.Subscriber,
  ooEventHub.Subscriber.List,
  ooEventHub.Subscription.Path,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TSubscriptionPathTest = class sealed(TTestCase)
  const
    EVENT_ID1 = '{86AAA00A-7981-4738-9155-700047ECD0EA}';
    EVENT_ID2 = '{8B3FDD54-D1A2-40C6-B371-42F8E6A3C768}';
  published
    procedure AddTwoIDEventsReturnCount2;
    procedure PathHasThreeSubscribers;
  end;

implementation

procedure TSubscriptionPathTest.AddTwoIDEventsReturnCount2;
var
  SubscriptionPath: IStringSubscriptionPath;
begin
  SubscriptionPath := TStringSubscriptionPath.New;
  SubscriptionPath.SubscribersByID(EVENT_ID1).Add(TStringSubscriber.New(nil));
  SubscriptionPath.SubscribersByID(EVENT_ID1).Add(TStringSubscriber.New(nil));
  SubscriptionPath.SubscribersByID(EVENT_ID2).Add(TStringSubscriber.New(nil));
  CheckEquals(2, SubscriptionPath.Count);
end;

procedure TSubscriptionPathTest.PathHasThreeSubscribers;
var
  SubscriptionPath: IStringSubscriptionPath;
begin
  SubscriptionPath := TStringSubscriptionPath.New;
  SubscriptionPath.SubscribersByID(EVENT_ID1).Add(TStringSubscriber.New(nil));
  SubscriptionPath.SubscribersByID(EVENT_ID1).Add(TStringSubscriber.New(nil));
  SubscriptionPath.SubscribersByID(EVENT_ID1).Add(TStringSubscriber.New(nil));
  SubscriptionPath.SubscribersByID(EVENT_ID2).Add(TStringSubscriber.New(nil));
  CheckEquals(3, SubscriptionPath.SubscribersByID(EVENT_ID1).Count);
end;

initialization

RegisterTest(TSubscriptionPathTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
