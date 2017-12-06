{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit StringSubscriber.List;

interface

uses
  ooEventHub.Subscriber,
  ooEventHub.Subscriber.List;

type
  IStringSubscriberList = ISubscriberList<String>;
  TStringSubscriberList = TSubscriberList<String>;

implementation

end.
