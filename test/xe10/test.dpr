{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
program test;

uses
  ooRunTest,
  StringEvent in '..\code\mock\StringEvent.pas',
  StringSubscriber in '..\code\mock\StringSubscriber.pas',
  StringSubscriber.List in '..\code\mock\StringSubscriber.List.pas',
  StringSubscriptionPath in '..\code\mock\StringSubscriptionPath.pas',
  ooEventHub.Event_test in '..\code\ooEventHub.Event_test.pas',
  ooEventHub.Subscriber_test in '..\code\ooEventHub.Subscriber_test.pas',
  ooEventHub.Subscriber.List_test in '..\code\ooEventHub.Subscriber.List_test.pas',
  ooEventHub.Subscription.Path_test in '..\code\ooEventHub.Subscription.Path_test.pas',
  ooEventHub.BroadcastHub_test in '..\code\ooEventHub.BroadcastHub_test.pas',
  StringBroadcastHub in '..\code\mock\StringBroadcastHub.pas',
  ooEventHub.BroadcastHub.Filtered_test in '..\code\ooEventHub.BroadcastHub.Filtered_test.pas';

{R *.RES}

begin
  Run;

end.
