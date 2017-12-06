{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit ooEventHub.Subscriber.List_test;

interface

uses
  SysUtils,
  StringEvent,
  StringSubscriber,
  StringSubscriber.List,
  ooEventHub.Event,
  ooEventHub.Subscriber,
  ooEventHub.Subscriber.List,
{$IFDEF FPC}
  fpcunit, testregistry
{$ELSE}
  TestFramework
{$ENDIF};

type
  TSubscriberListTest = class sealed(TTestCase)
  published
    procedure RemoveNotExistItemsReturnNegative1;
    procedure AddRepeatedItemsReturnNegative1;
    procedure AddTwoItemsReturnCount1;
    procedure AddTwoItemsReturnIndex1;
    procedure ExistNewItemIsFalse;
    procedure ExistCreatedItemIsTrue;
    procedure ListWithThreeItemsRemove1ReturnCount1;
    procedure Item2InListWithThreeItemsIsAssigned;
  end;

implementation

procedure TSubscriberListTest.AddRepeatedItemsReturnNegative1;
var
  SubscriberList: IStringSubscriberList;
  Subscriber: IStringSubscriber;
begin
  SubscriberList := TStringSubscriberList.New;
  Subscriber := TStringSubscriber.New(nil);
  CheckNotEquals( - 1, SubscriberList.Add(Subscriber));
  CheckEquals( - 1, SubscriberList.Add(Subscriber));
end;

procedure TSubscriberListTest.AddTwoItemsReturnCount1;
var
  SubscriberList: IStringSubscriberList;
begin
  SubscriberList := TStringSubscriberList.New;
  SubscriberList.Add(TStringSubscriber.New(nil));
  SubscriberList.Add(TStringSubscriber.New(nil));
  CheckEquals(2, SubscriberList.Count);
end;

procedure TSubscriberListTest.AddTwoItemsReturnIndex1;
var
  SubscriberList: IStringSubscriberList;
begin
  SubscriberList := TStringSubscriberList.New;
  CheckEquals(0, SubscriberList.Add(TStringSubscriber.New(nil)));
  CheckEquals(1, SubscriberList.Add(TStringSubscriber.New(nil)));
end;

procedure TSubscriberListTest.ExistCreatedItemIsTrue;
var
  SubscriberList: IStringSubscriberList;
  Subscriber: IStringSubscriber;
begin
  SubscriberList := TStringSubscriberList.New;
  Subscriber := TStringSubscriber.New(nil);
  CheckEquals(0, SubscriberList.Add(Subscriber));
  CheckTrue(SubscriberList.Exists(Subscriber));
end;

procedure TSubscriberListTest.ExistNewItemIsFalse;
var
  SubscriberList: IStringSubscriberList;
  Subscriber: IStringSubscriber;
begin
  SubscriberList := TStringSubscriberList.New;
  Subscriber := TStringSubscriber.New(nil);
  CheckFalse(SubscriberList.Exists(Subscriber));
end;

procedure TSubscriberListTest.Item2InListWithThreeItemsIsAssigned;
var
  SubscriberList: IStringSubscriberList;
  Subscriber: IStringSubscriber;
begin
  SubscriberList := TStringSubscriberList.New;
  SubscriberList.Add(TStringSubscriber.New(nil));
  Subscriber := TStringSubscriber.New(nil);
  SubscriberList.Add(Subscriber);
  SubscriberList.Add(TStringSubscriber.New(nil));
  CheckTrue(Assigned(SubscriberList.Subscriber(2)));
end;

procedure TSubscriberListTest.ListWithThreeItemsRemove1ReturnCount1;
var
  SubscriberList: IStringSubscriberList;
  Subscriber: IStringSubscriber;
begin
  SubscriberList := TStringSubscriberList.New;
  SubscriberList.Add(TStringSubscriber.New(nil));
  Subscriber := TStringSubscriber.New(nil);
  SubscriberList.Add(Subscriber);
  SubscriberList.Add(TStringSubscriber.New(nil));
  CheckEquals(1, SubscriberList.Remove(Subscriber));
  CheckEquals(2, SubscriberList.Count);
end;

procedure TSubscriberListTest.RemoveNotExistItemsReturnNegative1;
var
  SubscriberList: IStringSubscriberList;
  Subscriber: IStringSubscriber;
begin
  SubscriberList := TStringSubscriberList.New;
  Subscriber := TStringSubscriber.New(nil);
  CheckEquals( - 1, SubscriberList.Remove(Subscriber));
end;

initialization

RegisterTest(TSubscriberListTest {$IFNDEF FPC}.Suite {$ENDIF});

end.
