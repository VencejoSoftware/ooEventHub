{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
unit StringSubscriber;

interface

uses
  ooEventHub.Event,
  ooEventHub.Subscriber;

type
  IStringSubscriber = interface(ISubscriber<String>)
    ['{8EA5A923-2428-4C22-A4F6-C49094515CB3}']
  end;

  TStringSubscriberCalback = TSubscriberCalback<String>;

  TStringSubscriber = class sealed(TInterfacedObject, IStringSubscriber)
  strict private
    _Subscriber: ISubscriber<String>;
  public
    function ID: TSubscriberID;
    procedure HandleEvent(const Event: IEvent<String>);
    constructor Create(const Callback: TStringSubscriberCalback);
    constructor CreateWithID(const ID: TSubscriberID; const Callback: TStringSubscriberCalback);
    class function New(const Callback: TStringSubscriberCalback): IStringSubscriber;
    class function NewWithID(const ID: TSubscriberID; const Callback: TStringSubscriberCalback): IStringSubscriber;
  end;

implementation

function TStringSubscriber.ID: TSubscriberID;
begin
  Result := _Subscriber.ID;
end;

procedure TStringSubscriber.HandleEvent(const Event: IEvent<String>);
begin
  _Subscriber.HandleEvent(Event);
end;

constructor TStringSubscriber.Create(const Callback: TStringSubscriberCalback);
begin
  _Subscriber := TSubscriber<String>.New(Callback);
end;

constructor TStringSubscriber.CreateWithID(const ID: TSubscriberID; const Callback: TStringSubscriberCalback);
begin
  _Subscriber := TSubscriber<String>.NewWithID(ID, Callback);
end;

class function TStringSubscriber.New(const Callback: TStringSubscriberCalback): IStringSubscriber;
begin
  Result := TStringSubscriber.Create(Callback);
end;

class function TStringSubscriber.NewWithID(const ID: TSubscriberID; const Callback: TStringSubscriberCalback)
  : IStringSubscriber;
begin
  Result := TStringSubscriber.CreateWithID(ID, Callback);
end;

end.
