{$REGION 'documentation'}
{
  Copyright (c) 2016, Vencejo Software
  Distributed under the terms of the Modified BSD License
  The full license is distributed with this software
}
{
  Object to define a hub to propagate events between subscribers, using a filter to discriminate
  @created(04/12/2016)
  @author Vencejo Software <www.vencejosoft.com>
}
{$ENDREGION}
unit ooEventHub.BroadcastHub.Filtered;

interface

uses
  ooEventHub.Event,
  ooEventHub.Subscriber, ooEventHub.Subscriber.List,
  ooEventHub.Subscription.Path,
  ooEventHub.BroadcastHub;

type
{$REGION 'documentation'}
// @abstract(Type to define a callback filter before call subscriber)
{$ENDREGION}
  TOnBroadcastFilter<T> = reference to function(const Sender: TObject; const Subscriber: ISubscriber<T>;
    const Event: IEvent<T>): Boolean;

{$REGION 'documentation'}
{
  @abstract(Object to define a broadcast hub with filter capabilities)
  @member(
    ChangeFilter Change the current filter
    @param(Filter Reference to method for filter callback)
  )
}
{$ENDREGION}

  IBroadcastHubFiltered<T> = interface(IBroadcastHub<T>)
    ['{687BB7B7-B89F-443A-9D5D-0B54569AEF8B}']
    procedure ChangeFilter(const Filter: TOnBroadcastFilter<T>);
  end;
{$REGION 'documentation'}
{
  @abstract(Implementation of @link(IBroadcastHub))
  @member(Attach @seealso(IBroadcastHub.Attach))
  @member(Deattach @seealso(IBroadcastHub.Deattach))
  @member(Send @seealso(IBroadcastHub.Send))
  @member(SubscriptionPath @seealso(IBroadcastHub.SubscriptionPath))
  @member(ChangeFilter @seealso(IBroadcastHubFiltered.SubscriptionPath))
  @member(
    CanReceiveEvent Checks if a event can be handled by subscriber
    @param(Sender Event emitter object)
    @param(Subscriber Subscriber target of event)
    @param(Event Event object to filter)
    @return(@true if the subscriber can handle the event, @false if not)
  )
  @member(
    Create Object constructor
    @param(BroadcastHub Base broadcast hub to filter)
  )
  @member(
    New Create a new @classname as interface
    @param(BroadcastHub Base broadcast hub to filter)
  )
}
{$ENDREGION}

  TBroadcastHubFiltered<T> = class sealed(TInterfacedObject, IBroadcastHubFiltered<T>, IBroadcastHub<T>)
  strict private
    _BroadcastHub: IBroadcastHub<T>;
    _Filter: TOnBroadcastFilter<T>;
  private
    function CanReceiveEvent(const Sender: TObject; const Subscriber: ISubscriber<T>; const Event: IEvent<T>): Boolean;
  public
    function Attach(const ID: TEventID; const Subscriber: ISubscriber<T>): Boolean;
    function Deattach(const ID: TEventID; const Subscriber: ISubscriber<T>): Boolean;
    function SubscriptionPath: ISubscriptionPath<T>;
    procedure ChangeFilter(const Filter: TOnBroadcastFilter<T>);
    procedure Send(const Sender: TObject; const Event: IEvent<T>);
    constructor Create(const BroadcastHub: IBroadcastHub<T>);
    class function New(const BroadcastHub: IBroadcastHub<T>): IBroadcastHubFiltered<T>;
  end;

implementation

function TBroadcastHubFiltered<T>.Attach(const ID: TEventID; const Subscriber: ISubscriber<T>): Boolean;
begin
  Result := _BroadcastHub.Attach(ID, Subscriber);
end;

function TBroadcastHubFiltered<T>.Deattach(const ID: TEventID; const Subscriber: ISubscriber<T>): Boolean;
begin
  Result := _BroadcastHub.Deattach(ID, Subscriber);
end;

function TBroadcastHubFiltered<T>.SubscriptionPath: ISubscriptionPath<T>;
begin
  Result := _BroadcastHub.SubscriptionPath;
end;

function TBroadcastHubFiltered<T>.CanReceiveEvent(const Sender: TObject; const Subscriber: ISubscriber<T>;
  const Event: IEvent<T>): Boolean;
begin
  Result := not Assigned(_Filter) or (Assigned(_Filter) and _Filter(Sender, Subscriber, Event));
end;

procedure TBroadcastHubFiltered<T>.ChangeFilter(const Filter: TOnBroadcastFilter<T>);
begin
  _Filter := Filter;
end;

procedure TBroadcastHubFiltered<T>.Send(const Sender: TObject; const Event: IEvent<T>);
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
      if CanReceiveEvent(Sender, Subscriber, Event) then
        Subscriber.HandleEvent(Event);
  end;
end;

constructor TBroadcastHubFiltered<T>.Create(const BroadcastHub: IBroadcastHub<T>);
begin
  _BroadcastHub := BroadcastHub;
end;

class function TBroadcastHubFiltered<T>.New(const BroadcastHub: IBroadcastHub<T>): IBroadcastHubFiltered<T>;
begin
  Result := TBroadcastHubFiltered<T>.Create(BroadcastHub);
end;

end.
