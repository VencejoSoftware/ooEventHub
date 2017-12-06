{$REGION 'documentation'}
{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Object to define a hub to propagate events between subscribers
  @created(04/12/2016)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooEventHub.BroadcastHub;

interface

uses
  ooEventHub.Event,
  ooEventHub.Subscriber, ooEventHub.Subscriber.List,
  ooEventHub.Subscription.Path;

type

{$REGION 'documentation'}
{
  @abstract(Object to define a hub to propagate events between subscribers)
  @member(
    Attach Link the subscriber to the event ID
    @param(ID Event identifier)
    @param(Subscriber SubscriberObject)
    @return(@true if can attach subscriber to the event, @false if the subscriber is already attached)
  )
  @member(
    Deattach Remove link between the subscriber and the event ID
    @param(ID Event identifier)
    @param(Subscriber SubscriberObject)
    @return(@true if can deattach subscriber, @false if the subscriber not has a link to the event ID)
  )
  @member(
    SubscriptionPath Return the hub subscription path
    @return(A Subscription path object)
  )
  @member(
    Send Send a event to all his subscribers
    @param(Sender A sender object)
    @param(Event Event object to propagate)
  )
}
{$ENDREGION}
  IBroadcastHub<T> = interface
    ['{6E5D444A-1C9B-408B-899A-90A59C7F0496}']
    function Attach(const ID: TEventID; const Subscriber: ISubscriber<T>): Boolean;
    function Deattach(const ID: TEventID; const Subscriber: ISubscriber<T>): Boolean;
    function SubscriptionPath: ISubscriptionPath<T>;
    procedure Send(const Sender: TObject; const Event: IEvent<T>);
  end;

{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IBroadcastHub))
  @member(Attach @seealso(IBroadcastHub.Attach))
  @member(Deattach @seealso(IBroadcastHub.Deattach))
  @member(SubscriptionPath @seealso(IBroadcastHub.SubscriptionPath))
  @member(Send @seealso(IBroadcastHub.Send))
  @member(Create Object constructor)
  @member(New Create a new @classname as interface)
}
{$ENDREGION}

  TBroadcastHub<T> = class sealed(TInterfacedObject, IBroadcastHub<T>)
  strict private
    _Path: ISubscriptionPath<T>;
  public
    function Attach(const ID: TEventID; const Subscriber: ISubscriber<T>): Boolean;
    function Deattach(const ID: TEventID; const Subscriber: ISubscriber<T>): Boolean;
    function SubscriptionPath: ISubscriptionPath<T>;
    procedure Send(const Sender: TObject; const Event: IEvent<T>);
    constructor Create;
    class function New: IBroadcastHub<T>;
  end;

implementation

function TBroadcastHub<T>.Attach(const ID: TEventID; const Subscriber: ISubscriber<T>): Boolean;
var
  Subscribers: ISubscriberList<T>;
begin
  Subscribers := _Path.SubscribersByID(ID);
  Result := Subscribers.Add(Subscriber) > -1;
end;

function TBroadcastHub<T>.Deattach(const ID: TEventID; const Subscriber: ISubscriber<T>): Boolean;
var
  Subscribers: ISubscriberList<T>;
begin
  Subscribers := _Path.SubscribersByID(ID);
  Result := Subscribers.Remove(Subscriber) > -1;
end;

function TBroadcastHub<T>.SubscriptionPath: ISubscriptionPath<T>;
begin
  Result := _Path;
end;

procedure TBroadcastHub<T>.Send(const Sender: TObject; const Event: IEvent<T>);
var
  Subscribers: ISubscriberList<T>;
  Subscriber: ISubscriber<T>;
  i: Cardinal;
begin
  Subscribers := SubscriptionPath.SubscribersByID(Event.ID);
  for i := 0 to Pred(Subscribers.Count) do
  begin
    Subscriber := Subscribers.Subscriber(i);
    if Assigned(Subscriber) then
      Subscriber.HandleEvent(Event);
  end;
end;

constructor TBroadcastHub<T>.Create;
begin
  _Path := TSubscriptionPath<T>.New;
end;

class function TBroadcastHub<T>.New: IBroadcastHub<T>;
begin
  Result := TBroadcastHub<T>.Create;
end;

end.
